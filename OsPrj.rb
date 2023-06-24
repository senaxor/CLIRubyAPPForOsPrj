require 'thor'
require 'byebug'
module MainProject
    class Os

        def start(input)
            max = input[0]
            current = input[1]
            cylinders = input[2].sort
            direction = input.last
            first = current
            puts "Head Movements : \n"

           if direction
            total_mov = 0
            cylinders.select{|s| s>=current}.each do |c|
                puts "#{c}\n"
                total_mov+= c-first
                first =c
            end
            unless cylinders.max == max
                puts "#{max}\n"
                total_mov+= max - first
                total_mov +=max
                first =0
            end
            puts "0\n"
            cylinders.select{|s| s<current}.sort.each do |c|
                puts "#{c}\n"
                total_mov+= c-first
                first =c
            end

            puts "Total Movement: #{total_mov}"
            
            else 
                total_mov = 0
                cylinders.select{|s| s<current}.reverse.each do |c|
                    puts "#{c}\n"
                    total_mov += first-c
                    first =c
                end
                unless cylinders.min == 0
                 puts "0\n"
                 total_mov +=first
                 total_mov+=max
                 first = max
                end
                puts "#{max}\n"
                cylinders.select{|s| s>=current}.reverse.each do |c|
                    puts "#{c}\n"
                    total_mov+=first-c
                    first =c
                end
                puts "Total Movement: #{total_mov}"
            end
        end

        def input_proccessor
            max = nil
            current = nil
            past = nil 
            cylinders = nil
            direction = nil
            puts "Hii"
            puts "user --help command for more info!!"
            while true
                puts "Enter your input"
                input = gets.chomp
                case input
                when "add -max"
                    puts  "Enter Max Number of cylinders"
                    max = gets.chomp
                when "add -current"
                    puts "Enter current Cylinder state"
                    current = gets.chomp
                when "add -past"
                    puts "Enter past Cylinder state"
                    past = gets.chomp
                when "set -direct"
                    puts "Initializing direction"
                    if current.nil? || past.nil?
                        puts "One of current_state or past_state are null"
                    else
                        direction=detect_direction(current.to_i,past.to_i)
                        if direction 
                            puts "Direction is to Up"
                        else 
                            puts "Direction is to Down"
                        end
                    end
                when "add -cylinders"
                    puts "Enter Cylinders index"
                    string = gets.chomp
                    cylinders = string.split
                when "clear -vari"
                    max = nil
                    current = nil
                    past = nil 
                    cylinders = nil
                    direction = nil
                    puts "all variables have been cleared!"
                when "initialize"
                    max = 200
                    current = 80
                    past = 40
                    cylinders = [100,120,20,30,50,70]
                    direction = true
                    puts "variables have been initialized!!"
                when "--help"
                    puts "commands are as shown below :\n"
                    puts " initialize\n add -max\n add -current\n add -past\n set -direct\n add -cylinders\n clear -vari\n start\n show -max\n show -current\n show -past\n show -direct\n show -cylinders\n show -all\n clear\n"
                when "start"
                    if (max.nil? || current.nil? || past.nil? || direction.nil? || cylinders.nil?)
                        puts "one of variables are not defiend"
                    else
                        result =[max.to_i,current.to_i,cylinders.map(&:to_i),direction]
                        start(result)
                    end
                when "clear"
                   puts `clear`
                when "show -max"
                    puts max
                when "show -current"
                    puts current
                when "show -past"
                    puts past
                when "show -direct"
                    puts direction
                when "show -cylinders"
                    puts cylinders
                when "show -all"
                    puts "max : #{max}"
                    puts "current : #{current}"
                    puts "past : #{past}"
                    puts "direction: #{direction}"
                    puts "cylinders : #{cylinders}"
                else
                    puts "commands not valid"
                end

            end
        end


        def detect_direction(current,past)
            if(current>past)
             return true
            elsif(past > current)
             return false
            else
                raise StandardError.new "current state is equil with past state"
            end
        end

    end
end



app = MainProject::Os.new
app.input_proccessor