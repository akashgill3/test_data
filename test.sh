#!/bin/bash

# Function to create random content for markdown files
create_md_content() {
cat << EOF > "$1"
# Random Markdown File

## Introduction

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla facilisi. Proin ut lacus quis ligula feugiat auctor. Suspendisse potenti. Quisque sed ligula nec erat tincidunt accumsan. Aenean sed libero et erat interdum tincidunt sit amet a purus.

## Features

- **Easy to Read**: Markdown is a simple syntax that is easy to read and write.
- **Portable**: Works across different platforms and tools.
- **Versatile**: Supports headers, lists, links, and more.
- **Lightweight**: No additional software required to write Markdown.

## Usage

You can use Markdown for various purposes, such as:

1. Writing documentation.
2. Creating simple websites.
3. Taking notes.
4. Formatting text for blogs and forums.

## Code Example

## Blockquotes

> "The only way to do great work is to love what you do." — Steve Jobs

## Tables

| Feature  | Description                |
|----------|----------------------------|
| Headers  | Create headings easily     |
| Lists    | Support ordered/unordered  |
| Code     | Include inline & block code|

## Conclusion

Markdown is a powerful yet simple way to format text. Whether you're a developer, writer, or student, learning Markdown can help you write more efficiently. Start using it today and enhance your workflow!
EOF
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

# Create 20 principles
for i in {1..20}; do
    principle_dir="Principle$i"
    mkdir -p "$principle_dir"
    
    # Create principle files
    create_md_content "$principle_dir/principle$i.md"
    create_principle_json "$principle_dir/principle$i.json"
    
    # Create 1-5 practises
    num_practises=$((RANDOM % 5 + 1))
    for j in {1..5}; do
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
