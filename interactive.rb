require "csv"
@students = []


def input_students
  ### Add students until user stops
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  while name != ""
    if name != ""
      # add the student hash to the array
      add_into_students(name)
      puts "Input successful."
      puts "Now we have #{@students.count} students"
      # get another name from the user
      name = STDIN.gets.chomp
    end
  end
end

def add_into_students(name, cohort=:november)
  ### Reformats student info to add into global @student variable
  @students << {name: name, cohort: cohort.to_sym}
end

def save_students(filename="students.csv")
  ### Saves the students info into specified csv file
  # check if path is valid, terminate if not
  return if is_filename_invalid?(filename)
  # write each student as a separate row to csv
  CSV.open(filename, "w") do |file|
    @students.each do |student|
      file << [student[:name], student[:cohort]]
    end
  end
  puts "Students successfully saved in #{filename} file\n\n"
end

def load_students(filename="students.csv")
  ### Loads student info from specified csv file
  # check if path is valid, terminate if not
  return if is_filename_invalid?(filename)
  # resets the array so we dont duplicate student data if we load more than once
  @students = []
  # extract student information from csv and push into global array
  CSV.foreach(filename) do |student|
    name, cohort = student[0], student[1]
    add_into_students(name, cohort)
  end
  puts "Loaded #{@students.count} from #{filename}\n\n"
end

def is_filename_invalid?(filename)
  ### checks if such filename exists, terminates parent sequence if not
  if filename == nil
    puts "No filename specified. Terminating process"
    return true
  end
  return false
end

def ask_next_move
  ### asks whether the user would like to terminate or continue 
  ### used if the command line argument does not point at valid file name
  puts "Would you like to continue with an empty database anyway? Y/N"
  input = STDIN.gets.chomp.upcase
  while input != "Y" || input != "N"
    if input == "Y"
      return "Y"
    elsif input == "N"
      return "N"
    else
      puts "That is not a valid input. Please use Y/N"
      input = STDIN.gets.chomp.upcase
    end
  end  
end


def ask_file_choice
  ### asks the user which file to operate on
  puts "Which file would you like to use? Please enter with .csv ending"
  filename = STDIN.gets.chomp
  if File.exist?(filename)  
    return filename 
  else
    puts "Filename #{filename} does not exist."
  end
end


def try_load_students
  ### loads the specified command line data file by default into program.
  filename = ARGV.first
  filename = 'students.csv' if filename.nil?
  # checks if such filename exists
  if File.exist?(filename)
    load_students(filename)
  else
    # asks user whether to continue with an empty database or quit program
    puts "Filename #{filename} does not exist."
    choice = ask_next_move
    choice == "Y" ? return : exit
  end
end

def print_menu
  ### menu to display at terminal
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save students into a CSV file"
  puts "4. Load the list of students from different CSV file"
  puts "9. Exit\n\n"
end

def show_students
  ### displays the list of students
  ### refactored header, print_students and footer to avoid
  ### too many methods for simple tasks
  puts "The students of my cohort at Makers Academy"
  puts "-------------"
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
  puts "Overall, we have #{@students.count} great students\n\n"
end

def process(selection)
  ### executes the relevant function based on user input
  case selection
   when "1"
      input_students
    when "2" 
      show_students
    when "3"
      save_students(ask_file_choice)
    when "4"
      load_students(ask_file_choice)
    when "9"
      puts "Exiting, goodbye!"
      exit
    else
      puts "This is not amongst menu items, please try again"
  end
end

def interactive_menu
  ### runs the program unless terminated
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu
