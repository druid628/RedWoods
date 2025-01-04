<?php

namespace DruiD628\Type\Base;

use DruiD628\Exceptions\InvalidKeyTypeException;
use DruiD628\Type\{String628};
use DruiD628\Type\Base\Contracts\HashTableInterface;
use DruiD628\Type\Base\Contracts\StringInterface;
use \Exception;

class AbstractHashTable implements HashTableInterface
{
    /** @var bool $readOnly */
    protected $readOnly;

    /** @var int $position position sentinel variable */
    protected $position;

    /** @var array $data */
    protected $data;

    /** @var int $fixedSize locking a HashTable to a fixed size */
    protected $fixedSize;

    public function __construct($data = [], $readOnly = false, $fixedSize = null)
    {
        if (!$this->validateKeys($data)) {
            throw new InvalidKeyTypeException("Invalid Key type for HashTable");
        }
        if (is_int($fixedSize)) {
            if (count($data) < $fixedSize) {
                $data = array_pad($data, $fixedSize, 0);
            } elseif (count($data) > $fixedSize) {
                throw new Exception('HashTable data size is larger than defined size');
            }
        } elseif (is_bool($fixedSize) && $fixedSize) {
            $fixedSize = count($data);
        }

        $this->data      = $data;
        $this->position  = 0;
        $this->readOnly  = $readOnly;
        $this->fixedSize = $fixedSize;
    }

    /**
     * @param string $key
     * @param mixed $value
     *
     * @return $this
     * @throws InvalidKeyTypeException
     *
     */
    public function add($key, $value)
    {
        return $this->offsetSet($key, $value);
    }

    /**
     * @param $key
     *
     * @return mixed
     */
    public function get($key)
    {
        return $this->offsetGet($key);
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
        if ($this->offsetExists($offset)) {
            return $this->data[$offset];
        }

        return false;
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
     * @return $this
     * @since 5.0.0
     * @throws InvalidKeyTypeException
     */
    public function offsetSet($offset, $value)
    {
        if ($this->isReadOnly()) {
            return false;
        }

        if (!$this->offsetExists($offset) &&
            $this->isFixedSize() &&
            $this->count() == $this->fixedSize
           ) {

            return false;
        }
        if (!$this->validateKey($offset)) {
            throw new InvalidKeyTypeException(sprintf("Invalid Key type (%s) for HashTable", gettype($offset)));
        }

        $this->data[$offset] = $value;

        return $this;
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
     *
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
     *
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

    /**
     * Return an array of keys
     *
     * @return array
     */
    public function getKeys()
    {
        return array_keys($this->data);
    }

    /**
     * Return an array of values
     *
     * @return array
     */
    public function getValues()
    {
        return array_values($this->data);
    }

    /**
     * Is this HashTable readOnly?
     *
     * @return bool
     */
    public function isReadOnly()
    {
        return $this->readOnly;
    }

    /**
     * Locks HashTable to current size
     *
     * @return $this
     */
    public function lockSize()
    {
        $this->fixedSize = $this->count();

        return $this;
    }

    public function isFixedSize()
    {
        return !(is_null($this->fixedSize));
    }

    /**
     * @param array $dataSet
     *
     * @return bool
     */
    protected function validateKeys(array $dataSet)
    {
        foreach (array_keys($dataSet) as $key) {
            if (!($this->validateKey($key))) {
                return false;
            }
        }

        return true;
    }

    /**
     * @param $key
     *
     * @return bool
     */
    protected function validateKey($key)
    {
        return is_string($key);
    }
}