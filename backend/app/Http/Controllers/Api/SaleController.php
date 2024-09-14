<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Library\QueryBuilder\QueryBuilder;
use App\Models\Sale;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class SaleController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $vendor_id = Auth::id();
        $query = Sale::query();
        $query = $query->where('vendor_id', $vendor_id);
        $query = QueryBuilder::for($query, $request)
            ->allowedIncludes(['vendor', 'country'])
            ->defaultSort('sale_id');
        return response()->json(($query->get()), 200, []);
    }
}
