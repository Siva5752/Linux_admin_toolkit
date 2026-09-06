#!/bin/bash

# ==========================================
#       LINUX ADMINISTRATOR TOOLKIT
# ==========================================

while true
do
    clear

    echo "========================================"
    echo "        LINUX ADMINISTRATOR TOOLKIT"
    echo "========================================"
    echo "1.  User Management"
    echo "2.  Group Management"
    echo "3.  Service Management"
    echo "4.  Package Management"
    echo "5.  Process Monitoring"
    echo "6.  System Health"
    echo "7.  Network Diagnostics"
    echo "8.  Backup Management"
    echo "9.  Log Analysis"
    echo "10. File Management"
    echo "11. Exit"
    echo "========================================"

    read -p "Enter your choice: " choice

    case $choice in

        # ==================================
        # 1. USER MANAGEMENT
        # ==================================
        1)
            while true
            do
                clear
                echo "================================"
                echo "        USER MANAGEMENT"
                echo "================================"
                echo "1. Create User"
                echo "2. Delete User"
                echo "3. List Users"
                echo "4. User Information"
                echo "5. Back to Main Menu"
                echo "================================"

                read -p "Enter your choice: " user_choice

                case $user_choice in

                    1)
                        read -p "Enter username: " username

                        if [ -z "$username" ]; then
                            echo "Username cannot be empty!"
                        elif id "$username" &>/dev/null; then
                            echo "User already exists!"
                        else
                            sudo useradd "$username"

                            if [ $? -eq 0 ]; then
                                echo "User $username created successfully."
                            else
                                echo "Failed to create user."
                            fi
                        fi
                        ;;

                    2)
                        read -p "Enter username to delete: " username

                        if [ -z "$username" ]; then
                            echo "Username cannot be empty!"
                        elif ! id "$username" &>/dev/null; then
                            echo "User does not exist!"
                        else
                            sudo userdel "$username"

                            if [ $? -eq 0 ]; then
                                echo "User $username deleted successfully."
                            else
                                echo "Failed to delete user."
                            fi
                        fi
                        ;;

                    3)
                        echo "System Users:"
                        cut -d: -f1 /etc/passwd
                        ;;

                    4)
                        read -p "Enter username: " username

                        if id "$username" &>/dev/null; then
                            id "$username"
                        else
                            echo "User does not exist!"
                        fi
                        ;;

                    5)
                        break
                        ;;

                    *)
                        echo "Invalid choice!"
                        ;;
                esac

                echo
                read -p "Press Enter to continue..."
            done
            ;;


        # ==================================
        # 2. GROUP MANAGEMENT
        # ==================================
        2)
            while true
            do
                clear
                echo "================================"
                echo "        GROUP MANAGEMENT"
                echo "================================"
                echo "1. Create Group"
                echo "2. Delete Group"
                echo "3. Add User to Group"
                echo "4. List Groups"
                echo "5. Back to Main Menu"
                echo "================================"

                read -p "Enter your choice: " group_choice

                case $group_choice in

                    1)
                        read -p "Enter group name: " groupname

                        if [ -z "$groupname" ]; then
                            echo "Group name cannot be empty!"
                        elif getent group "$groupname" &>/dev/null; then
                            echo "Group already exists!"
                        else
                            sudo groupadd "$groupname"

                            if [ $? -eq 0 ]; then
                                echo "Group $groupname created successfully."
                            else
                                echo "Failed to create group."
                            fi
                        fi
                        ;;

                    2)
                        read -p "Enter group name to delete: " groupname

                        if [ -z "$groupname" ]; then
                            echo "Group name cannot be empty!"
                        elif ! getent group "$groupname" &>/dev/null; then
                            echo "Group does not exist!"
                        else
                            sudo groupdel "$groupname"

                            if [ $? -eq 0 ]; then
                                echo "Group $groupname deleted successfully."
                            else
                                echo "Failed to delete group."
                            fi
                        fi
                        ;;

                    3)
                        read -p "Enter username: " username
                        read -p "Enter group name: " groupname

                        if ! id "$username" &>/dev/null; then
                            echo "User does not exist!"
                        elif ! getent group "$groupname" &>/dev/null; then
                            echo "Group does not exist!"
                        else
                            sudo usermod -aG "$groupname" "$username"

                            if [ $? -eq 0 ]; then
                                echo "$username added to $groupname."
                            else
                                echo "Failed to add user to group."
                            fi
                        fi
                        ;;

                    4)
                        echo "System Groups:"
                        cut -d: -f1 /etc/group
                        ;;

                    5)
                        break
                        ;;

                    *)
                        echo "Invalid choice!"
                        ;;
                esac

                echo
                read -p "Press Enter to continue..."
            done
            ;;


        # ==================================
        # 3. SERVICE MANAGEMENT
        # ==================================
        3)
            while true
            do
                clear
                echo "================================"
                echo "       SERVICE MANAGEMENT"
                echo "================================"
                echo "1. Start Service"
                echo "2. Stop Service"
                echo "3. Restart Service"
                echo "4. Service Status"
                echo "5. Back to Main Menu"
                echo "================================"

                read -p "Enter your choice: " service_choice

                case $service_choice in

                    1)
                        read -p "Enter service name: " service

                        if systemctl list-unit-files | grep -q "^${service}.service"; then
                            sudo systemctl start "$service"

                            if [ $? -eq 0 ]; then
                                echo "$service started successfully."
                            else
                                echo "Failed to start $service."
                            fi
                        else
                            echo "Service not found!"
                        fi
                        ;;

                    2)
                        read -p "Enter service name: " service

                        if systemctl list-unit-files | grep -q "^${service}.service"; then
                            sudo systemctl stop "$service"

                            if [ $? -eq 0 ]; then
                                echo "$service stopped successfully."
                            else
                                echo "Failed to stop $service."
                            fi
                        else
                            echo "Service not found!"
                        fi
                        ;;

                    3)
                        read -p "Enter service name: " service

                        if systemctl list-unit-files | grep -q "^${service}.service"; then
                            sudo systemctl restart "$service"

                            if [ $? -eq 0 ]; then
                                echo "$service restarted successfully."
                            else
                                echo "Failed to restart $service."
                            fi
                        else
                            echo "Service not found!"
                        fi
                        ;;

                    4)
                        read -p "Enter service name: " service

                        if systemctl list-unit-files | grep -q "^${service}.service"; then
                            systemctl status "$service" --no-pager
                        else
                            echo "Service not found!"
                        fi
                        ;;

                    5)
                        break
                        ;;

                    *)
                        echo "Invalid choice!"
                        ;;
                esac

                echo
                read -p "Press Enter to continue..."
            done
            ;;


        # ==================================
        # 4. PACKAGE MANAGEMENT
        # ==================================
        4)
            while true
            do
                clear
                echo "================================"
                echo "       PACKAGE MANAGEMENT"
                echo "================================"
                echo "1. Update Packages"
                echo "2. Install Package"
                echo "3. Remove Package"
                echo "4. Search Package"
                echo "5. Back to Main Menu"
                echo "================================"

                read -p "Enter your choice: " package_choice

                case $package_choice in

                    1)
                        sudo apt update
                        ;;

                    2)
                        read -p "Enter package name: " package

                        if [ -z "$package" ]; then
                            echo "Package name cannot be empty!"
                        else
                            sudo apt install "$package"
                        fi
                        ;;

                    3)
                        read -p "Enter package name: " package

                        if [ -z "$package" ]; then
                            echo "Package name cannot be empty!"
                        else
                            sudo apt remove "$package"
                        fi
                        ;;

                    4)
                        read -p "Enter package name: " package

                        if [ -z "$package" ]; then
                            echo "Package name cannot be empty!"
                        else
                            apt search "$package"
                        fi
                        ;;

                    5)
                        break
                        ;;

                    *)
                        echo "Invalid choice!"
                        ;;
                esac

                echo
                read -p "Press Enter to continue..."
            done
            ;;


        # ==================================
        # 5. PROCESS MONITORING
        # ==================================
        5)
            while true
            do
                clear
                echo "================================"
                echo "       PROCESS MONITORING"
                echo "================================"
                echo "1. Show Running Processes"
                echo "2. Find Process"
                echo "3. Process Details"
                echo "4. Live Process Monitor"
                echo "5. Back to Main Menu"
                echo "================================"

                read -p "Enter your choice: " process_choice

                case $process_choice in

                    1)
                        ps aux
                        ;;

                    2)
                        read -p "Enter process name: " process

                        if [ -z "$process" ]; then
                            echo "Process name cannot be empty!"
                        else
                            pgrep -a "$process" || echo "Process not found."
                        fi
                        ;;

                    3)
                        read -p "Enter PID: " pid

                        if [[ "$pid" =~ ^[0-9]+$ ]]; then
                            if ps -p "$pid" > /dev/null; then
                                ps -p "$pid" -f
                            else
                                echo "Process not found"
                            fi
                        else
                            echo "Invalid PID!"
                        fi
                        ;;

                    4)
                        top
                        ;;

                    5)
                        break
                        ;;

                    *)
                        echo "Invalid choice!"
                        ;;
                esac

                echo
                read -p "Press Enter to continue..."
            done
            ;;


        # ==================================
        # 6. SYSTEM HEALTH
        # ==================================
        6)
            while true
            do
                clear
                echo "================================"
                echo "          SYSTEM HEALTH"
                echo "================================"
                echo "1. Disk Usage"
                echo "2. Memory Usage"
                echo "3. System Uptime"
                echo "4. CPU Information"
                echo "5. Back to Main Menu"
                echo "================================"

                read -p "Enter your choice: " health_choice

                case $health_choice in

                    1)
                        df -h
                        ;;

                    2)
                        free -h
                        ;;

                    3)
                        uptime
                        ;;

                    4)
                        lscpu
                        ;;

                    5)
                        break
                        ;;

                    *)
                        echo "Invalid choice!"
                        ;;
                esac

                echo
                read -p "Press Enter to continue..."
            done
            ;;


        # ==================================
        # 7. NETWORK DIAGNOSTICS
        # ==================================
        7)
            while true
            do
                clear
                echo "================================"
                echo "      NETWORK DIAGNOSTICS"
                echo "================================"
                echo "1. Show IP Address"
                echo "2. Show Listening Ports"
                echo "3. Test Connectivity"
                echo "4. Test URL"
                echo "5. Back to Main Menu"
                echo "================================"

                read -p "Enter your choice: " network_choice

                case $network_choice in

                    1)
                        ip addr
                        ;;

                    2)
                        ss -tuln
                        ;;

                    3)
                        read -p "Enter hostname/IP: " target

                        if [ -z "$target" ]; then
                            echo "Target cannot be empty!"
                        elif ping -c 1 -W 2 "$target" > /dev/null 2>&1; then
                            echo "Connectivity successful: $target is reachable."
                        else
                            echo "Connectivity failed: $target is unreachable."
                        fi
                        ;;

                    4)
                        read -p "Enter URL: " url

                        if [ -z "$url" ]; then
                            echo "URL cannot be empty!"
                        else
                            curl -I "$url"
                        fi
                        ;;

                    5)
                        break
                        ;;

                    *)
                        echo "Invalid choice!"
                        ;;
                esac

                echo
                read -p "Press Enter to continue..."
            done
            ;;


        # ==================================
        # 8. BACKUP MANAGEMENT
        # ==================================
        8)
            while true
            do
                clear
                echo "================================"
                echo "        BACKUP MANAGEMENT"
                echo "================================"
                echo "1. Create Backup"
                echo "2. List Backups"
                echo "3. Back to Main Menu"
                echo "================================"

                read -p "Enter your choice: " backup_choice

                case $backup_choice in

                    1)
                        read -p "Enter directory to backup: " source
                        read -p "Enter backup filename: " backup

                        if [ -z "$source" ] || [ -z "$backup" ]; then
                            echo "Input cannot be empty!"
                        elif [ ! -d "$source" ]; then
                            echo "Directory does not exist!"
                        elif [ -e "${backup}.tar.gz" ]; then
                            echo "Backup file already exists!"
                        else
                            tar -czvf "${backup}.tar.gz" "$source"

                            if [ $? -eq 0 ]; then
                                echo "Backup created successfully."
                            else
                                echo "Backup failed."
                            fi
                        fi
                        ;;

                    2)
                        echo "Available backups:"
                        ls -lh *.tar.gz 2>/dev/null || echo "No backup files found."
                        ;;

                    3)
                        break
                        ;;

                    *)
                        echo "Invalid choice!"
                        ;;
                esac

                echo
                read -p "Press Enter to continue..."
            done
            ;;


        # ==================================
        # 9. LOG ANALYSIS
        # ==================================
        9)
            while true
            do
                clear
                echo "================================"
                echo "          LOG ANALYSIS"
                echo "================================"
                echo "1. Show Recent Logs"
                echo "2. Search Error Logs"
                echo "3. Show Last 20 Syslog Lines"
                echo "4. Search Specific Word"
                echo "5. Back to Main Menu"
                echo "================================"

                read -p "Enter your choice: " log_choice

                case $log_choice in

                    1)
                        sudo journalctl -n 20 --no-pager
                        ;;

                    2)
                        echo "Recent Error Logs:"
                        if sudo journalctl -p err -n 20 --no-pager | grep -q .; then
                            sudo journalctl -p err -n 20 --no-pager
                        else
                            echo "No error logs found."
                        fi
                        ;;

                    3)
                        if [ -f /var/log/syslog ]; then
                            sudo tail -n 20 /var/log/syslog
                        else
                            echo "/var/log/syslog not found."
                        fi
                        ;;

                    4)
                        read -p "Enter word to search: " word

                        if [ -z "$word" ]; then
                            echo "Search word cannot be empty!"
                        elif [ -f /var/log/syslog ]; then
                            sudo grep -i "$word" /var/log/syslog
                        else
                            echo "/var/log/syslog not found."
                        fi
                        ;;

                    5)
                        break
                        ;;

                    *)
                        echo "Invalid choice!"
                        ;;
                esac

                echo
                read -p "Press Enter to continue..."
            done
            ;;


        # ==================================
        # 10. FILE MANAGEMENT
        # ==================================
        10)
            while true
            do
                clear
                echo "================================"
                echo "        FILE MANAGEMENT"
                echo "================================"
                echo "1. Create Directory"
                echo "2. Create File"
                echo "3. Copy File"
                echo "4. Move/Rename File"
                echo "5. Delete File"
                echo "6. Find File"
                echo "7. Change Permission"
                echo "8. Back to Main Menu"
                echo "================================"

                read -p "Enter your choice: " file_choice

                case $file_choice in

                    1)
                        read -p "Enter directory name: " dirname

                        if [ -z "$dirname" ]; then
                            echo "Directory name cannot be empty!"
                        else
                            mkdir -p "$dirname"

                            if [ $? -eq 0 ]; then
                                echo "Directory created successfully."
                            else
                                echo "Failed to create directory."
                            fi
                        fi
                        ;;

                    2)
                        read -p "Enter file name: " filename

                        if [ -z "$filename" ]; then
                            echo "File name cannot be empty!"
                        else
                            touch "$filename"

                            if [ $? -eq 0 ]; then
                                echo "File created successfully."
                            else
                                echo "Failed to create file."
                            fi
                        fi
                        ;;

                    3)
                        read -p "Enter source file: " source
                        read -p "Enter destination: " destination

                        if [ ! -f "$source" ]; then
                            echo "Source file does not exist!"
                        elif [ -z "$destination" ]; then
                            echo "Destination cannot be empty!"
                        else
                            cp "$source" "$destination"

                            if [ $? -eq 0 ]; then
                                echo "File copied successfully."
                            else
                                echo "Failed to copy file."
                            fi
                        fi
                        ;;

                    4)
                        read -p "Enter current name: " oldname
                        read -p "Enter new name: " newname

                        if [ ! -e "$oldname" ]; then
                            echo "Source does not exist!"
                        elif [ -z "$newname" ]; then
                            echo "New name cannot be empty!"
                        else
                            mv "$oldname" "$newname"

                            if [ $? -eq 0 ]; then
                                echo "File moved/renamed successfully."
                            else
                                echo "Failed to move/rename."
                            fi
                        fi
                        ;;

                    5)
                        read -p "Enter file to delete: " filename

                        if [ ! -e "$filename" ]; then
                            echo "File does not exist!"
                        else
                            rm -i "$filename"
                        fi
                        ;;

                    6)
                        read -p "Enter file name to find: " filename

                        if [ -z "$filename" ]; then
                            echo "File name cannot be empty!"
                        else
                            find . -name "$filename"
                        fi
                        ;;

                    7)
                        read -p "Enter file name: " filename
                        read -p "Enter permission (example 755): " permission

                        if [ ! -f "$filename" ]; then
                            echo "File does not exist!"
                        elif [[ ! "$permission" =~ ^[0-7]{3}$ ]]; then
                            echo "Invalid permission! Use format like 755."
                        else
                            chmod "$permission" "$filename"

                            if [ $? -eq 0 ]; then
                                echo "Permission changed successfully."
                            else
                                echo "Failed to change permission."
                            fi
                        fi
                        ;;

                    8)
                        break
                        ;;

                    *)
                        echo "Invalid choice!"
                        ;;
                esac

                echo
                read -p "Press Enter to continue..."
            done
            ;;


        # ==================================
        # 11. EXIT
        # ==================================
        11)
            echo "================================"
            echo " Exiting Linux Admin Toolkit..."
            echo "================================"
            exit 0
            ;;

        *)
            echo "Invalid choice! Please select 1-11."
            ;;
    esac

    echo
    read -p "Press Enter to continue..."

done
