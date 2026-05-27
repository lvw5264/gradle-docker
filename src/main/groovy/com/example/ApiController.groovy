// src/main/groovy/com/example/ApiController.groovy
package com.example

import io.micronaut.http.annotation.Controller
import io.micronaut.http.annotation.Get
import io.micronaut.http.annotation.Produces
import io.micronaut.http.MediaType

@Controller('/')
class ApiController {

    @Get('/')
    @Produces(MediaType.TEXT_PLAIN)
    String index() {
        'Hello from Groovy in Docker!'
    }

    @Get('/health')
    Map<String, Object> health() {
        [
            status: 'ok',
            language: 'Groovy',
            groovyVersion: GroovySystem.version,
            javaVersion: System.getProperty('java.version'),
            framework: 'Micronaut'
        ]
    }

    @Get('/compute/{n}')
    Map<String, Object> compute(int n) {
        // Compute prime count up to n
        def primes = (2..n).findAll { num ->
            (2..Math.sqrt(num).intValue()).every { num % it != 0 }
        }
        [
            limit: n,
            primeCount: primes.size(),
            largestPrime: primes ? primes.last() : null
        ]
    }
}
