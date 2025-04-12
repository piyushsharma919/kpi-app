# KPI Dashboard

A modern, high-performance KPI (Key Performance Indicator) dashboard built with Ruby on Rails 8. This application provides a robust platform for tracking and visualizing business metrics with real-time updates and comprehensive analytics.

## Table of Contents

- [Features](#features)
- [Technology Stack](#technology-stack)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Testing](#testing)
- [Development](#development)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [Contact](#contact)

## Features

- KPI tracking and visualization
- User authentication and authorization
- Responsive design with modern UI components
- Performance optimization with caching
- Secure data handling
- Docker containerization support
- Comprehensive testing suite

## Technology Stack

### Backend
- Ruby 3.4.2
- Rails 8.0.2
- PostgreSQL
- Puma web server
- Turbo Rails for real-time updates
- Stimulus.js for frontend interactivity

### Performance & Optimization
- Oj for JSON processing
- Bullet for N+1 query detection
- Rack Mini Profiler
- Fast JSON API
- Solid Cache & Queue
- Solid Cable for WebSocket support

### Development & Testing
- RSpec for testing
- Factory Bot for test data
- RuboCop for code quality
- Brakeman for security scanning
- SimpleCov for test coverage

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/piyushsharma919/kpi-app.git
   cd kpi
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seeds
   ```

4. Copy environment variables:
   ```bash
   cp .env.example .env
   ```

5. Start the development server:
   ```bash
   rails server
   ```

## Configuration

The application requires the following environment variables (see `.env.example`):

```env
# Database Configuration
RAILS_MAX_THREADS=5
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=postgres
DB_PASSWORD=your_secure_password
DB_NAME_DEVELOPMENT=kpi_development
DB_NAME_TEST=kpi_test

# Production Database
DB_USERNAME_PRODUCTION=kpi
DB_PASSWORD_PRODUCTION=your_secure_password
DB_NAME_PRODUCTION=kpi_production
DB_NAME_PRODUCTION_CACHE=kpi_production_cache
DB_NAME_PRODUCTION_QUEUE=kpi_production_queue
DB_NAME_PRODUCTION_CABLE=kpi_production_cable
```

## Usage

1. Start the development server:
   ```bash
   rails server
   ```

2. Access the application at `http://localhost:3000`

3. For background jobs:
   ```bash
   rails solid_queue:start
   ```

4. For WebSocket support:
   ```bash
   rails solid_cable:start
   ```

## Testing

The application uses RSpec for testing. To run the test suite:

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/path/to/test_file.rb

# Run tests with coverage
COVERAGE=true bundle exec rspec
```

## Development

### Code Quality

- Run RuboCop:
  ```bash
  bundle exec rubocop
  ```

- Run security checks:
  ```bash
  bundle exec brakeman
  ```

### Debugging

The application includes several debugging tools:
- Better Errors
- Pry Rails
- Pry Byebug
- Bullet for N+1 queries

## Deployment

The application can be deployed using Kamal:

```bash
# Deploy to production
bundle exec kamal deploy

# Deploy with specific version
bundle exec kamal deploy --version v1.0.0
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Please ensure your code:
- Follows the existing style
- Includes tests
- Updates documentation
- Passes all tests and linting checks

## Contact

- Project Link: [https://github.com/piyushsharma919/kpi-app](https://github.com/piyushsharma919/kpi-app)
- Author: [Piyush Sharma]
- Email: [piyush.sharma919@gmail.com]

For support, please open an issue in the GitHub repository.
