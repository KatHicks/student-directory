def interactive_menu
    students = []
    loop do
        # 1. print the menu and ask the user what do to
        puts "1. Input the students"
        puts "2. Show the students"
        puts "9. Exit" # 9 because we'll be adding more items
        # 2. read the input and save it into a variable
        selection = gets.chomp
        # 3. do what the user asked
        case selection
        when "1"
            # input the students
            students = input_students
        when "2"
            # show the students
            print_header
            print(students)
            print_footer(students)
        when "9"
            exit # this will cause the program to terminate
        else
            puts "I don't know what you mean. Try again!"
        end
    end
end

def prompt(output)
    # setting default values
    details = {
        firstname: "--",
        surname: "--",
        birthplace: "--",
        cohort: :unknown
    }
    
    # setting spelling checks for cohort entry
    spellcheck = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    # initial prompt
    if output.length < 1
        puts "Hit enter to exit or \"-\" to enter (a)nother student.\n"
        enter = gets.gsub("\n", "")
        
        if !enter.empty?
            puts "Please enter the first name, last name, birthplace and cohort of each student.\n"
            
            puts "Enter first name:"
            name = gets.gsub("\n", "")
            if !name.empty? then details[:firstname] = name end
            
            puts "Enter surname:"
            family = gets.gsub("\n", "")
            if !family.empty? then details[:surname] = family end
            
            puts "Enter birthplace:"
            place = gets.gsub("\n", "")
            if !place.empty? then details[:birthplace] = place end
            
            puts "Enter cohort:"
            month = gets.gsub("\n", "")
            if !month.empty? 
                spellcheck.each do |x|
                    if month[0..2].downcase == x[0..2].downcase then details[:cohort] = x.downcase.to_sym end
                end
            end
        else
            details = Hash.new
        end
    else
        puts "Please enter the first name, last name, birthplace and cohort of each student.\n"
            
        puts "Enter first name:"
        name = gets.gsub("\n", "")
        if !name.empty? then details[:firstname] = name end
        
        puts "Enter surname:"
        family = gets.gsub("\n", "")
        if !family.empty? then details[:surname] = family end
        
        puts "Enter birthplace:"
        place = gets.gsub("\n", "")
        if !place.empty? then details[:birthplace] = place end
        
        puts "Enter cohort:"
        month = gets.gsub("\n", "")
        if !month.empty? 
            spellcheck.each do |x|
                if month[0..2].downcase == x[0..2].downcase then details[:cohort] = x.downcase.to_sym end
            end
        end
    end
    
    return details
end

def input_students
    # create an empty array
    students = []
    details = prompt(students)
    
    # add student hash to the array
    if !details.empty?
        students << details
        puts students.count == 1 ? "Now we have #{students.count} student." : "Now we have #{students.count} students."
        puts "Hit enter to exit or \"-\" to enter (a)nother student.\n"
        enter = gets.gsub("\n", "")
        
        while !enter.empty?
            # continuing adding the student hashes to the array
            details = prompt(students)
            students << details
            puts students.count == 1 ? "Now we have #{students.count} student." : "Now we have #{students.count} students."
            puts "Hit enter to exit or \"-\" to enter (a)nother student.\n"
            enter = gets.gsub("\n", "")
        end
    end
    
    # return the array of students
    students
end

def print_header
    puts "The students of Villains Academy"
    puts "-------------"
end

def print(students)
    students.each_with_index do |student, index|
        puts "#{index + 1}. #{student[:firstname]} (#{student[:cohort]} cohort)"
    end
end

def print_all(students)
    students.each do |student|
        puts "#{student[:firstname]} #{student[:surname]} | #{student[:birthplace]} | Cohort: #{student[:cohort]}"
    end
end

def print_beginwitha(students)
    puts "Register of students (with names beginning in \"A\"):"
    students.each do |student|
        if student[:firstname][0] == "a" || student[:firstname][0] == "A"
            puts "\t#{student[:firstname]} (#{student[:cohort]} cohort)"
        else
            next
        end
    end
end

def print_lessthan12(students)
    puts "Register of students (with names less than 12 characters):"
    students.each do |student|
        if student[:firstname].length < 12
            puts "\t#{student[:firstname]} (#{student[:cohort]} cohort)"
        else
            next
        end
    end
end

def print_usingwhile(students)
    count = 0
    while count < students.length
        puts "#{students[count][:firstname]} (#{students[count][:cohort]} cohort)"
        count += 1
    end
end

def print_centered(students)
    puts "Here is our nicely formatted graduation attendee poster:".center(70).upcase
    students.each do |student|
        puts "#{student[:firstname]}".center(70, "-")
        puts "(#{student[:cohort]} cohort)".center(70)
    end
end

def existing_cohorts(students)
    cohorts = []
    students.each do |x|
        if cohorts.empty?
            cohorts << x[:cohort]
        elsif cohorts.include? x[:cohort]
            next
        else
            cohorts << x[:cohort]
        end
    end
    return cohorts
end

def print_bycohort(students)
    cohort_list = existing_cohorts(students)
    cohort_list.each do |month|
        puts "\nHere are the students from the #{month} cohort:"
        students.each do |x| 
            if x[:cohort] == month
                puts "#{x[:firstname]} #{x[:surname]}"
            else
                next
            end
        end
    end
end

def print_footer(students)
    puts "Overall, we have #{students.count} great students"
end

# nothing happens until we call the methods
# uncomment out the methods to test - but commented here to make output more readable for current exercise

# students = input_students
# print_header
# print(students)
# print_beginwitha(students)
# print_lessthan12(students)
# print_usingwhile(students)
# print_centered(students)
# print_all(students)
# print_bycohort(students)
# print_footer(students)

# using an if statemnet to only print the list if there is at least one student

# if !students.empty?
#     print(students)
# end

# can also use an unless statement
# print(students) unless students.empty?

interactive_menu