#GABB
An interactive bug fixing activity for WDI Students
## Installation
Clone the repo.
## Usage
### Starting
Run `ruby gabb.rb` in the root folder, then follow instructions.

### Sessions
Whenever starting a bugfixing session, a folder is created in the `sessions` folder. This folder will include:
* Any exercises a student works on in this session.
* A log with completed exercises and the student's explanation of how s/he completed the exercise.

Old sessions can be loaded... But functionality for loaded sessions has not yet been implemented.

### Creating an Exercise
Creating an exercise is simple. Follow these steps:

#### Create the template
1. Create a template for the excersize in the lib/templates folder. The tempate's file name could, but is not required to be, a snake-cased version of the exercise's name.
    * Naming it in this way will allows GABB to intuitively find the file.
    * If it is named differently, the name will have to be manually specified in the exercise.
2. The file's code should have bugs.

**Example:**
```ruby
# lib/templates/puts_hi.rb
def puts_hi
  puts "hi"

```

#### Create the exercise
1. Create a file for the exercise in the lib/exercises folder.
2. Create a class for the exercise
    * The class name should be a constantized version of the exercise name.
    * The class needs to inherit from `GABB::Exercise::Base`
3. Give the excersize dialogue methods.
    * There are 4 dialogue points available:
        1. Exposition<br>
          Dialogue to be displayed when starting an exercise.
        2. Rising Action
            * Dialogue to be displayed before the bugged file is loaded.
        3. Climax
            * Dialogue to be displayed after an error is raised.
        4. Resolution
            * Dialogue to be displayed after the file is cleared of bugs.
    * If a dialogue method is not defined, no dialogue will be displayed.
    * The following methods are available when defining your dialogue methods:
        * `beat`
            * Outputs an empty line.
        * `wait`
            * Pauses until user presses enter.
        * `line_break`
            * Outputs "==========================================="
        * `clear_screen`
            * Clears the screen via `system(clear)`.
        *  `validate_details`
            * Will ask the user for the file's name and the line on which the error was encountered.
            * Should only be used in the `climax` dialogue.
        * `log_solution`
            * Will prompt the user to explain how they solved the bug and log their explanation to the session's log file.
            * Should only be used in the `resolution` dialogue.

That is all that is required to create an exercise. To customize an exercise, see the Customizing Exercises section.


**Example:**
```ruby
# lib/exercises/puts_hi.rb
class PutsHi < GABB::Exercise::Base

  def exposition
    puts "We're going to start by getting a method that prints 'hi' to the screen.".blue
    beat
    puts "The code for this method is found in another file. We'll have to require it before we can use the code.".blue
    wait
  end

  def rising_action
    puts "Requiring puts_hi.rb...".blue
  end

  def climax
    puts "Hmm.".blue
    puts "Something went wrong. Let's figure out what.".blue
    validate_details
    puts "Great. Go to that file and fix the issue.".blue
  end

  def resolution
    puts "Problem fixed!".blue
    log_solution
  end
end
```



## To Do
* More bug fixing activities.
* Failing to fix a problem should provide the student with a random tip.
* Sessions should track completed exercises.
* Sessions should be loadable.
* Students should be warned before overriding any files.
* Exercises should have descriptions.
* Exercises should have tests to make sure bugs are solved as intended.