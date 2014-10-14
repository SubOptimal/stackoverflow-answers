package sub.optimal.slf4jdemo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

class Temp {

    public int someMethod() {
        Logger logger = LoggerFactory.getLogger(Temp.class);
        logger.info("Some information");//NullPointerException
        return 0;
    }
}
