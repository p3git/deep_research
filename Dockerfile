# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Install uv
RUN pip install uv

# Copy the project dependency files
COPY pyproject.toml uv.lock ./

# Install dependencies using uv
# Using --system to install in the global python environment
RUN uv pip install --system -r pyproject.toml

# Copy the rest of the application source code
COPY . .

# Install the project in editable mode
RUN uv pip install --system -e .

# Expose the port the app runs on
EXPOSE 2024

# Command to run the application
# We add --host 0.0.0.0 to allow external connections to the container
CMD ["langgraph", "dev", "--host", "0.0.0.0", "--port", "2024"]
