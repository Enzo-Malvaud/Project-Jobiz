<?php
return [
    
    "/jobs/" => ["controller" => "App\Controller\JobController", "action"  => "list"],
    "/job/" => ["controller" => "App\Controller\JobController", "action" => "show"],
    "/about/" => ["controller" => "App\Controller\PageController", "action" => "about"],
    "/signIn/" =>["controller" => "App\Controller\ConnectionController", "action" => "signIn"],
    "/signUp/" =>["controller" => "App\Controller\ConnectionController", "action" => "signUp"],
    "/" => ["controller" => "App\Controller\PageController", "action" => "home"],
];