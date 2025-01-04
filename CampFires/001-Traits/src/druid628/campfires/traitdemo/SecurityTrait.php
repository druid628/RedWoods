<?PHP

namespace druid628\campfires\traitdemo;

trait SecurityTrait
{

    // these encrypt/decrypt functions are jacked from: http://www.php.net/manual/es/book.mcrypt.php#107483
    public function encrypt($decrypted, $salt)
    {

        $key = hash('SHA256', $salt, true);
        srand();
        $iv = mcrypt_create_iv(mcrypt_get_iv_size(MCRYPT_RIJNDAEL_128, MCRYPT_MODE_CBC), MCRYPT_RAND);

        if (strlen($iv_base64 = rtrim(base64_encode($iv), '=')) != 22) {
            return false;
        }
        $encrypted = base64_encode(
            mcrypt_encrypt(MCRYPT_RIJNDAEL_128, $key, $decrypted . md5($decrypted), MCRYPT_MODE_CBC, $iv)
        );

        return $iv_base64 . $encrypted;
    }

    public function decrypt($encrypted, $salt)
    {
        $key = hash('SHA256', $salt, true);
        $iv  = base64_decode(substr($encrypted, 0, 22) . '==');

        $encrypted = substr($encrypted, 22);
        $decrypted = rtrim(
            mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $key, base64_decode($encrypted), MCRYPT_MODE_CBC, $iv),
            "\0\4"
        );

        $hash = substr($decrypted, -32);
        $decrypted = substr($decrypted, 0, -32);

        if (md5($decrypted) != $hash) {

            return false;
        }

        return $decrypted;
    }

} // security trait
