<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Report extends Model
{
    protected $fillable = [
        'incident_date',
        'address',
        'type_of_problem',
        'description',
        'status'
    ];
}
