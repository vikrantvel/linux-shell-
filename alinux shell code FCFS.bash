#!/bin/bash

# Function to calculate waiting time and turnaround time
calculate_times() {
    n=$1
    arrival=("${@:2:($n)}")
    burst=("${@:((n + 2))}")

    # Initialize arrays for completion, turnaround, and waiting times
    completion=()
    turnaround=()
    waiting=()

    # Calculate completion times
    completion[0]=$((arrival[0] + burst[0]))
    for ((i=1; i<n; i++)); do
        if (( completion[i-1] < arrival[i] )); then
            completion[i]=$((arrival[i] + burst[i]))
        else
            completion[i]=$((completion[i-1] + burst[i]))
        fi
    done

    # Calculate turnaround and waiting times
    for ((i=0; i<n; i++)); do
        turnaround[i]=$((completion[i] - arrival[i]))
        waiting[i]=$((turnaround[i] - burst[i]))
    done

    # Print results
    echo -e "\nProcess\tArrival\tBurst\tCompletion\tTurnaround\tWaiting"
    for ((i=0; i<n; i++)); do
        echo -e "$((i+1))\t${arrival[i]}\t${burst[i]}\t${completion[i]}\t\t${turnaround[i]}\t\t${waiting[i]}"
    done
}

# Input: Number of processes
read -p "Enter the number of processes: " n

# Arrays for arrival and burst times
arrival=()
burst=()

# Input: Arrival times and Burst times
echo "Enter the arrival times of the processes:"
for ((i=0; i<n; i++)); do
    read -p "Process $((i+1)): " arrival[i]
done

echo "Enter the burst times of the processes:"
for ((i=0; i<n; i++)); do
    read -p "Process $((i+1)): " burst[i]
done

# Call function to calculate and display results
calculate_times $n "${arrival[@]}" "${burst[@]}"
