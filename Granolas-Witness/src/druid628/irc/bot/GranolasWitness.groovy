package druid628.irc.bot;

@Grab("pircbot:pircbot:1.5.0")
import org.jibble.pircbot.*

class GranolasWitness extends PircBot
{
    def config;
    def admin = "micahB1";

    GranolasWitness(config)
    {
      this.setName(config.name);
      this.setVerbose(config.verbose);
      this.connect(config.server);
      config.channels.each { channel ->
        this.joinChannel channel
      }

      this.config = config;
    }


    void onPrivateMessage(String sender, String login, String hostname, String message)
    {
        if ( message == "quit" && sender == this.admin ) {
            this.quitServer("${this.admin} told me to");
        }
    }

    void onMessage(String channel, String sender, String login, String hostname, String message) 
    {
        if( message =~ name ) {
            // sendNotice channel, "You said: $message";
            sendMessage channel, "May I help you?";
        }
    }

    void onOp(String channel, String sourceNick, String sourceLogin, String sourceHostname, String recipient) 
    {
        sendMessage channel, "Thank you so much!";
    }

}
