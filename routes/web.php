<?php

use Illuminate\Support\Facades\Route;
use Laravel\Fortify\Features;

Route::inertia('/', 'welcome', [
    'canRegister' => Features::enabled(Features::registration()),
])->name('home');

Route::middleware(['auth', 'verified'])->group(function () {
    Route::inertia('dashboard', 'dashboard')->name('dashboard');
});



Route::get('/hello', function () {
    return view('greeting', [
        'name' => 'Alexandr'
    ]);
});

Route::get('/user/{id}', function (string $id) {
    return 'User '.$id;
});


require __DIR__.'/settings.php';