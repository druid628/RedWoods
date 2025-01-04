<?PHP

namespace DruiD628\Utilities;

class CSVUtil
{

    /**
     * Nice String output replacement form fputcsv
     * code taken from: http://www.php.net/manual/en/function.fputcsv.php#96937
     *
     * @param $row
     * @param string $delimiter
     * @param string $enclosure
     * @param string $eol
     *
     * @return bool|string
     */
    public static function sputcsv($row, $delimiter = ',', $enclosure = '"', $eol = "\n")
    {
        static $fp = false;
        if ($fp === false) {
            $fp = fopen('php://temp', 'r+'); // see http://php.net/manual/en/wrappers.php.php - yes there are 2 '.php's on the end.
            // NB: anything you read/write to/from 'php://temp' is specific to this filehandle
        } else {
            rewind($fp);
        }

        if (fputcsv($fp, $row, $delimiter, $enclosure) === false) {
            return false;
        }

        rewind($fp);
        $csv = fgets($fp);

        if ($eol != PHP_EOL) {
            $csv = substr($csv, 0, (0 - strlen(PHP_EOL))) . $eol;
        }

        return $csv;
    }

}
