<?php 

$hostname = "localhost";
$username = "root";
$password = "";
$databaseName = "mydb";

$link = mysqli_connect($hostname, $username, $password, $databaseName);


if ($link == false){
	// Ошибка: Невозможно подключиться к MySQL 
    echo("0");
    exit;
}

//Соединение установлено успешно
    




 ?>