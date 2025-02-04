import express from 'express';

const app = express();
app.use(express.json()); // middleware care parseaza body-ul request-ului

let db = [
    {
        id: 0,
        title: 'Pride and Prejudice',
        author: {
            name: 'Jane Austen',
        }
    },
    {
        id: 1,
        title: 'Zenobia',
        author: {
            name: 'Gellu Naum',
        }
    }
]

const getNextId = () => {
    return db.length;
}

// (read) GET /books - list all books
// (read) GET /book/<id> - list book with <id>
// (create) POST /book - create a new book
// (update) PUT /book/<id> - update book with <id>
// (delete) DELETE /book/<id> - delete book with <id>

// CRUD App iti ofera posibilitatea sa manageuiesti entitati


// Implementare de endpoint-uri

app.get('/books', (req, res) => {
    res.send(db);
});

app.get('/book/:id', (req, res) => {
    const bookId = parseInt(req.params.id); // atentie asta e string daca nu ii dam parseInt
    const book = db.find(book => book.id == bookId);
    // const book = db.filter((item) => { 
    //     return item.id === bookId
    // }); --> filter returneaza un array

    if (!book) {
        res.status(404).send('Book not found');
        return;
    }

    res.send(book);
});

app.post('/book', (req, res) => {
    const { title, author: { name } } = req.body;

    const book = {
        id: getNextId(),
        title, // echivalent cu title: title, deoarce au exact acelasi nume
        author: {
            name, // echivalent cu name: name
        }
    }
    db.push(book);
    res.send(book);
});

app.put('/book/:id', (req, res) => {
    const bookId = parseInt(req.params.id);
    const bookData = req.body;

    const newDb = db.map(item => {
        if (item.id === bookId) {
            return {
                ...item,
                ...bookData
            }
        }
        return item;
    });

    db = newDb;
    res.send(bookData);
});

app.delete('/book/:id', (req, res) => {
    const bookId = parseInt(req.params.id);

    const newDb = db.filter((item) => {
        // item.id !== bookId    asta e one line way of writing (asa as fi scris eu)

        if (item.id === bookId) {
            return false;
        }
        return true;
    });

    db = newDb;
    res.send(); // delete-ul nu ar trebui sa returneze nimic, status code-ul 200 OK e suficient
});

app.listen(8081, () => {
    console.log('Server is running on port 8081');
});


// Pentru lab-ul asta e nevoie de POSTMAN (de la Smarthack de exemplu) pentru a putea face request-uri de tip POST, PUT, DELETE