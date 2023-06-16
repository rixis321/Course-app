<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Stripe\Webhook;
use Stripe\Customer;
use Stripe\Price;
use Stripe\Stripe;
use Stripe\Checkout\Session;
use Stripe\Exception\UnexpectedValueException;
use Stripe\Exception\SignatureVerificationException;
use App\Models\Course;
use App\Models\Order;
use Illuminate\Support\Carbon;

class PayController extends Controller
{
    //
    public function checkout(Request $request)
    {
        try {
            $user = $request->user();
            $token = $user->token;
            $courseId = $request->id;

            //Stripe key
            Stripe::setApiKey('sk_test_51NJQ3kFCdQOCeuE3JWG5dgiRkLiuij0GjJLQ0EBm8Nl8ACTv0drXcWoSYXlKDmrOXdu4zGwRxvs1vQlxapbCXtU100buJegFas');


            $courseResult = Course::where('id', '=', $courseId)->first();

            //invalid request
            if (empty($courseResult)) {
                return response()->json([
                    'code' => 400,
                    'msg' => "Course does not exist",
                    'data' => ''
                ], 400);
            }

            $orderMap = [];

            $orderMap['course_id'] = $courseId;
            $orderMap['user_token'] = $token;
            $orderMap['status'] = 1;

            //essa

            // check if the order has been placed before or not

            $orderRes = Order::where($orderMap)->first();

            if (!empty($orderRes)) {
                return response()->json([
                    'code' => 400,
                    'msg' => "You already bought this course",
                    'data' => $orderRes
                ], 400);
            }

            // new order for the user
            $YOUR_DOMAIN = env('APP_URL');
            $map = [];
            $map['user_token'] = $token;
            $map['course_id'] = $courseId;
            $map['total_amount'] = $courseResult->price;
            $map['status'] = 0;
            $map['created_at'] = Carbon::now();
            $orderNum = Order::insertGetId($map);

            //creating payment session
            $checkOutSession = Session::create(
                [
                    'line_items'=>[[
                        'price_data'=>[
                            'currency'=>'USD',
                            'product_data'=>[
                                'name'=>$courseResult->name,
                                'description'=>$courseResult->description,

                            ],
                            'unit_amount'=>intval(($courseResult->price)*100),

                        ],
                        'quantity'=>1,

                    ]],
                    'payment_intent_data'=>[
                        'metadata'=>[
                            'order_num'=>$orderNum,
                            'user_token'=>$token
                        ],
                    ],
                    'metadata'=>[
                        'order_num'=>$orderNum,
                        'user_token'=>$token
                    ],
                    'mode'=>'payment',
                    'success_url'=> $YOUR_DOMAIN . 'success',
                    'cancel_url'=> $YOUR_DOMAIN . 'cancel'
                ]
                        );

            // returning stripe payments url
            return response()->json([
                'code' => 200,
                'msg' => "Success",
                'data' => $checkOutSession->url
            ], 200);
        } catch (\Throwable $th) {
            return response()->json([
                'error' => $th->getMessage(),
            ], 500);
        }
    }
}
