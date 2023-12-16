<script>
    import { game, guess, guesses, isGuessed, guessesSort, progress, points, timedPoints, timedProgress, elapsedTime, timerDuration, statWordsFound } from '../../store';

    import Key from '$lib/components/Key.svelte';

	import { toastStore } from '@skeletonlabs/skeleton';

    // Define toast objects to alert on invalid user inputs
    const guessTooShortToast = {
		message: 'Guess must be 4+ letters.',
		timeout: 2000,
		background: 'variant-filled-warning',
	};

	const guessWordOfDayToast = {
		message: 'How clever... find a different word!',
		timeout: 2000,
		background: 'variant-filled-warning',
	};

	const guessDuplicateToast = {
		message: "You've already guessed that.",
		timeout: 2000,
		background: 'variant-filled-warning',
	};

    const guessIncorrectToast = {
        message: "Not an answer today.",
        timeout: 2000,
        background: 'variant-filled-warning'
    };

    // Define the keyboard's keys row by row
    const row1 = game.word.toUpperCase().split('');
    const row2 = ['DEL', 'ENTER'];
    const keyMap = {
        'Backspace': 'DEL',
        'Delete': 'DEL',
        ' ': 'Enter'
    };

    const handleDel = () => {
        var lastChar = $guess[$guess.length - 1];
        
        guess.update((prevGuess) => {
            const newGuess = prevGuess;
            newGuess.pop();
            return newGuess;
        })
        
        if (!(lastChar === undefined)) {
            isGuessed.update((prevIsGuessed) => {
                const newIsGuessed = prevIsGuessed;
                newIsGuessed[lastChar]['guessCount'] -= 1;
                return newIsGuessed;
            });
        }
    };

    const handleEnter = () => {
        if ($guess.length === 0) return;

        const thisGuess = $guess.join('').toLowerCase().replace(/[^a-z0-9]/g, '');

        if (thisGuess == game.word) {
            toastStore.trigger(guessWordOfDayToast);
        } 
        else if (thisGuess.length < 4) {
            toastStore.trigger(guessTooShortToast);
        } 
        else if (thisGuess in $guesses) {
			toastStore.trigger(guessDuplicateToast);
        } 
        else if (!(thisGuess in game.answers)) {
            toastStore.trigger(guessIncorrectToast);
        }
        else {
            guesses.update((prevGuesses) => {
                const newGuesses = prevGuesses;
                newGuesses[thisGuess] = (thisGuess in game.answers);
                return newGuesses;
            });

            guessesSort.update((prevGuessesSort) => {
                const newGuessesSort = prevGuessesSort;
                newGuessesSort[$guess[0]][thisGuess] = (thisGuess in game.answers);
                return newGuessesSort;
            });

            statWordsFound.set($statWordsFound * 1 + 1)

            points.update((prevPoints) => {
                return prevPoints + game.answers[thisGuess]['points']*10;
            });

            progress.set((Object.keys($guesses).length / Object.keys(game.answers).length * 100).toFixed(1));

            if ($elapsedTime < $timerDuration) {
                timedPoints.update((prevPoints) => {
                    return prevPoints + game.answers[thisGuess]['points']*10;
                });

                timedProgress.set((Object.keys($guesses).length / Object.keys(game.answers).length * 100).toFixed(1));
            }
        }

        isGuessed.update((prevIsGuessed) => {
            const newIsGuessed = prevIsGuessed;
            for (var key in newIsGuessed) {
                newIsGuessed[key]['guessCount'] = 0;
            }
            return newIsGuessed;
        });
        
        guess.set([]);
    }

    const keyPress = (key  = '') => {
        if (key == 'DEL') {
            return handleDel();
        }
        if (key == 'ENTER'){
            return handleEnter();
        }

        if (!(key in $isGuessed)) {
            return;
        }
        if ($isGuessed[key]['guessCount'] >= $isGuessed[key]['count']){
            return;
        } else {
            isGuessed.update((prevIsGuessed) => {
                const newIsGuessed = prevIsGuessed;
                newIsGuessed[key]['guessCount'] += 1;
                return newIsGuessed;
            });
        }
        guess.update((prevGuess) => {
            const newGuess = prevGuess;
            newGuess.push(key);
            return newGuess;
        });
    };

    function handleKeydown(event) {
        var thisKey = (event.key in keyMap) ?  keyMap[event.key] : event.key;
        keyPress(thisKey.toUpperCase());
    }
</script>

<svelte:window on:keydown={handleKeydown}/>

<div class='keyboard'>
    <div class='row'>
        {#each row1 as char}
            <Key char={char} isSelected={!(($isGuessed[char]['count'] - $isGuessed[char]['guessCount']))} {keyPress}/>
        {/each}
    </div>

    <div class='row'>
        {#each row2 as char}
            <Key char={char} isSelected={false} keyPress={keyPress}/>
        {/each}
    </div>
</div>

<style>
    .keyboard {
        position: relative;
        left: 50%;
        transform: translate(-50%, 0%);
        width: 180%;
        max-width: 60rem;
    }

    .row {
        display: flex;
        align-items: center;
        justify-content: center;
    }
</style>