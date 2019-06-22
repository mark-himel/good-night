# good-night
An application that'll track how much you're friends have slept along with follow unfollow mechanism.
All services will be done through API requests.

# Installation
```
bundle install
rake db:create
rake db:schema:load
rake db:seed (some basic seed data will be inserted to get started with)
rails s (start the server)
```

# API endpoints

1. Create a User
```
Request:
POST http://base_url:port/api/users?name=Tony Stark
```
```
Response:
{
    "id": 6,
    "name": "Tony Stark",
    "followers": [],
    "following": []
}
```

2. Fetch a user
```
Request:
GET http://base_url:port/api/users/1

```
```
Response:
{
    "id": 1,
    "name": "Mark",
    "followers": [
        {
            "id": 2,
            "name": "Tony Stark"
        },
        {
            "id": 3,
            "name": "Junan"
        },
        {
            "id": 4,
            "name": "Swakhar"
        }
    ],
    "following": [
        {
            "id": 2,
            "name": "Tony Stark"
        },
        {
            "id": 3,
            "name": "Junan"
        }
    ]
}
```
3. Check in when you go to sleep
```
Request:
POST http://base_url:port/api/users/2/check_in
```
```
Response:
{
    "user_id": 2,
    "check_in_time": "2019-06-22T16:01:48",
    "check_out_time": null,
    "date": "2019-06-22",
    "total_slept": null
}
```
4. Check out when you wake up
```
Request:
POST http://base_url:port/api/users/2/check_out
```
```
Response:
{
    "user_id": 2,
    "check_in_time": "2019-06-22T16:01:48",
    "check_out_time": "2019-06-22T16:03:45",
    "date": "2019-06-22",
    "total_slept": "00:01:57"
}
```
5. To follow a user
```
Request:
POST http://base_url:port/api/users/1/follow?followed_user_id=3
```
```
Response:
{
    "id": 1,
    "name": "Mark",
    "followers": [
        {
            "id": 2,
            "name": "Tony Stark"
        },
        {
            "id": 3,
            "name": "Junan"
        },
        {
            "id": 4,
            "name": "Swakhar"
        }
    ],
    "following": [
        {
            "id": 2,
            "name": "Tony Stark"
        },
        {
            "id": 3,
            "name": "Junan"
        }
    ]
}
```
6. To unfollow a user
```
Request:
POST http://base_url:port/api/users/1/unfollow?followed_user_id=3
```
```
Response:
{
    "id": 1,
    "name": "Mark",
    "followers": [
        {
            "id": 2,
            "name": "Tony Stark"
        },
        {
            "id": 3,
            "name": "Junan"
        },
        {
            "id": 4,
            "name": "Swakhar"
        }
    ],
    "following": [
        {
            "id": 2,
            "name": "Tony Stark"
        }
    ]
}
```
7. The friends list along with their weekly sleeping record
```
Request:
GET http://base_url:port/api/users/1/friends
```

```
Response:
[
    {
        "id": 2,
        "name": "Tony Stark",
        "weekly_sleeping_records": [
            {
                "user_id": 2,
                "check_in_time": "2019-06-22T12:31:12",
                "check_out_time": "2019-06-22T12:31:19",
                "date": "2019-06-22",
                "total_slept": "00:00:06"
            },
            {
                "user_id": 2,
                "check_in_time": "2019-06-22T12:30:38",
                "check_out_time": "2019-06-22T12:30:56",
                "date": "2019-06-22",
                "total_slept": "00:00:17"
            },
            {
                "user_id": 2,
                "check_in_time": "2019-06-15T17:20:56",
                "check_out_time": "2019-06-16T11:20:56",
                "date": "2019-06-15",
                "total_slept": "18:00:00"
            }
        ]
    },
    {
        "id": 3,
        "name": "Junan",
        "weekly_sleeping_records": [
            {
                "user_id": 3,
                "check_in_time": "2019-06-22T14:43:28",
                "check_out_time": "2019-06-22T14:43:41",
                "date": "2019-06-22",
                "total_slept": "00:00:13"
            },
            {
                "user_id": 3,
                "check_in_time": "2019-06-20T17:20:56",
                "check_out_time": "2019-06-21T03:20:56",
                "date": "2019-06-20",
                "total_slept": "10:00:00"
            }
        ]
    }
]
```