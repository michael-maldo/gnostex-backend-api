package app.gnostex.gnostexbackendapi;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(
        properties = {
                "spring.autoconfigure.exclude=org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration"
        }
)
class GnostexBackendApiApplicationTests {

    @Test
    void contextLoads() {
    }

}
