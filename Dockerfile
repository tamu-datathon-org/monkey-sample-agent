FROM python:3.10-slim

RUN addgroup --system app && adduser --system --group app

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the participant's agent code
COPY . .

# Change ownership of the app directory to the non-root user
RUN chown -R app:app /app

USER app

EXPOSE 8080
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "agent:app"]
