#!/bin/bash

# Function to create random content for markdown files
create_md_content() {
    echo "Created on: $(date '+%Y-%m-%d %H:%M:%S')" > "$1"
    echo "Random content: $RANDOM" >> "$1"
}

# Function to create principle JSON
create_principle_json() {
    cat << EOF > "$1"
{
    "owner": "user$((RANDOM % 10 + 1))",
    "tags": ["tag$((RANDOM % 5 + 1))", "tag$((RANDOM % 5 + 1))"],
    "name": "$(basename $(dirname "$1"))",
    "value": "value $((RANDOM % 100))"
}
EOF
}

# Function to create practise/subpractise JSON
create_practise_json() {
    cat << EOF > "$1"
{
    "owner": "user$((RANDOM % 10 + 1))",
    "tags": ["tag$((RANDOM % 5 + 1))", "tag$((RANDOM % 5 + 1))"],
    "name": "$(basename $(dirname "$1"))",
    "metrics": "metric1 $((RANDOM % 100))"
}
EOF
}

# Create 10 principles
for i in {1..10}; do
    principle_dir="Principle$i"
    mkdir -p "$principle_dir"
    
    # Create principle files
    create_md_content "$principle_dir/principle$i.md"
    create_principle_json "$principle_dir/principle$i.json"
    
    # Create 1-3 practises
    num_practises=$((RANDOM % 3 + 1))
    for j in {1..3}; do
        if [ $j -le $num_practises ]; then
            practise_dir="$principle_dir/Practise$j"
            mkdir -p "$practise_dir"
            
            # Create practise files
            create_md_content "$practise_dir/practise$j.md"
            create_practise_json "$practise_dir/practise$j.json"
            
            # Create 1-3 subpractises
            num_subpractises=$((RANDOM % 3 + 1))
            for k in {1..3}; do
                if [ $k -le $num_subpractises ]; then
                    subpractise_dir="$practise_dir/SubPractise$k"
                    mkdir -p "$subpractise_dir"
                    
                    # Create subpractise files
                    create_md_content "$subpractise_dir/subpractise$k.md"
                    create_practise_json "$subpractise_dir/subpractise$k.json"
                fi
            done
        fi
    done
done

echo "Directory structure and files created successfully!"
