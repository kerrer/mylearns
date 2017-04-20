n=11;
basename="1-"
for file in *.mp4 ; do mv   "${file}"  $basename"${n}".mp4; n=$((n+1));  done


n=11;
basename="1-"

for file in *.csf ; do name=$(echo $file | grep -o1 -Ei '([0-9]{2})'); mv "${file}" $basename$name.csf; n=$((n+1));  done


for file in *.csf ; do name=$(echo $file | grep -o1 -Ei '([0-9]{2})'); echo $name; done


for file in *.mp4 ; do name=$(echo $file | grep -o1 -Ei '([0-9]{2})'); mv   "${file}"  $basename$name.mp4;  done

for file in *.wmv ; do name=$(echo $file | grep -o1 -Ei '([0-9]{2})'); mv   "${file}"  $basename$name.wmv;  done

for file in *.mp3; do name=$(echo $file | grep -o1 -Ei '([0-9]{1,2}-[0-9]{1,2})'); mv   "${file}"   $name.mp3;  done


for file in *.mp3; do name=$(echo $file | grep -o1 -Ei '([0-9]{1,2}-[0-9]{1,2})'); mv   "${file}"   0$name.mp3;  done
