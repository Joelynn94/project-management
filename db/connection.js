require("dotenv").config();
const { Pool } = require("pg");

const pool = new Pool({
	user: process.env.PGUSER,
	host: process.env.PGHOST,
	database: process.env.PGDATABASE,
	password: process.env.PGPASSWORD,
	port: 5432,
});

// the pool will emit an error on behalf of any idle clients
// it contains if a backend error or network partition happens
pool.on("error", (err, client) => {
	console.error("Unexpected error on idle client", err);
	process.exit(-1);
});

const createUser = (request, response) => {
	const { name, email, password } = request.body;

	pool.query(
		"INSERT INTO users (name, email) VALUES ($1, $2, $3)",
		[name, email, password],
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

const getUserById = (request, response) => {
	const id = parseInt(request.params.id);

	pool.query("SELECT * FROM users WHERE id = $1", [id], (error, results) => {
		if (error) {
			throw error;
		}
		response.status(200).json(results.rows);
	});
};

const updateUser = (request, response) => {
	const id = parseInt(request.params.id);
	const { name, email, password } = request.body;

	pool.query(
		"UPDATE users SET name = $1, email = $2 password = $3 WHERE id = $4",
		[name, email, password, id],
		(error, results) => {
			if (error) {
				throw error;
			}
			response.status(200).send(`User modified with ID: ${id}`);
		}
	);
};

const deleteUser = (request, response) => {
	const id = parseInt(request.params.id);

	pool.query("DELETE FROM users WHERE id = $1", [id], (error, results) => {
		if (error) {
			throw error;
		}
		response.status(200).send(`User deleted with ID: ${id}`);
	});
};

module.exports = {
	createUser,
	getUsers,
	getUserById,
	updateUser,
	deleteUser,
};
