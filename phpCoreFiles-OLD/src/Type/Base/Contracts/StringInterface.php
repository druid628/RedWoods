<?php

namespace DruiD628\Type\Base\Contracts;

interface StringInterface
{

    /**
     * @return int
     */
    public function length() : int;

    /**
     * Explode to  ArrayInterface object
     *
     * @param string $delimiter
     * @param int $limit
     *
     * @return ArrayInterface
     */
    public function explode($delimiter = '', $limit = PHP_INT_MAX) : ArrayInterface;

    /**
     * Determine if string has value
     *
     * @return bool
     */
    public function hasValue() : bool;

    /**
     * Get value of String object0
     *
     * @return string
     */
    public function getValue() : string;

    /**
     * @param string $value
     *
     * @return StringInterface
     */
    public function setValue($value) : StringInterface;

    /**
     * @return string
     */
    public function __toString(): string;
}