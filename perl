perl -pi.bak -e 's/you/me/g' file
perl -pi -e 's/you/me/g if /we/' file
perl -pi -e 's/you/me/g if /\d/' file
perl -ne 'print if $a{$_}++' file
perl -ne 'print "$. $_"' file
perl -pe '$_ = "$. $_"' file
