console.log("Salut 1");

const callbackFn = () => {
    console.log("Salut 2");
}

setTimeout(callbackFn, 0); // daca nu e nimic in callstack peste 0ms ruleaza ce e in callstack
// cu fetch se face un request catre un server si se asteapta un raspuns, dureaza mai mult de 200ms si se pune in callstack 


// Promises

const response = fetch('https://www.example.com');

console.log(response); // o sa fie pending pentru ca nu a primit inca un raspuns

// response
//     .then((response) => {
//         response.json();
//     })
//     .then((user) => {
//         console.log(user.firstName + ' ' + user.lastName);
//     });

// const myPromiseFn = () => {
//     return new Promise
// }

// cel mai simplu though e cu async si await

// daca pun await in fata la fetch, e ca si cum as pune cu then
// async spune ca functia va avea await in ea



// Exemple

import fs from 'fs';

const readMyFile = new Promise((resolve, reject) => { // promit ca se va intampla asta
    fs.readFile('data.txt', (err, data) => {
        if (err) { // orice eroare, precum fisierul nu exista
            reject('Error!'); // daca avem eroare, trebuie sa dam reject
            return; // sa ne asiguram ca nu se executa si resolve
        }
        resolve(data.toString());
    });
    // setTimeout(() => {
    //     resolve("Emoji");
    // }, 1000); // apeleaza resolve dupa 1 secunda
});

readMyFile
    .then((response) => { // dupa ce se intampla promisiunea stiu ca asta se va intampla
        console.log('Am terminat', response);
    })
    .catch((err) => {
        console.log('Avem o eraore:', err);
    });




// async si await

const readMyFileAsync = () => {
    return new Promise((resolve, reject) => {
        fs.readFile('data.txt', (err, data) => {
            if (err) { // orice eroare, precum fisierul nu exista
                reject('Error!'); // daca avem eroare, trebuie sa dam reject
                return; // sa ne asiguram ca nu se executa si resolve
            }
            resolve(data.toString());
        });
    });
}

const logTheContentsOfTheFile = async () => {
    try {
        const response = await readMyFileAsync();
        console.log('Am terminat', response);
    } catch (err) {
        console.log('Avem o eraore:', err);
    }

    // .then((response) => { // dupa ce se intampla promisiunea stiu ca asta se va intampla
    //     console.log('Am terminat', response);
    // })
    // .catch((err) => {
    //     console.log('Avem o eraore:', err);
    // });
}

logTheContentsOfTheFile(); // o sa astepte pana se termina de citit fisierul





// Exemplu cu fetch

import express from 'express'; 

const app = express();

// http://dog-api.kindstuff.com/api/facts?number=1

app.get('/getDogFact', async (request, response) => {
    // Varianta cam dubioasa fara async sus 

    // // 1. Request la API
    // fetch('http://dog-api.kinduff.com/api/facts?number=1')
    //     .then((fetchResponse) => {
    //         return fetchResponse.json();
    //     })
    //     .then((data) => {
    //         // 2. Returnam raspunsul
    //         response.send(data);
    //     });
    //     // .then((fetchResponse) => {
    //     //     fetchResponse.json().then((data) => {
    //     //         console.log(data);
    //     //         response.send(data);
    //     //     });
    //     // });
    

    const fetchResponse = await fetch('http://dog-api.kinduff.com/api/facts?number=1');
    const data = await fetchResponse.json();
    response.send(data);
});

app.listen(8080, () => {
    console.log('Server is running on port 8080');
});