<?php

namespace DruiD628\Type\Base\Contracts;

use ArrayAccess;
use Iterator;

interface ArrayInterface extends ArrayAccess, Iterator
{

    function count(): int;

    function rewind();

    function valid();

    function key();

    function next();

    // not part of Iterator
    function prev();

    function current();

    function offsetUnset($offset);

    function offsetSet($offset, $value);

    function offsetGet($offset);

    function offsetExists($offset);
}