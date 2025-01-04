<?PHP

namespace druid628\campfires\traitdemo;

abstract class User
{

    /** @var string hashed token */
    protected $token;

    /**
     * @param string|null $username
     */
    public function __construct($username = null)
    {
        $this->username = $username;
    }

    /**
     * @return string
     */
    protected function generateSalt()
    {
        $dto  = new \DateTime();
        $salt = "023jd03" . $dto->format('mdY') . "lkjf39j";
        return $salt;
    }

    /**
     * @param string $token
     *
     * @return $this
     */
    public function setToken($token)
    {
        $this->token = $token;

        return $this;
    }

    /**
     * @return string
     */
    public function getToken()
    {

        return $this->token;
    }

    /**
     * @param string $username
     *
     * @return $this
     */
    public function setUsername($username)
    {
        $this->username = $username;

        return $this;
    }

    /**
     * @return string
     */
    public function getUsername()
    {
        return $this->username;
    }

}
