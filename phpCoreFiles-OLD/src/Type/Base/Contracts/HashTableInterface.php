<?php


namespace DruiD628\Type\Base\Contracts;

use ArrayAccess;
use Iterator;

interface HashTableInterface extends ArrayAccess, Iterator
{
    function add($key, $value);

    function get($key);

    function getKeys();

    function getValues();

    function count(): int;

    function isReadOnly();

    // Iterator
    function rewind();

    function valid();

    function key();

    function next();

    // not part of Iterator
    function prev();

    function current();

    // ArrayAccess
    function offsetUnset($offset);

    function offsetSet($offset, $value);

    function offsetGet($offset);

    function offsetExists($offset);

}