from flask import Flask

app = Flask(__name__)


@app.route('/')
def hello():
    return "Hello from Docker!"


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5005)

"""
This code is common in Python applications and specifically in web applications (like Flask)
to ensure the script runs correctly when executed directly.

### Code Breakdown:
1. **`if __name__ == '__main__':`**
   - This condition checks if the Python file is being run directly (e.g., `python my_script.py`) rather than
     being imported as a module into another script.
   - When a Python script is run, the special variable `__name__` is set to `'__main__'`.
   - If the file is imported elsewhere, `__name__` will instead be the name of the module (e.g., `'my_script'`).

2. **`app.run(host='0.0.0.0', port=5000)`**
   - This starts the WEB APPLICATION SERVER.
   - **`host='0.0.0.0'`**: 
     - Makes the application accessible to external devices, not just localhost. 
       It binds the server to all network interfaces.
     - If you used `host='127.0.0.1'`, it would only be accessible from the same machine.
   - **`port=5000`**:
     - Specifies the port where the application will listen for incoming HTTP requests.

### Why It's Important:
- This structure ensures the app runs only when executed directly,
  avoiding accidental execution when the script is imported elsewhere.
"""
