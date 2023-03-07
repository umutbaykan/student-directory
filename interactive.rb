@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
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
  @students << {name: name, cohort: cohort.to_sym}
end

def save_students(filename="students.csv")
  return if is_filename_invalid?(filename)
  open(filename, mode="w") {|file|
  @students.each do |student|
    csv_line = "#{student[:name]}, #{student[:cohort]}"
    file.puts csv_line
  end
  }
  puts "Students successfully saved in #{filename} file\n\n"
end

def load_students(filename="students.csv")
  return if is_filename_invalid?(filename)
  ### resets the array so we dont duplicate student data if we load more than once
  @students = []
  # file = File.open(filename, "r")
  open(filename, mode="r") {|file|
  file.readlines.each do |student|
    name, cohort = student.chomp.split(", ")
    add_into_students(name, cohort)
  end
  }
  puts "Loaded #{@students.count} from #{filename}\n\n"
end

def is_filename_invalid?(filename)
  if filename == nil
    puts "No filename specified. Terminating process"
    return true
  end
  return false
end

def ask_next_move
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
  puts "Which file would you like to use? Please enter with .csv ending"
  filename = STDIN.gets.chomp
  if File.exist?(filename)  
    return filename 
  else
    puts "Filename #{filename} does not exist."
  end
end


def try_load_students
  filename = ARGV.first
  filename = 'students.csv' if filename.nil?
  if File.exist?(filename)
    load_students(filename)
  else
    puts "Filename #{filename} does not exist."
    choice = ask_next_move
    choice == "Y" ? return : exit
  end
end

def print_header
  puts "The students of my cohort at Makers Academy"
  puts "-------------"
end

def print_students
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students\n\n"
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save students into a CSV file"
  puts "4. Load the list of students from different CSV file"
  puts "9. Exit\n\n"
end

def show_students
  print_header
  print_students
  print_footer
end

def process(selection)
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
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu
