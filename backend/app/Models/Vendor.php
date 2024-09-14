<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class Vendor extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;
    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */

    protected $table = "vendor";
    protected $primaryKey = 'vendor_id';
    protected $fillable = [
        "vendor_id",
        "name",
        "username",
        "email",
        "password",
        "company",
        "display_name",
        "address1",
        "address2",
        "status",
        "membership",
        "create_timestamp",
        "approve_timestamp",
        "member_timestamp",
        "member_expire_timestamp",
        "details",
        "last_login",
        "facebook",
        "skype",
        "google_plus",
        "twitter",
        "youtube",
        "pinterest",
        "stripe_details",
        "paypal_email",
        "preferred_payment",
        "cash_set",
        "stripe_set",
        "paypal_set",
        "phone",
        "keywords",
        "description",
        "lat_lang",
        "custom_lat",
        "custom_long",
        "shoptype",
        "banner",
        "bank_name",
        "swift_code",
        "iban",
        "bank_acc_num",
        "plusgiro",
        "countries_id",
        "organisationnumber",
        "registration_document",
        "partnername",
        "timezone",
    ];
    protected $hidden = [
        'password',
    ];

    public function isActive()
    {
        if ($this->status == "approved") {
            return true;
        } else {
            return false;
        }
    }

    public function country()
    {
        return $this->belongsTo(Country::class, "countries_id");
    }
}
