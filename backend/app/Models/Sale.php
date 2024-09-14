<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sale extends Model
{
    use HasFactory;
    protected $table = 'sale';
    protected $fillable = [
        'sale_id',
        'sale_code',
        'buyer',
        'product_details',
        'shipping_address',
        'vat',
        'price_inclu_vat_tax',
        'discount',
        'vat_without',
        'vat_percent',
        'shipping',
        'payment_type',
        'payment_status',
        'payment_details',
        'payment_timestamp',
        'grand_total',
        'sale_datetime',
        'delivary_datetime',
        'delivery_status',
        'viewed',
        'ordertype',
        'table_number',
        'order_status',
        'vendo',
        'add_tips',
        'vendor_id',
        'countries_id',
        'currency',
        'paymentsstatus',
        'deliverysstatus',
    ];

    protected $casts = [
        'product_details' => 'array',
        'shipping_address' => 'array',
        'payment_status' => 'array',
        'delivery_status' => 'array',

    ];

    public function vendor()
    {
        return $this->belongsTo(Vendor::class, 'vendor_id');
    }

    public function country()
    {
        return $this->belongsTo(Country::class, 'countries_id');
    }
}
