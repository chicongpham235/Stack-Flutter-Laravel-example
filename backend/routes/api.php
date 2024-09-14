<?php

use App\Http\Controllers\Api\Auth\AuthenticateController;
use App\Http\Controllers\Api\CountryController;
use App\Http\Controllers\Api\SaleController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
 */

Route::group([], function () {
    Route::post('authenticate', [AuthenticateController::class, 'authenticate']);
    Route::group(['middleware' => 'auth:sanctum'], function () {
        Route::post('logout', [AuthenticateController::class, 'logout']);
        Route::get('me', [AuthenticateController::class, 'me']);

        Route::get('countries', [CountryController::class, 'index']);
        Route::get('sales', [SaleController::class, 'index']);
    });
});
