require("dotenv").config();
const { Pool } = require("pg");
const pool = new Pool({
	user: process.env.PGUSER,
	host: process.env.PGHOST,
	database: process.env.PGDATABASE,
	password: process.env.PGPASSWORD,
	port: process.env.PGPORT,
});

// the pool will emit an error on behalf of any idle clients
// it contains if a backend error or network partition happens
pool.on("error", (err, client) => {
	console.error("Unexpected error on idle client", err);
	process.exit(-1);
});

const createUser = (request, response) => {
	const { name, email } = request.body;

	pool.query(
		"INSERT INTO users (name, email) VALUES ($1, $2)",
		[name, email],
		(error, results) => {
			if (error) {
				throw error;
			}
			response
				.status(201)
				.send(`User added with ID: ${results.insertId}`);
		}
	);
};

const getUsers = (request, response) => {
	pool.query("SELECT * FROM users ORDER BY id ASC", (error, results) => {
		if (error) {
			throw error;
		}
		response.status(200).json(results.rows);
	});
};

module.exports = {
	getUsers,
	createUser,
};
