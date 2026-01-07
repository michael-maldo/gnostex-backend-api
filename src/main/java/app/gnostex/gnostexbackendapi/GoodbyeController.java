package app.gnostex.gnostexbackendapi;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class GoodbyeController {
    @GetMapping("/goodbye")
    public String goodbye() {
        return "Gnostex backend <br/>" +
                "/api/goodbye is running!!!";
    }
}
