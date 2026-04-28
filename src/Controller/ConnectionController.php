<?php

namespace App\Controller;



class ConnectionController extends Controller
{
    public function signUp():void
    {
        $this->render("connection/signUp");
    }

    public function signIn(): void
    {
        $this->render("connection/signIn");
    }


}   

