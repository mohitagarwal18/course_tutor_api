# Course and Tutor API

This Rails application provides APIs for managing courses and tutors.

## Setup

 1. Clone the repository: `git clone https://github.com/mohitagarwal18/course_tutor_api.git`
  2. Install dependencies: `bundle install`
  3. Set up the database: `rails db:create && rails db:migrate`
  4. Start server on localhost: `rails s`

## Endpoints


### Create Course with Tutors

- **Endpoint:** `POST /api/create`
- **Request Body:**
  ```json
  {
    "course": {
      "name": "Course Name"
    },
    "tutors": [
      {
        "name": "Tutor 1",
        "email": "tutor1@example.com"
      },
      {
        "name": "Tutor 2",
        "email": "tutor2@example.com"
      }
    ]
  }
  ```
  - **Response Body (Success):**


```json

{
  "course": {
    "id": 1,
    "name": "Course Name"
  },
  "tutors": [
    {
      "id": 1,
      "name": "Tutor 1",
      "email": "tutor1@example.com",
      "course_id": 1
    },
    {
      "id": 2,
      "name": "Tutor 2",
      "email": "tutor2@example.com",
      "course_id": 1
    }
  ]
}
```
- **Response Body (Error):**
```json

{
  "error": "Validation failed: Name can't be blank, Email is invalid"
}
```

**List Courses with Tutors**

- **Endpoint:** `GET /api/courses`
- **Query Parameters:**
```
page: Page number (default: 1)
page_size: Number of courses per page (default: 25)
```

-**Response Body:**

```json
{
  "courses": [
    {
      "id": 1,
      "name": "Course Name",
      "tutors": [
        {
          "id": 1,
          "name": "Tutor 1",
          "email": "tutor1@example.com",
          "course_id": 1
        },
        {
          "id": 2,
          "name": "Tutor 2",
          "email": "tutor2@example.com",
          "course_id": 1
        }
      ]
    }
  ],
}
```
**NOTE**:
If no parameters are provided, defaults to page=1 and page_size=25.


- **Endpoint:** `GET /api/courses/:id`

- **Response Body:**
```json

{
  "id": 1,
  "name": "Course Name",
  "tutors": [
    {
      "id": 1,
      "name": "Tutor 1",
      "email": "tutor1@example.com",
      "course_id": 1
    },
    {
      "id": 2,
      "name": "Tutor 2",
      "email": "tutor2@example.com",
      "course_id": 1
    }
  ]
}

```
**Running Tests:**

To run the test suite, execute the following command:
```
bundle exec rspec
```
