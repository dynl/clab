<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Report;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    // READ: Get all reports
    public function index()
    {
        return response()->json(Report::latest()->get(), 200);
    }

    // CREATE: Save a new report
    public function store(Request $request)
    {
        $validated = $request->validate([
            'incident_date' => 'required|date',
            'address' => 'required|string',
            'type_of_problem' => 'required|string',
            'description' => 'required|string',
        ]);

        $report = Report::create($validated);
        return response()->json($report, 201);
    }

    // READ: Get one specific report
    public function show(Report $report)
    {
        return response()->json($report, 200);
    }

    // UPDATE: Edit a report (e.g., changing status)
    public function update(Request $request, Report $report)
    {
        $report->update($request->all());
        return response()->json($report, 200);
    }

    // DELETE: Remove a report
    public function destroy(Report $report)
    {
        $report->delete();
        return response()->json(['message' => 'Report deleted'], 200);
    }
}