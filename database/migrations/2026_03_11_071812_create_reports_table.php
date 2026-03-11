<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('reports', function (Blueprint $table) {
            $table->id();
            $table->dateTime('incident_date'); // Date and Time of the issue
            $table->string('address');
            $table->string('type_of_problem'); // e.g., Line Utility Pole, Transformer, etc.
            $table->text('description');
            $table->enum('status', ['pending', 'in-progress', 'resolved'])->default('pending');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('reports');
    }
};
