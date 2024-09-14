<?php

namespace App\Http\Controllers\Api\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\AuthRequest;
use App\Models\Vendor;
use App\Traits\ResponseType;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cookie;

class AuthenticateController extends Controller
{
    /**
     * Get the guard to be used during authentication.
     *
     */
    use ResponseType;
    public function guard()
    {
        return Auth::guard();
    }

    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken($token, $other = [])
    {
        return response()->json(array_merge($other, [
            'access_token' => $token,
            'token_type' => 'Bearer',
            'expires_in' => config('sanctum.expiration'),
        ]));
    }

    public function authenticate(AuthRequest $request)
    {
        $user = $this->checkUser($request);
        if (empty($user)) {
            return response()->json(['message' => 'Username or Password is incorrect'], 422);
        }
        $token = $user->createToken('login_token');
        Cookie::make('token', $token->plainTextToken);

        return $this->respondWithToken($token->plainTextToken);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json(['message' => 'Successfully logged out']);
    }

    private function checkUser(Request $request)
    {
        $credentials = $request->only('username', 'password');
        $user = Vendor::where('username', $credentials['username'])->where('password', sha1($credentials['password']))->first();
        if (empty($user)) {
            abort(400, 'Username or Password is incorrect');
        }
        if (!$user->isActive()) {
            abort(400, 'Vendor is blocked, contact via admin to get more information');
        }
        return $user;
    }

    public function me(Request $request)
    {
        $user = $request->user();
        return response()->json(Vendor::find($user->vendor_id));
    }

}
