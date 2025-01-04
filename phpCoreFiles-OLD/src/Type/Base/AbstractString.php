<?php

namespace DruiD628\Type\Base;

use DruiD628\Type\Array628;
use DruiD628\Type\Base\Contracts\{ ArrayInterface, StringInterface };

class AbstractString implements StringInterface
{
    protected $value;

    public function __construct($value = null)
    {
        $this->value = $value;
    }

    /**
     * @inheritDoc
     */
    public function length(): int
    {
        return strlen($this->value);
    }

    /**
     * Convert string to UPPER CASE
     *
     * @return string
     */
    public function upper(): string
    {
        return strtoupper($this->getValue());
    }

    /**
     * Convert string to lower case
     *
     * @return string
     */
    public function lower(): string
    {
        return strtolower($this->getValue());
    }

    /**
     * @inheritDoc
     */
    public function explode($delimiter = '', $limit = PHP_INT_MAX): ArrayInterface
    {
        return new Array628(explode($delimiter, $this->getValue(), $limit));
    }

    /**
     * @inheritDoc
     */
    public function __toString(): string
    {
        return $this->getValue();
    }

    /**
     * @inheritDoc
     */
    public function getValue(): string
    {
        return $this->value;
    }

    /**
     * @inheritDoc
     */
    public function hasValue(): bool
    {
        return !(is_null($this->value));
    }

    /**
     * @inheritDoc
     */
    public function setValue($value): StringInterface
    {
        $this->value = $value;

        return $this;
    }

}