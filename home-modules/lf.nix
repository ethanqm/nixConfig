{config, pkgs, ...}:
{
  programs.lf = {
    enable = true;
    extraConfig = ''
      # EXTRA

      # show MIMEType info
      ## wait for #2186 ruler file to be merged
      map m %xdg-mime query filetype $f
    '';
    previewer = {
      keybinding = "i";
      #source = pkgs.writeShellScript "lfpreview.sh" ''
      #  notify-send "${pkgs.ranger}/share/doc/ranger/config/scope.sh"
      #  ${pkgs.ranger}/share/doc/ranger/config/scope.sh "''${1}""''${2}""''${3}" "" "" || true
      #''; ## currently broken sad

      source = pkgs.writeShellScript "lfpreview.sh" ''
        #!/usr/bin/env bash

        # Video info
        videoprev() {
          INF=$(mediainfo --Output=JSON "$1")

          sec=$(echo $INF | jq -r '.media.track.[0].Duration')
          duration=$(printf '  Duration: %02d:%02d:%02.f\n' $(echo -e "$sec/3600\n$sec%3600/60\n$sec%60" | bc))

          vid="$(echo "$INF" | jq '.media.track.[1] | {
            Resolution: "\(.Width)x\(.Height)", 
            FPS: .FrameRate, 
            "Colour Depth": .BitDepth, 
            Encode: .Encoded_Library
            }
          ')"

          lang="$(echo $INF | jq -j -c '[.media.track.[] | {T: ."@type", Language}] | .[2:] |
             reduce .[] as {$T, $Language} ({audio: [], subs: []}; 
               if ($T == "Audio") then .audio += [$Language]
                 elif ($T == "Text") then .subs += [$Language] end)' |
                  sed "s/null/UNK/g" | sed "s/],//g" )"

          echo "$((echo "$vid" && echo "$duration" && echo "$lang") |
            sed "s/subs/\nsubs/" | 
            sed "s/[{}[]]*//g" | sed 's/"//g' )"
        }
        
        # Database preview func
        # courtesy ranger/scope.sh GPL3
        ## Preview as text conversion
        FILE_PATH="$1"
        SQLITE_TABLE_LIMIT=20
        SQLITE_ROW_LIMIT=5
        PV_WIDTH=35
        sqlprev() {  
          sqlite_tables="$( sqlite3 "file:''${FILE_PATH}?mode=ro" '.tables' )" \
            || exit 1
          [ -z "''${sqlite_tables}" ] &&
            { echo "Empty SQLite database." && exit 5; }
          sqlite_show_query() {
            sqlite-utils query "''${FILE_PATH}" "''${1}" --table --fmt fancy_grid \
            || sqlite3 "file:''${FILE_PATH}?mode=ro" "''${1}" -header -column
          }
          ## Display basic table information
          sqlite_rowcount_query="$(
            sqlite3 "file:''${FILE_PATH}?mode=ro" -noheader \
              'SELECT group_concat(
                "SELECT """ || name || """ AS tblname,
                          count(*) AS rowcount
                 FROM " || name,
                " UNION ALL "
              )
              FROM sqlite_master
              WHERE type="table" AND name NOT LIKE "sqlite_%";'
          )"
          sqlite_show_query \
            "SELECT tblname AS 'table', rowcount AS 'count',
            (
              SELECT '(' || group_concat(name, ', ') || ')'
              FROM pragma_table_info(tblname)
            ) AS 'columns',
            (
              SELECT '(' || group_concat(
                upper(type) || (
                  CASE WHEN pk > 0 THEN ' PRIMARY KEY' ELSE ''' END
                ),
                ', '
              ) || ')'
              FROM pragma_table_info(tblname)
            ) AS 'types'
            FROM (''${sqlite_rowcount_query});"
          if [ "''${SQLITE_TABLE_LIMIT}" -gt 0 ] &&
             [ "''${SQLITE_ROW_LIMIT}" -ge 0 ]; then
            ## Do exhaustive preview
            echo && printf '>%.0s' $( seq "''${PV_WIDTH}" ) && echo
            sqlite3 "file:''${FILE_PATH}?mode=ro" -noheader \
              "SELECT name FROM sqlite_master
              WHERE type='table' AND name NOT LIKE 'sqlite_%'
              LIMIT ''${SQLITE_TABLE_LIMIT};" |
              while read -r sqlite_table; do
                sqlite_rowcount="$(
                  sqlite3 "file:''${FILE_PATH}?mode=ro" -noheader \
                    "SELECT count(*) FROM ''${sqlite_table}"
                )"
                echo
                if [ "''${SQLITE_ROW_LIMIT}" -gt 0 ] &&
                   [ "''${SQLITE_ROW_LIMIT}" \
                   -lt "''${sqlite_rowcount}" ]; then
                  echo "''${sqlite_table} [''${SQLITE_ROW_LIMIT} of ''${sqlite_rowcount}]:"
                  sqlite_ellipsis_query="$(
                    sqlite3 "file:''${FILE_PATH}?mode=ro" -noheader \
                      "SELECT 'SELECT ' || group_concat(
                        '''...''', ', '
                      )
                      FROM pragma_table_info(
                        ''\'''${sqlite_table}'
                      );"
                  )"
                  sqlite_show_query \
                    "SELECT * FROM (
                      SELECT * FROM ''${sqlite_table} LIMIT 1
                    )
                    UNION ALL ''${sqlite_ellipsis_query} UNION ALL
                    SELECT * FROM (
                      SELECT * FROM ''${sqlite_table}
                      LIMIT (''${SQLITE_ROW_LIMIT} - 1)
                      OFFSET (
                        ''${sqlite_rowcount}
                        - (''${SQLITE_ROW_LIMIT} - 1)
                      )
                    );"
                else
                  echo "''${sqlite_table} [''${sqlite_rowcount}]:"
                  sqlite_show_query "SELECT * FROM ''${sqlite_table};"
                fi
              done
          fi
        }

        case "$(xdg-mime query filetype "$1")" in
          text/*) cat "$1";;
          image/*) exiftool "$1";;
          video/*) videoprev "$1";;
          application/json) cat "$1";;
          application/toml) cat "$1";;
          application/yaml) cat "$1";;
          application/xml) cat "$1";;
          application/x-shellscript) cat "$1";;
          application/x-csh) cat "$1";;
          application/x-fishscript) cat "$1";;
          application/x-powershell) cat "$1";;
          application/x-bat) cat "$1";;
          application/x-gdscript) cat "$1";;
          application/x-executable) (readelf -h "$1" && lddtree "$1") | sed "s/^    //";;
          application/x-sharedlib) (readelf -h "$1" && lddtree "$1") | sed "s/^    //";;
          application/x-bittorrent) transmission-show "$1" | sed '/Privacy/,/FILES/{//!d;s/FILES//}';;
          application/vnd.appimage) (readelf -h "$1" && lddtree "$1") | sed "s/^    //";;
          application/vnd.debian.binary-package) (dpkg-deb -I "$1" && dpkg-deb -c "$1");;
          application/x-ms-shortcut) (strings "$1" | grep "[A-Z]:");;
          application/vnd.sqlite3) sqlprev "$1";;
          application/vnd.android.package-archive) unzip -l "$1";; # could do better
          application/zip) als "$1";;
          application/x-zstd-compressed-tar) als "$1";;
          application/vnd.comicbook*) als "$1";; # not working
          application/vnd.epub+zip) als "$1";; # not working
          application/vnd.rar) als "$1";;
          application/x-rar-compressed) als "$1";;
          application/vnd.gzip) als "$1";;
          application/gzip) als "$1";;
          application/x-compressed-tar) als "$1";;
          application/x-xz-compressed-tar) als "$1";;
          application/x-7z-compressed) als "$1";;
          application/x-zip-compressed) als "$1";;
          application/msword) catdoc "$1";;
          application/vnd.msexcel) xls2csv -- "$1";;
          application/pdf) pdftotext -l 10 -nopgbrk -q -- "$1" - | fmt -w "35";;
          application/vnd.oasis.spreadsheetml.sheet) xlsx2csv -- "$1";;
          application/vnd.openxmlformats-officedocument.wordprocessingml.document) pandoc -s -t markdown -- "$1";;
          message/rfc822) mu view -- "$1";; # email files
          *) (echo "UNHANDLED" && xdg-mime query filetype "$1");;
        esac
      '';
    };
  };
}
