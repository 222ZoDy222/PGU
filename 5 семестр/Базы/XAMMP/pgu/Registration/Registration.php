<?php 

include '../DataBaseConnection/DataBaseConnection.php';

class SimpleClass
{
    // property declaration
    public $var = 'a default value';

    public $name = 'Nikita';
    
}

$obj = new SimpleClass();

echo json_encode($obj);


 ?>