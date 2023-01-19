# Verifica Rails Example

[https://verifica-rails-example.maximgurin.com](https://verifica-rails-example.maximgurin.com)

Ruby on Rails example application for [Verifica](https://github.com/maximgurin/verifica) 
authorization gem based on Access Control Lists.
ACL provides a powerful solution for the sophisticated authorization requirements of growing applications.
Namely when authorization rules become too complex to be expressed in a single SQL query
while the database is too big to execute these rules in the application code.

Please check [real-world example documentation](https://github.com/maximgurin/verifica#real-world-example-with-rails)
to get a complete picture of what problem Verifica
is designed to solve and a list of authorization rules implemented in this example.

## Development

### Prerequisites

- Ruby, Node.js (versions from `.tool-versions`)
- Yarn
- PostgreSQL on `localhost:5432`, username `postgres`, password `postgres`

After checking out the repo, run `bin/setup` to install dependencies and setup database.
Run `yarn install` to install Node.js dependencies.
Run `bin/dev` to run the application server accessible at [http://127.0.0.1:21100](http://127.0.0.1:21100)
