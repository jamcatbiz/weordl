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
    return thisDate.toLocaleString('en-US', options);
}

async function getGame(date) {
    const res = await fetch(`https://s3.amazonaws.com/weordl.com.games/days/${date}.json`);
    const data = await res.json();
    return data;
}

function generateIsGuessed(word) {
    var guessMap = {}
    for (var char of word.toUpperCase()) {
        if ( char in guessMap ) {
            guessMap[char]['count'] += 1;
        } else {
            guessMap[char] = {'count': 1, 'guessCount': 0};
        }
    }
    return guessMap;
}

function generateGuessesSort(word) {
    var guessesSort = {}
    const uniqueChars = [...new Set(word.toUpperCase().split(''))].sort()
    for ( var i in uniqueChars) {
        guessesSort[uniqueChars[i]] = {}
    }
    return guessesSort;
}

// Simple stores with no browser storage
export const date = getTodaysDateISO();
export const dateLocale = getTodaysDateLocale();
export const timerDuration = writable(1000 * 60 * 5);
export const guess = writable([]);
export const resumed = writable(false);


// Game related stores with browser storage
const storedElapsedTime = localStorage.getItem('weordl_elapsedTime');
export const elapsedTime = writable(storedElapsedTime ? Number(storedElapsedTime) : 0);
elapsedTime.subscribe(val => {
    localStorage.setItem('weordl_elapsedTime', val ? val : 0)
});

const storedProgress = localStorage.getItem('weordl_progress');
export const progress = writable(storedProgress ? Number(storedProgress) : 0);
progress.subscribe(val => {
    localStorage.setItem('weordl_progress', val ? val : 0)
});

const storedTimedProgress = localStorage.getItem('weordl_timedProgress');
export const timedProgress = writable(storedTimedProgress ? Number(storedTimedProgress) : 0);
timedProgress.subscribe(val => {
    localStorage.setItem('weordl_timedProgress', val ? val : 0)
});

const storedPoints = localStorage.getItem('weordl_points');
export const points = writable(storedPoints ? Number(storedPoints) : 0);
points.subscribe(val => {
    localStorage.setItem('weordl_points', val ? val : 0)
});

const storedTimedPoints = localStorage.getItem('weordl_timedPoints');
export const timedPoints = writable(storedTimedPoints ? Number(storedTimedPoints) : 0);
timedPoints.subscribe(val => {
    localStorage.setItem('weordl_timedPoints', val ? val : 0)
});

const storedGuesses = localStorage.getItem('weordl_guesses');
export const guesses = writable(storedGuesses ? JSON.parse(storedGuesses): {});
guesses.subscribe(val => {
    localStorage.setItem('weordl_guesses', val ? JSON.stringify(val) : '{}')
});

// Control flow related stores with browser storage
const storedLastPlayedDate = localStorage.getItem('weordl_lastPlayedDate');
export const lastPlayedDate = writable(storedLastPlayedDate ? storedLastPlayedDate : 'YYYY-MM-DD');
export const isFirstVisit = writable(storedLastPlayedDate ? false : true);
export const hasPlayedToday = writable(storedLastPlayedDate == date ? true : false);
lastPlayedDate.subscribe(val => {
    localStorage.setItem('weordl_lastPlayedDate', val ? val : 'YYYY-MM-DD')
});

const storedGameOverShown = localStorage.getItem('weordl_gameOverShown');
export const gameOverShown = writable(storedGameOverShown ? (storedGameOverShown === 'true') : false);
gameOverShown.subscribe(val => {
    localStorage.setItem('weordl_gameOverShown', val ? val : false)
});

// User related info
const storedStatGamesPlayed = localStorage.getItem('weordl_statGamesPlayed');
export const statGamesPlayed = writable(Number(storedStatGamesPlayed));
statGamesPlayed.subscribe(val => {
    localStorage.setItem('weordl_statGamesPlayed', val ? val : 0)
});

const storedStatWordsFound = localStorage.getItem('weordl_statWordsFound');
export const statWordsFound = writable(Number(storedStatWordsFound));
statWordsFound.subscribe(val => {
    localStorage.setItem('weordl_statWordsFound', val ? val : 0)
});


// async stores
const yesterdaysDate = getYesterdaysDateISO();
export let yesterdaysGame;
export let game;
export let isGuessed;
export let guessesSort;

(async () => {
    yesterdaysGame = await getGame(yesterdaysDate).catch(err => {return err})
    game = await getGame(date).catch(err => {return err})
    isGuessed = writable(generateIsGuessed(game.word));
    guessesSort = writable(generateGuessesSort(game.word));
})();