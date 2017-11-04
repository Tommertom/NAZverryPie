<?php

// first try to include the existing items (if any) and backup the old config
if (file_exists('/var/www/nazverrypie/config.php')) {
	include '/var/www/nazverrypie/config.php';
	unlink('/var/www/nazverrypie/config.php.bak');
	rename('/var/www/nazverrypie/config.php','/var/www/nazverrypie/config.php.bak');
};

// include the data created for this nazverrypie shell run
include 'configmenu_new.php';

// lets create the new configuration 
$fp=fopen('/var/www/nazverrypie/config.php','w');

fwrite($fp, "<?php \n");

// put the general configuration items stored in $nazverrypie array
foreach ($nazverrypie as $key => $value) {
	$line="\$nazverrypie['".$key."']='$value';\n";
	//echo $line;
	fwrite($fp, $line);
}


// put the menu items stored in $nazverrymenu array
foreach ($menu_text as $key => $value) {
	$line="\$menu_text['".$key."']='$value';\n";
	//echo $line;
	fwrite($fp, $line);
}

// put the menu items stored in $nazverrymenu array
foreach ($menu_url as $key => $value) {
	$line="\$menu_url['".$key."']='$value';\n";
	//echo $line;
	fwrite($fp, $line);
}

// put the menu items stored in $nazverrymenu array
foreach ($menu_class as $key => $value) {
	$line="\$menu_class['".$key."']='$value';\n";
	//echo $line;
	fwrite($fp, $line);
}

// close the config file
fwrite($fp, "?>");
fclose($fp);


// create the HTML
//echo "Creating the HTML";
?>

<html>
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
<link rel="icon" href="favicon.ico" type="image/x-icon">
<head><title><?php echo $nazverrypie['titlename']; ?></title></head>
<link rel="stylesheet" type="text/css" href="<?php echo $nazverrypie['css']; ?>">
<center>
<table>
<tr height="200px">
<td class="nazverrypie"><h2><center>Welcome to NAZverryPie - with cream</h2>The user friendly recipe to a delicious and tasty home NAS</center></td>

<?php

//insert the tiles

$tile_column=2;
$text_counter=1;

foreach ($menu_text as $key => $value) 
{
	//amend the text class to reflect various styles
	if ($menu_class[$key] == "text") {
		$menu_class[$key]='text'.$text_counter;
		$text_counter++;
		if ($text_counter == 8) $text_counter=1;
	}
	
	// output the tile
	echo '<td class="'.$menu_class[$key].'" onclick="window.open('."'".$menu_url[$key]."'".','."'".'_blank'."'".')">'.$menu_text[$key].'</td>';
	echo "\n";
	$tile_column++;
	
	// are we at the end of the row? start over
	if ($tile_column == 5) {
		$tile_column=1;
		
		echo "</tr>\n";
		echo '<tr height="200px">';	
	}
}

// fill up the empty tile spaces
do {
	echo '<td class="text'.$text_counter.'">#</td>';
	echo "\n";

	$text_counter++;
	if ($text_counter == 8) $text_counter=1;

	$tile_column++;
} while ($tile_column<5);
?>

</tr>
</table>
<h3>(C) TomGrun - MIT License - <a href="https://sourceforge.net/p/nazverrypie/wiki/Home/">NAZverryPie - with Cream home</a></h3>
</center>
</html>