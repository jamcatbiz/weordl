import { writable } from 'svelte/store';

function getTodaysDateISO() {
    var thisDate = new Date();
    const offset = thisDate.getTimezoneOffset();
    thisDate = new Date( thisDate.getTime() - ( offset*60*1000 ));
    return thisDate.toISOString().substring( 0, 10 );
}

function getYesterdaysDateISO() {
    var thisDate = new Date();
    const offset = thisDate.getTimezoneOffset();
    thisDate = new Date( thisDate.getTime() - ( offset*60*1000 ));
    thisDate.setDate(thisDate.getDate() - 1);
    return thisDate.toISOString().substring( 0, 10 );
}

function getTodaysDateLocale() {
    var thisDate = new Date();
    const offset = thisDate.getTimezoneOffset();
    thisDate = new Date( thisDate.getTime() - ( offset*60*1000 ));
    const options = { month: 'long', day: '2-digit', year: 'numeric' };
    return thisDate.toLocaleString('en-US', options)
}

async function getGame(date) {
    const res = await fetch(`https://s3.amazonaws.com/weordl.com.games/days/${date}.json`);
    const data = await res.json();
    return data
}

/*
async function getTodaysGame(date) {
    return await import(`$lib/data/days/${date}.json`)
}
*/
function generateIsGuessed(word) {
    var guessMap = {}
    for (var char of word.toUpperCase()) {
        if ( char in guessMap ) {
            guessMap[char]['count'] += 1;
        } else {
            guessMap[char] = {'count': 1, 'guessCount': 0};
        }
    }
    return guessMap
}

function generateGuessesSort(word) {
    var guessesSort = {}
    const uniqueChars = [...new Set(word.toUpperCase().split(''))].sort()
    for ( var i in uniqueChars) {
        guessesSort[uniqueChars[i]] = {}
    }
    return guessesSort
}

export const started = writable(false);
export const date = getTodaysDateISO();
export const dateLocale = getTodaysDateLocale();
export const elapsedTime = writable(0);
export const timerDuration = writable(100000000000);
export const guess = writable([])
export const guesses = writable({});
export const progress = writable(0);
export const points = writable(0);
export const timedProgress = writable(0);
export const timedPoints = writable(0);
export const gameOverShown = writable(false);

export let game;
export let isGuessed;
export let guessesSort;

const yesterdaysDate = getYesterdaysDateISO();
export let yesterdaysGame;
console.log(date);
console.log(yesterdaysDate);
(async () => {
    yesterdaysGame = await getGame(yesterdaysDate).catch(err => {return err})
    game = await getGame(date).catch(err => {return err})
    isGuessed = writable(generateIsGuessed(game.word));
    guessesSort = writable(generateGuessesSort(game.word));    
})();