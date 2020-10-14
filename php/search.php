<?php

$someLists = array(
    'Fruits' => ['banana', 'mango', 'apple', 'plum'],
    'Vegetables' => ['broccoli', 'spinach', 'peas'],
    'Super Fruits' => ['cranberries', 'dragon fruit'],
    'Grains' => ['rice', 'oat', 'wheat']
);

$search_keyword = isset($_GET['search_keyword']) ? trim($_GET['search_keyword']) : '';

$results = array();

$keys = array_keys($someLists);
foreach ($someLists as $key => $value) {

    if(stristr($key, $search_keyword)){
        //Add it to the results array.
        $results[$key] = $value;
    }
}

echo json_encode([$results]);
