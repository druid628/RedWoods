<?php

namespace DruiD628\Type\Base;

use DruiD628\Exceptions\InvalidKeyTypeException;
use DruiD628\Type\Base\Contracts\ArrayInterface;
use DruiD628\Type\Base\Contracts\StringInterface;
use DruiD628\Type\String628;

class AbstractArray implements ArrayInterface
{
    /** @var boolean $strict */
    protected $strict;
    /** @var int $position position sentinel variable */
    protected $position;
    /** @var array $data */
    protected $data;

    public function __construct($data = [], $strict = true)
    {
        $this->strict = $strict;
        if (!$this->validateKeys($data)) {
            throw new InvalidKeyTypeException("Invalid Key type for Array");
        }
        $this->data     = $data;
        $this->position = 0;
    }

    /**
     * Get a count of the elements of the array
     *
     * @return int
     */
    public function count(): int
    {
        return count($this->data);
    }

    /**
     * Move forward to previous element
     *
     * @return void Any returned value is ignored.
     */
    public function prev(): void
    {
        --$this->position;
    }

    /**
     * @param string $glue default: ' '
     *
     * @return StringInterface
     */
    public function implode($glue = ' '): StringInterface
    {
        return new String628(join($glue, $this->data));
    }

    // region Contractual Obligations

    /**
     * Whether a offset exists
     * @link https://php.net/manual/en/arrayaccess.offsetexists.php
     * @param mixed $offset <p>
     * An offset to check for.
     * </p>
     * @return boolean true on success or false on failure.
     * </p>
     * <p>
     * The return value will be casted to boolean if non-boolean was returned.
     * @since 5.0.0
     */
    public function offsetExists($offset)
    {
        return (isset($this->data[$offset]));
    }

    /**
     * Offset to retrieve
     * @link https://php.net/manual/en/arrayaccess.offsetget.php
     * @param mixed $offset <p>
     * The offset to retrieve.
     * </p>
     * @return mixed Can return all value types.
     * @since 5.0.0
     */
    public function offsetGet($offset)
    {
        return $this->data[$offset];
    }

    /**
     * Offset to set
     * @link https://php.net/manual/en/arrayaccess.offsetset.php
     * @param mixed $offset <p>
     * The offset to assign the value to.
     * </p>
     * @param mixed $value <p>
     * The value to set.
     * </p>
     * @return void
     * @since 5.0.0
     */
    public function offsetSet($offset, $value)
    {
        if ($this->isStrict() && !$this->validateKey($offset)) {
            throw new InvalidKeyTypeException(sprintf("Invalid Key type (%s) for Array", gettype($offset)));
        }

        return $this->data[$offset] = $value;
    }

    /**
     * Offset to unset
     * @link https://php.net/manual/en/arrayaccess.offsetunset.php
     * @param mixed $offset <p>
     * The offset to unset.
     * </p>
     * @return void
     * @since 5.0.0
     */
    public function offsetUnset($offset): void
    {
        unset($this->data[$offset]);
    }

    /**
     * Return the current element
     * @link https://php.net/manual/en/iterator.current.php
     * @return mixed Can return any type.
     * @since 5.0.0
     */
    public function current()
    {
        return ($this->valid()) ? array_values($this->data)[$this->position] : false;
    }

    /**
     * Move forward to next element
     * @link https://php.net/manual/en/iterator.next.php
     * @return void Any returned value is ignored.
     * @since 5.0.0
     */
    public function next()
    {
        ++$this->position;
    }

    /**
     * Return the key of the current element
     * @link https://php.net/manual/en/iterator.key.php
     * @return mixed scalar on success, or null on failure.
     * @since 5.0.0
     */
    public function key()
    {
        return array_keys($this->data)[$this->position];
    }

    /**
     * Checks if current position is valid
     * @link https://php.net/manual/en/iterator.valid.php
     * @return boolean The return value will be casted to boolean and then evaluated.
     * Returns true on success or false on failure.
     * @since 5.0.0
     */
    public function valid()
    {
        return isset(array_values($this->data)[$this->position]);
    }

    /**
     * Rewind the Iterator to the first element
     * @link https://php.net/manual/en/iterator.rewind.php
     * @return void Any returned value is ignored.
     * @since 5.0.0
     */
    public function rewind()
    {
        $this->position = 0;
    }
    // endRegion

    /**
     * @return array
     */
    public function getData(): array
    {
        return $this->data;
    }

    /**
     * @param array $data
     */
    public function setData(array $data)
    {
        $this->data = $data;
    }

    public function isStrict()
    {
        return $this->strict;
    }

    protected function validateKeys(array $dataSet)
    {
        if ($this->isStrict()) {
            foreach (array_keys($dataSet) as $key) {
                if (!($this->validateKey($key))) {
                    return false;
                }
            }
        }

        return true;
    }

    protected function validateKey($key)
    {
        return is_int($key);
    }
}