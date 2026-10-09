# sgeoWebServices
RESTful API built with Perl/Dancer2 to decouple the S-GeO legacy relational database and serve a modern React single-page application

## JWT Authentication

The API endpoints are secured using JSON Web Tokens (JWT).

### Obtaining a Token

To obtain a JWT, send a `POST` request to `/api/auth/login` with your credentials (e.g., `username`). The server will respond with a token:

```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

### Using the Token

Once you have a token, include it in the `Authorization` header of subsequent requests to protected API endpoints:

```
Authorization: Bearer <your_jwt_token>
```

### Configuration

The secret used to sign the JWT can be configured in two ways:
1. Setting the `JWT_SECRET` environment variable.
2. Setting `jwt_secret` in the Dancer2 configuration file (e.g., `config.yml`).

If neither is provided, a default insecure secret is used for development purposes.

### Interactive Example

An interactive HTML page is available to demonstrate the JWT login and data fetching flow. Once the server is running, navigate to `/example_jwt` in your browser to test it out.
