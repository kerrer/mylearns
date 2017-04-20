<?php
/**
 * 
 * 先将csv文件另存为gbk编码
 * 
*/
ini_set("auto_detect_line_endings", true);
setlocale(LC_ALL, 'zh');
$row = 1;
if (($handle = fopen("112.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 0, ",")) !== FALSE) { var_dump($data);
        $num = count($data);
        echo "<p> $num fields in line $row: <br /></p>\n";
        $row++;
        for ($c=0; $c < $num; $c++) {
            //var_dump($data[$c]);
        }
    }
    fclose($handle);
}
?>
