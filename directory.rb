def input_students
    puts "Please enter the first name, last name and birthplace of each student."
    puts "Enter each piece of information separated by a comma and space \ne.g. \"Kat, Hicks, London\""
    puts "Hit return after each student and just hit return twice to finish."
    puts
    # create an empty array
    students = []
    # get the first name
    details = gets.chomp.split(", ")
    # while the name is not empty, repeat this code
    while !details.empty? do
        # add the student hash to the array
        students << {firstname: details[0], surname: details[1], birthplace: details[2], cohort: :november}
        puts "Now we have #{students.count} students"
        # get another name from the user
        details = gets.chomp.split(", ")
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

def print_footer(students)
    puts "Overall, we have #{students.count} great students"
end

# nothing happens until we call the methods
students = input_students
print_header
print(students)
puts
print_beginwitha(students)
puts
print_lessthan12(students)
puts
print_usingwhile(students)
puts
print_centered(students)
puts
print_footer(students)