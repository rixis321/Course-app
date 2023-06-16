<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Course;

class CourseController extends Controller
{

    public function courseList(){


        try{
            $result = Course::select('name', 'thumbnail', 'lesson_num', 'price', 'id')
            ->get();

                return response()->json([
                               'code' => 200,
                               'msg' => 'My course list is here',
                               'data' => $result
                            ], 200);
        }catch(\Throwable $throw){
            return response()->json([
                'code'=>500,
                'msd'=> 'The field does not exist or there is syntax error',
                'data'=>$throw->getMessage()
            ], 500);
        }
    }

    public function courseDetail(Request $request){
            //course id
            $id = $request->id;


            try{
                $result = Course::where('id','=',$id)->select(
                   'id',
                   'name',
                   'thumbnail',
                   'user_token',
                   'description',
                   'lesson_num',
                   'video_length',
                   'lesson_num',
                   'price'
                    )
                ->get();

                    return response()->json([
                                   'code' => 200,
                                   'msg' => 'My course detail is here',
                                   'data' => $result
                                ], 200);
            }catch(\Throwable $throw){
                return response()->json([
                    'code'=>500,
                    'msd'=> 'The field does not exist or there is syntax error',
                    'data'=>$throw->getMessage()
                ], 500);
            }
        }
}
