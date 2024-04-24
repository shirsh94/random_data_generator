library random_data_generator;

import 'random_data_generator.dart';
export 'src/random_data.dart';

class TestRandomData {
  String randomEmail = RandomData.generateRandomEmail();
  String randomNanoId = RandomData.generateNanoId();
  String ULID = RandomData.generateUlid();
  String UDID = RandomData.generateUDID();
  String quote = RandomData.quote();
  String ancientAnimalName = RandomData.generateAncientAnimalName();
  String randomAnimalName = RandomData.generateRandomAnimalName();
  int flakeUuid = RandomData.generateFlakeUuid(21);
  String xid = RandomData.generateXid();
  int randomNumber = RandomData.generateRandomIntBetween(1, 100);
  double randomDoubleNumber = RandomData.generateRandomDoubleBetween(1, 100);
}

/*
The Random Data Generator package provides a wide range of methods that can be used in various
scenarios to generate random data for testing, prototyping, or even in production applications.
Here are ten of the top methods along with their potential use cases:

Certainly! Here's an explanation for each method in the `RandomData` class:

1. `generateRandomIntBetween`: This method generates a random integer between the specified minimum and maximum values.
   Example: `generateRandomIntBetween(1, 10)` may return `5`.

2. `generateRandomDoubleBetween`: This method generates a random double (floating-point number) between the specified minimum and maximum values.
   Example: `generateRandomDoubleBetween(1.0, 5.0)` may return `3.5`.

3. `generateRandomLowercaseAlphabet`: This method generates a random lowercase alphabet character.
   Example: `generateRandomLowercaseAlphabet()` may return `'h'`.

4. `generateRandomCapitalAlphabet`: This method generates a random uppercase alphabet character.
   Example: `generateRandomCapitalAlphabet()` may return `'T'`.

5. `quote`: This method returns a random quote from a list of quotes.
   Example: `quote()` may return "The only way to do great work is to love what you do. – Steve Jobs".

6. `languageName`: This method returns a random programming language name from a list.
   Example: `languageName()` may return `'Hindi'`.

7. `getRandomHexColor`: This method generates a random hexadecimal color code.
   Example: `getRandomHexColor()` may return `'#aabbcc'`.

8. `getRandomRGBColor`: This method generates a random RGB color represented as an array of three integers (red, green, blue).
   Example: `getRandomRGBColor()` may return `[255, 0, 128]`.

9. `getRandomRGBAColor`: This method generates a random RGBA color represented as an array of four values (red, green, blue, alpha).
   Example: `getRandomRGBAColor()` may return `[255, 0, 128, 0.5]`.

10. `getRandomHSLColor`: This method generates a random HSL color represented as an array of three values (hue, saturation, lightness).
    Example: `getRandomHSLColor()` may return `[180.0, 50.0, 70.0]`.

11. `getRandomHSVColor`: This method generates a random HSV color represented as an array of three values (hue, saturation, value).
    Example: `getRandomHSVColor()` may return `[200.0, 80.0, 90.0]`.

12. `getRandomCMYKColor`: This method generates a random CMYK color represented as an array of four values (cyan, magenta, yellow, black).
    Example: `getRandomCMYKColor()` may return `[10, 50, 70, 30]`.

13. `generateRandomEmail`: This method generates a random email address.
    Example: `generateRandomEmail()` may return `'example@example.com'`.

14. `generateRandomEmailName`: This method generates a random email username (before the '@' symbol).
    Example: `generateRandomEmailName()` may return `'user1234'`.

15. `generateEasyPassword`: This method generates a random easy password.
    Example: `generateEasyPassword()` may return `'pass1234'`.

16. `generateMediumPassword`: This method generates a random medium strength password.
    Example: `generateMediumPassword()` may return `'Passw0rd123'`.

17. `generateStrongPassword`: This method generates a random strong password.
    Example: `generateStrongPassword()` may return `'S3cUr3P@ssw0rd!'`.

18. `generateRandomAnimalName`: This method generates a random animal name.
    Example: `generateRandomAnimalName()` may return `'Tiger'`.

19. `generateAncientAnimalName`: This method generates a random ancient animal name.
    Example: `generateAncientAnimalName()` may return `'Megalodon'`.

20. `generateRandomColorName`: This method generates a random color name.
    Example: `generateRandomColorName()` may return `'Cerulean'`.

    same as for all 100+ method.

Feel free to ask if you need more details or examples for any specific method!
These methods showcase the versatility of the package and
how it can be used in various scenarios to generate realistic and diverse random data.
*/
