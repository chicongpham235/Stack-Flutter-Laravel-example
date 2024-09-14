<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Country;

class CountryController extends Controller
{
    public function index()
    {
        $query = Country::query();
        return response()->json(($query->get()), 200, []);
    }
}
