## Use the official Python image as the base image
#FROM python:3.9-slim
#
## Set the working directory inside the container
#WORKDIR /app
#
## Copy the requirements file into the container
##It takes the requirements.txt file from your local machine (where you're building the Docker image) and
##copies it into the container's filesystem at the current working directory (set earlier by WORKDIR /app)
#COPY requirements.txt .
#
## Install the dependencies
#RUN pip install -r requirements.txt
#
## Copy the rest of the application files
##It copies all the files and directories from your local project directory (the one containing your Dockerfile)
##into the working directory inside the container (/app in this case)
##This step ensures that all your application files—such as Python scripts, templates, static files, \
##or configurations—are available inside the container. These are the files your application needs to run.
##For example:
##If your app has app.py (the main script), it gets copied into /app inside the container.
##If there are templates or static files, they are also copied so your app can use them.
##Without it:
##Your container would have only the base Python image and dependencies from requirements.txt,
##but not your application code. This would make the container incomplete and unable to execute your application.
#COPY . .
#
## Expose port 5000 on the CONTAINER for the application, the app will run on port 5000(in the container)
##this command is a signal to indicate which port the container will use when running.
##It tells Docker that the container will listen on the specified port for incoming traffic.
##this container expects traffic on port 5000
#EXPOSE 5005
#
## Run the application
#CMD ["python", "app.py"]
##CMD used to define the primary process or script your container should run (e.g., a web server, application, etc.)
##Only one CMD is allowed in a Dockerfile. If multiple CMD instructions are defined, the last one is used.
##The preferred form is a JSON array: CMD ["executable", "arg1", "arg2"].
##This ensures arguments are passed correctly without relying on the container's default shell
##In summary, CMD defines the main process your container should run by default when it starts.
##In my case, it starts the app.py script using Python.
#
##Additional explanations:
##Why do we need to # Set the working directory inside the container?
##Setting the **working directory** inside the container with the `WORKDIR` instruction serves several purposes:
##
##1. **Default location for commands**:
##   Any command that runs after setting `WORKDIR` will execute relative to this directory. For example:
##   ```dockerfile
##   WORKDIR /app
##   RUN echo "Hello" > example.txt
##   ```
##   This writes `example.txt` to `/app`.
##
##2. **Organized file structure**:
##   It helps maintain a clean and predictable file structure in the container.
##   Instead of dumping everything in the root (`/`), the application and its dependencies go in a dedicated directory.
##
##3. **Ease of use**:
##   When the container is started, you'll start in this directory by default.
##   This is especially useful if you're debugging or running commands interactively.
##
##4. **Reproducibility**:
##   If others use or modify your container, they’ll know where the application files are located.
##
##In summary, `WORKDIR` ensures that your commands and file operations are scoped to the desired location inside the container,
##making the environment predictable and organized.

FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the dependencies
RUN pip install -r requirements.txt

# Copy the rest of the application files
COPY . .

# Expose port 5005 on the CONTAINER for the application
EXPOSE 5005

# Run the application
CMD ["python", "app.py"]
