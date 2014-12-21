#GABB
An interactive bug fixing activity for WDI Students
## Installation
Clone the repo.
## Usage
### Starting
Run `ruby gabb.rb` in the root folder, then follow instructions.

### Creating an Exercise
Creating an exercise is simple. Follow these steps:

#### Create the template
1. Create a template for the excersize in the `lib/templates` folder. The tempate's file name should, but is not required to be, a snake-cased version of the exercise's title.
    * Naming it in this way will allows GABB to intuitively find the file.
    * If it is named differently, the file name will have to be manually specified in the exercise.
2. The file's code should have bugs.

**Example Template:**
```ruby
# lib/templates/puts_hi.rb
def puts_hi
  puts "hi"

```

#### Create the exercise
1. Create a file for the exercise in the `lib/exercises` folder.
2. Create a class for the exercise
    * The class name should be a constantized version of the exercise name.
    * The class needs to inherit from `GABB::Exercise::Base`
3. Give the excersize dialogue methods.
    * The gem `colorize` is available to add color to the dialogue.
    * There are 4 dialogue points available:
        1. Exposition<br>
          Dialogue to be displayed when starting an exercise.
        2. Rising Action<br>
          Dialogue to be displayed before the bugged file is loaded.
        3. Climax<br>
          Dialogue to be displayed after an error is raised.
        4. Resolution<br>
          Dialogue to be displayed after the file is cleared of bugs.
    * If a dialogue method is not defined, no dialogue will be displayed.
    * The following methods are available when defining your dialogue methods:
        * `beat`<br>
          Outputs an empty line.
        * `wait`<br>
          Pauses until user presses enter.
        * `line_break`<br>
          Outputs "==========================================="
        * `clear_screen`<br>
          Clears the screen via `system(clear)`.
        * `validate_details`<br>
          Will ask the user for the file's name and the line on which the error was encountered, and does not proceed until they are correctly given.<br>
          Should only be used in the `climax` dialogue.
        * `log_solution`<br>
          Will prompt the user to explain how they solved the bug and log their explanation to the log file.<br>
          Should only be used in the `resolution` dialogue.

That is all that is required to create an exercise. GABB will automatically handle the rest. To customize an exercise, see the Customizing Exercises section.


**Example Exercise:**
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
### Customizing an Exercise

Exercises can be customized in the following ways:

#### Exercise Title
An exercise's title can be manually set.
```ruby
def self.title
  "No End in Sight"
end
```
Would normally default to the class name, eg "Puts Hi".

#### Excersize Template Name
An exercise's template name can be manually set.
```ruby
def file_name
  the_puts_hi_exercise.rb
end
```
Would normally default to the class name, eg "puts_hi.rb".

#### Before and After Action Hooks
You can add methods to be executed before and/or after an exercise executes.
```ruby
class PutsHi < GABB::Exercise::Base
  before_action :greet
  after_action :farewell

  def greet
    puts "Hi!"
  end

  def farewell
    puts "Good bye!"
  end
end
```

#### Repeat Detail Validation
`validate_details` can be set to repeat on each attempt at fixing the bug.
```ruby
def climax
  puts "Hmm.".blue
  puts "Something went wrong. Let's figure out what.".blue
  validate_details(repeat: true)
  puts "Great. Go to that file and fix the issue.".blue
end
```
`validate_details` only triggers once by default.

#### Selective Detail Validation
`validate_details` can be set to only validate certain details.
```ruby
def climax
  puts "Hmm.".blue
  puts "Something went wrong. Let's figure out what.".blue
  validate_details(only: [:file])
  puts "Great. Go to that file and fix the issue.".blue
end
```
Possible options include `:file` and `:line`.

#### Custom Validation Outputs
Outputs for the `validate_details` method can be customized.
```ruby
class PutsHi < GABB::Exercise::Base
  configure_detail_validator do |validator|
    validator.guess_file_prompt = "Yo. Guess the file" # defaults to "In what file is the error?".blue
    validator.guess_line_prompt = "Can you find the error's line?" # defaults to "On what line is the error?".blue
    validator.incorrect_file = "Nope, that ain\'t it." # defaults to "That's not the right file".yellow
    validator.incorrect_line = "Wrong!" # defaults to "That's not the right line".yellow 
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