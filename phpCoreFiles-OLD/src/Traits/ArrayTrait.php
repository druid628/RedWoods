<?php

namespace DruiD628\Traits;

trait ArrayTrait
{

    /**
     * sum values in array by key
     *
     * @param array $arr
     * @param string [optional]$index
     * @return int result
     *
     * source: http://www.php.net/manual/en/function.array-sum.php#85548
     */
    public function sumByKey($arr, $index = null)
    {
        if (!is_array($arr) || sizeof($arr) < 1) {
            return 0;
        }
        $ret = 0;
        foreach ($arr as $id => $data) {
            if (isset($index)) {
                $ret += (isset($data[$index])) ? $data[$index] : 0;
            } else {
                $ret += $data;
            }
        }

        return $ret;
    }

    /**
     *
     * Takes an array test to see if it is multi-dimensional.
     * Great for use before using array_diff
     * example:
     * $x = arary(1, array(2,3,4), 5, 6);
     * $y = arary(1, array(7,8), 5, 6);
     * $z = arary(1, 'Array', 5, 6);
     *
     * empty(array_diff($x, $y)); // returns true
     * empty(array_diff($y, $z)); // returns true
     *
     * array_diff() does a toString() on every entity in the array so multi-dim arrays return the string "Array"
     * thanks to @epochblue for that find
     *
     * @param array $array
     * @return boolean
     */
    public function isMulti($array)
    {
        return (bool)(count($array) != count($array, COUNT_RECURSIVE));
    }
}