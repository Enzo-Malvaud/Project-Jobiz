<?php

namespace App\Entity;



class User extends Entity
{

    protected ?int $id = null;
    protected ?string $first_name = null;
    protected ?string $last_name = null;
    protected ?int $salary = null;
    protected ?int $email = null;
    protected ?int $password = null;

    /**
     * Get the value of id
     */
    public function getId(): ?int
    {
        return $this->id;
    }

    /**
     * Set the value of id
     */
    public function setId(?int $id): self
    {
        $this->id = $id;

        return $this;
    }

    /**
     * Get the value of first_name
     */
    public function getFirstName(): ?string
    {
        return $this->first_name;
    }

    /**
     * Set the value of first_name
     */
    public function setFirstName(?string $first_name): self
    {
        $this->first_name = $first_name;

        return $this;
    }

    /**
     * Get the value of last_name
     */
    public function getLastName(): ?string
    {
        return $this->last_name;
    }

    /**
     * Set the value of last_name
     */
    public function setLastName(?string $last_name): self
    {
        $this->last_name = $last_name;

        return $this;
    }

    /**
     * Get the value of salary
     */
    public function getSalary(): ?int
    {
        return $this->salary;
    }

    /**
     * Set the value of salary
     */
    public function setSalary(?int $salary): self
    {
        $this->salary = $salary;

        return $this;
    }

    /**
     * Get the value of email
     */
    public function getEmail(): ?int
    {
        return $this->email;
    }

    /**
     * Set the value of email
     */
    public function setEmail(?int $email): self
    {
        $this->email = $email;

        return $this;
    }

    /**
     * Get the value of password
     */
    public function getPassword(): ?int
    {
        return $this->password;
    }

    /**
     * Set the value of password
     */
    public function setPassword(?int $password): self
    {
        $this->password = $password;

        return $this;
    }


}
