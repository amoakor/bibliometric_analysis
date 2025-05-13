#!/usr/bin/env python3
"""
Data Loading Script for Academic Papers Visualizations
This script loads and processes the academic papers data for visualization.
"""

import pandas as pd
import numpy as np
import re

def load_data(file_path='data.csv'):
    """Load the CSV data and perform initial processing."""
    print(f"Loading data from {file_path}...")
    df = pd.read_csv(file_path)
    print(f"Loaded {len(df)} papers")
    return df

def process_multi_value_column(df, column_name):
    """Process columns with multiple comma-separated values."""
    # Extract all unique values
    all_values = set()
    for values in df[column_name].dropna():
        for value in values.split(','):
            value = value.strip()
            if value:
                all_values.add(value)
    
    # Count occurrences of each value
    value_counts = {}
    for value in all_values:
        count = sum(df[column_name].fillna('').apply(
            lambda x: 1 if value in [v.strip() for v in x.split(',')] else 0
        ))
        value_counts[value] = count
    
    # Sort by count (descending)
    sorted_counts = sorted(value_counts.items(), key=lambda x: x[1], reverse=True)
    
    return sorted_counts

def get_evaluation_types(df):
    """Extract and count evaluation types."""
    print("Processing evaluation types...")
    return process_multi_value_column(df, 'Type of evaluation')

def get_domains(df):
    """Extract and count domains."""
    print("Processing domains...")
    return process_multi_value_column(df, 'Domain')

def get_study_designs(df):
    """Extract and count study designs."""
    print("Processing study designs...")
    return process_multi_value_column(df, 'study_design')

def get_visualization_tools(df):
    """Extract and count visualization tools."""
    print("Processing visualization tools...")
    return process_multi_value_column(df, 'tools for data visualization')

def get_visualization_types(df):
    """Extract and count visualization types."""
    print("Processing visualization types...")
    return process_multi_value_column(df, 'types of data visualizations')

def prepare_data_for_visualizations(df):
    """Prepare all data needed for visualizations."""
    data = {
        'evaluation_types': get_evaluation_types(df),
        'domains': get_domains(df),
        'study_designs': get_study_designs(df),
        'visualization_tools': get_visualization_tools(df),
        'visualization_types': get_visualization_types(df)
    }
    return data

if __name__ == "__main__":
    # Load and process data
    df = load_data()
    data = prepare_data_for_visualizations(df)
    
    # Print summary statistics
    print("\nSummary Statistics:")
    print(f"Total papers: {len(df)}")
    print(f"Papers with DOI: {df['doi'].notna().sum()}")
    print(f"Papers with evaluation type: {df['Type of evaluation'].notna().sum()}")
    print(f"Papers with study design: {df['study_design'].notna().sum()}")
    print(f"Papers with visualization info: {df['types of data visualizations'].notna().sum()}")
    print(f"Papers with visualization tools: {df['tools for data visualization'].notna().sum()}")
    
    # Print top items in each category
    print("\nTop 5 Evaluation Types:")
    for item, count in data['evaluation_types'][:5]:
        print(f"  {item}: {count}")
    
    print("\nTop 5 Domains:")
    for item, count in data['domains'][:5]:
        print(f"  {item}: {count}")
    
    print("\nTop 5 Study Designs:")
    for item, count in data['study_designs'][:5]:
        print(f"  {item}: {count}")
    
    print("\nTop 5 Visualization Tools:")
    for item, count in data['visualization_tools'][:5]:
        print(f"  {item}: {count}")
