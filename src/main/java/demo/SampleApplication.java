package demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class SampleApplication {

	public static void main(String[] args) {
		SpringApplication.run(SampleApplication.class, args);
	}

	@GetMapping("/test")
    public String io() throws InterruptedException {
        long sleepDuration = 200L + (long) (500L * Math.random());
        Thread.sleep(sleepDuration);
        return "done after " + sleepDuration + "ms";
    }

}
