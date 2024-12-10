# Starcraft Data Pipeline

## **Status: Work in Progress 🚧**

This repository is under active development. It implements the data ingestion pipeline for collecting, processing, and injecting Starcraft II replay data into the `starcraft-data-platform` database.

---

## **Overview**

The **Starcraft Data Pipeline** automates the ingestion of Starcraft II replay data, enabling seamless integration with downstream analytics and machine learning workflows.

### **Key Features**:
- **Replay Collection**:
  - Fetches replay files from external sources using scrapers.
  - Handles asynchronous scraping for high performance.
- **Storage Abstractions**:
  - Saves replays to local storage or cloud services like Amazon S3.
- **Database Integration**:
  - Processes and injects structured replay data into the `starcraft-data-platform` database.

---

## **Planned Features**

1. **Core Functionality**:
   - Scrapers for multiple replay hosting websites.
   - Flexible storage backends (local and cloud-based).
   - Injection pipeline for database integration.

2. **Technology Stack**:
   - Python with `asyncio` for asynchronous scraping and processing.
   - PostgreSQL as the database backend (via `starcraft-data-platform`).
   - Amazon S3 for scalable storage.

3. **Future Enhancements**:
   - Add real-time monitoring of scraping progress.
   - Integrate advanced error handling and retry mechanisms.
   - Extend support to additional replay sources or APIs.

---

## **Current Focus**

The current phase of development is focused on:
- Building the scraper framework to collect replay data.
- Implementing storage backends (local and S3).
- Creating the injection logic for loading replays into the database.

---

## **Getting Started**

⚠️ **This project is not yet ready for deployment or public use.** Setup instructions will be added as development progresses.

---

## **Planned Structure**

This repository will be organized into the following structure:

- **`scrape/`**: Handles replay collection from external sources.
  - **`factory.py`**: Manages multiple scrapers and coordinates their execution.
  - **`scrapers/`**: Directory for specific scraper implementations.
    - Example: A scraper for Website A.
  - **`utils.py`**: Utility functions for common scraping operations.

- **`inject/`**: Handles processing and injecting data into the database.
  - **`inject.py`**: Core logic for transforming and inserting replay data.
  - **`utils.py`**: Helper functions for data cleaning and preparation.

- **`shared/`**: Contains shared utilities and abstractions used by the pipeline.
  - **`storage.py`**: Abstract base class for storage backends.
    - Includes `LocalStorage` for saving to the local filesystem.
    - Includes `S3Storage` for uploading to Amazon S3.
  - **`config.py`**: Configuration settings for the pipeline.
  - **`logging.py`**: Logging setup for tracking progress and errors.

- **`tests/`**: Contains unit tests for each module.
  - **`test_scrape.py`**: Tests for scraper functionality.
  - **`test_inject.py`**: Tests for the injection pipeline.
  - **`test_storage.py`**: Tests for local and S3 storage backends.

- **`Dockerfile`**: Configuration for containerizing the pipeline, ensuring consistent environments for development and deployment.

- **`README.md`**: This documentation file, providing an overview of the project and its structure.

---

## **How to Contribute**

Contributions are welcome once the repository reaches a stable state. If you'd like to collaborate, please reach out or open an issue to discuss ideas.

---

## **License**

[MIT License]

---
