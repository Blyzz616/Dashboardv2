#!/bin/bash

# Get yr.no graph, edit it up and save it as yr.svg

curl https://www.yr.no/en/content/2-7669018/meteogram.svg -o /var/www/html/img/metrogram.svg
xmlstarlet ed \
  -d "/*[local-name()='svg']/*[
        not(
          local-name()='style'
          or
          (local-name()='g' and not(following-sibling::*[local-name()='g']))
        )
      ]" \
  -d "/*[local-name()='svg']/*[local-name()='g']/*[local-name()='g'][last()]" \
  -d "/*[local-name()='svg']/*[local-name()='g']/@transform" \
  -u "/*[local-name()='svg']/@style" -v "background-color:transparent" \
  /var/www/html/img/metrogram.svg > /var/www/html/img/metrogram.final.svg
sed -i 's/c3d0d8/444444/g' /var/www/html/img/metrogram.final.svg
sed -i -E '/\.(location-header|served-by-header|legend-label)[[:space:]]*\{/,/\}/d' /var/www/html/img/metrogram.final.svg
sed -i -E 's/#ffffff/transparent/' /var/www/html/img/metrogram.final.svg
mv /var/www/html/img/metrogram.final.svg /var/www/html/img/yr.svg
chown www-data:www-data /var/www/html/img/yr.svg
sleep 270
rm /var/www/html/img/yr.svg
