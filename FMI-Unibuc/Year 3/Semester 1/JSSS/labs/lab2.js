// Data Types

var myVar = 0; // deprecated
let myVar2 = 0;

const myConst = function() {
    console.log('Did stuff');
    return "Something else";
}

function myFunction() {
    console.log('Did stuff');
    return "Something else";
}

const myOtherFunction = (arg1, arg2) => {
    console.log('My other function');
    return;
}

const myOtherOtherFunction = args => {
    console.log('My other other function');
    return;
} // daca am un singur param, nu mai am nevoie de paranteze

const sum = (a, b) => a + b; // daca am o singura expresie, pot sa scot acoladele si return

// myConst = "altceva"; // Error
myConst();
myOtherFunction();
console.log(sum(1, 2));





// Arrays



const myArray = [0, 1, 2, 3];
myArray.push(4);
console.log(myArray[0]);
console.log(myArray.length);

// Iterare prin array

for (let i = 0; i < myArray.length; i++) { // deprecated
    console.log(myArray[i]);
}

console.log('---');

myArray.forEach((element, index) => { // much better
    console.log("Item value", element);
});

const logIt = (element, index, originalArray) => { // we can even do this
    console.log("Item value", element);
}

myArray.forEach(logIt);

console.log('---');

const result = myArray.map((element) => { // map returneaza un array nou cu acelasi nr de elemente ca array-ul original
    console.log("Item value", element);
    return element % 2;
});

const mrResults = myArray.filter((element) => { // filter returneaza un array nou cu elementele care trec de conditia data
    return element % 2 === 0;
});

console.log(result);
console.log(mrResults);

const myIndex = myArray.indexOf(2); // returneaza indexul elementului (primul gasit) cautat
console.log(myIndex);

const sumWithReduce = myArray.reduce((acc, element) => { // reduce returneaza un singur element, cu ajutorul unei logici pe care o facem in interiorul functiei
    console.log('Acc', acc);
    console.log('Element', element);
    return acc + element;
}, 0); // acest 0 este valoarea initiala a lui acc, primul argument al functiei reduce e functia mea, iar al doilea e valoarea initiala a lui acc

console.log(sumWithReduce);

const a = [1, 2, 3];
const b = [4, 5, 6];
const c = [...a, ...b]; // spread operator

console.log(c);



// Objects

const ageProp = 5;
const firstNameProp = "John";
const lastNameProp = "Doe";

const properties = {
    age: ageProp,
    firstName: firstNameProp,
    lastName: lastNameProp
}

const Person = {
    // va merge si asa daca sunt declarate in acelasi scop 
    // firstNameProp
    // lastNameProp
    // ageProp
    firstName: "John",
    lastName: "Doe",
    getFullName: function() { // daca am fi facut un arrow function, this ar fi fost undefined
        console.log(this);
        return this.firstName + ' ' + this.lastName;
    }
}

const Person2 = {
    ...properties,
    getFullName: function() { // daca am fi facut un arrow function, this ar fi fost undefined
        console.log(this);
        return this.firstName + ' ' + this.lastName;
    }
}


console.log(Person['firstName']);
console.log(Person.firstName);

Person.firstName = "Jane"; // e ok ca sunt pasate dupa refereinta

const Name = Person.getFullName();
console.log(Name);
console.log('-----');
console.log(Person2.getFullName());

const { firstName, age, ...rest } = Person2; // destructuring
console.log(firstName, age, rest);