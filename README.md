# FlaskWebSync

A simple and flexible starter template for building web applications with Flask. Also, demonstrates how to host a Flask application on PythonAnywhere with CI/CD implementation using GitHub Actions and Webhooks.
  
## Features

- **Lightweight & Flexible:** Start building web applications quickly with a minimal and adaptable Flask template.
- **Structured Setup:** Comes with a well-organized project structure to help you maintain and scale your Flask application.
- **PythonAnywhere Integration:** Includes step-by-step instructions for deploying your Flask app on PythonAnywhere, making it easy to host and manage your application.
- **CI/CD with GitHub Actions:**
  - **Automated Testing:** Configure GitHub Actions to run automated tests on your code with every push, ensuring that only tested and verified code is deployed.
  - **Continuous Deployment:** Automatically deploy your application to PythonAnywhere when changes are pushed to the repository. This setup uses webhooks to trigger deployments, reducing manual intervention.
  - **Deployment Pipeline:** Set up a streamlined pipeline that includes building, testing, and deploying your application, making the deployment process seamless and efficient.
- **Webhook Integration:**
  - **Trigger Deployments:** Use webhooks to automatically trigger deployments to PythonAnywhere whenever code is pushed to the repository.
  - **Post-Merge Hook:** Includes a `post-merge` script to reload your application on PythonAnywhere after code updates, ensuring that the latest changes are always live.
- **Configuration Management:** Easily manage and update your web app’s configurations and dependencies directly through PythonAnywhere’s interface and virtual environment.
- **Customizable:** The template is designed to be easily customizable, allowing you to adapt it to fit various project requirements and deployment environments.
- **Documentation:** Comprehensive setup and configuration instructions provided, including details for integrating with PythonAnywhere and configuring CI/CD pipelines.

With these features, you can efficiently build, deploy, and manage your Flask application, while leveraging modern CI/CD practices to streamline your development workflow.


## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- [Python 3.8](https://www.python.org/downloads/)
- [Pip](https://pip.pypa.io/en/stable/installation/)
- [Virtualenv](https://virtualenv.pypa.io/en/latest/)

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/Rahulkumar010/FlaskWebSync.git
   cd FlaskWebSync
   ```

2. **Create a Virtual Environment**

   ```bash
   python -m venv venv
   ```

3. **Activate the Virtual Environment**

   - On Windows:
     ```bash
     venv\Scripts\activate
     ```
   - On macOS/Linux:
     ```bash
     source venv/bin/activate
     ```

4. **Install Dependencies**

   ```bash
   pip install -r requirements.txt
   ```

### Usage

1. **Run the Application**

   ```bash
   python server.py
   ```

   The application will start on `http://127.0.0.1:5000/` by default.

2. **Access the Application**

   Open your web browser and navigate to `http://127.0.0.1:5000/`.


- Run with `waitress` (production-like):

```bash
waitress-serve --host=0.0.0.0 --port=5000 server:app
```

**Production (Waitress) — notes**

- `server.py` currently starts the Flask development server (`app.run()`) when run directly. For production deployments, use `waitress-serve` (as shown above) or another WSGI server. The project's `Dockerfile` uses `waitress-serve` by default.
- Ensure `waitress` is present in `requirements.txt` (it is listed in this repo).

**Pre-push checklist**

- **Environment:** Verify `.env` / instance config does not contain secrets committed to the repo.
- **Tests:** Run `pytest -q` and resolve failures before pushing.
- **Build:** Optionally build the Docker image locally to confirm the container starts:

### Running with Docker / Containers

- **Files added:** `Dockerfile`, `compose.yaml`, `.dockerignore`, `README.Docker.md`.
- **Build & run (Docker Compose):**

```bash
docker compose up --build
```

- **Build image and run (Docker):**

```bash
docker build -t flaskwebsync .
docker run --rm -p 5000:5000 flaskwebsync
```

- The container serves the app on port `5000` (host) mapped to `5000` in the container.
- See `README.Docker.md` for additional deployment and platform notes.

### Directory Structure

```
FlaskWebSync/
│
├── app               # Main application
├── .env              # Environment variables
├── requirements.txt  # Project dependencies
├── static/           # Static files (CSS, JS, images)
└── templates/        # HTML templates
```

## Setting Up Continuous Deployment

1. **Create and Push the Flask Application**
   - Develop your Flask application, generate the `requirements.txt` file with the following command and push it to GitHub:
     ```bash
     pipreqs ..\sample-flask-app --savepath requirements.txt
     ```

2. **Create a PythonAnywhere Account**
   - Sign up for a PythonAnywhere account [here](https://www.pythonanywhere.com/).

3. **Clone the Repository**
   - Open the Bash terminal in PythonAnywhere and clone your GitHub repository.

4. **Set Up the Web App**
   - Follow the instructions provided by PythonAnywhere to set up your web application.

5. **Configure GitHub Webhook**
   - Add the `./git_update` script to your main script (e.g., `server.py`) and create a webhook with the endpoint like:
     ```
     https://{username|custom_domain}.pythonanywhere.com/git_update
     ```

6. **Create a Post-Merge Hook**
   - Create a file named `post-merge` with the following content under the `./git/hooks` directory of the cloned Git repository in PythonAnywhere:
     ```bash
     #!/bin/sh
     touch {path to WSGI configuration file}
     ```
     - The path to the WSGI configuration file typically looks like `/var/www/{your web application domain}_wsgi.py`.
     - You can find the WSGI configuration file [here](https://www.pythonanywhere.com/user/{username}/webapps/).

7. **Set Execution Permissions**
   - Provide execution permissions to the `post-merge` script with the following command:
     ```bash
     chmod +x post-merge
     ```

8. **Install Additional Dependencies**
   - Follow the guide [here](https://help.pythonanywhere.com/pages/Virtualenvs) to install additional dependencies for your web app and update the configuration accordingly.

9. **Continuous Deployment**
   - With the setup complete, any code updates committed to your GitHub repository will trigger the webhook, which updates the repository on PythonAnywhere. The `post-merge` script will execute to reload the web application, ensuring continuous deployment.


### Contributing

1. **Fork the Repository**

   Click on the “Fork” button at the top right of this page.

2. **Create a New Branch**

   ```bash
   git checkout -b feature/your-feature
   ```

3. **Commit Your Changes**

   ```bash
   git add .
   git commit -m "Add a meaningful commit message"
   ```

4. **Push to Your Fork**

   ```bash
   git push origin feature/your-feature
   ```

5. **Create a Pull Request**

   Go to the original repository and click “New Pull Request.”

### License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

### Contact

For questions or feedback, please reach out to [rahul01110100@gmail.com](mailto:rahul01110100@gmail.com).


### Notes

- **Env Configuration** such as `SECRET_KEY`, and any specifics in the directory structure with actual details from your project.
- **Add more detailed sections** if your app has additional features or complex setup steps.

Feel free to tweak the structure and content to better match your project’s needs!

---

Happy coding!
