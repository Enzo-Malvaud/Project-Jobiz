<?php

namespace App\Controller;


use App\Repository\CategoryRepository;

class PageController extends Controller
{
    public function home(): void
    {

        $categoryRepository = new CategoryRepository();

        $categories = $categoryRepository->findAll();

        // Exemple de création de catégorie
        /*$category = new Category();
        $category->setName("Test Abc");
        $res = $categoryRepository->persist($category);
        var_dump($res);
        */
        
        $this->render("page/home", [
            "categories" => $categories,
        ]);
    }

    public function about(): void
    {
        $this->render("page/about");
    }


}