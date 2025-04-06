package com.example.controller

import com.example.model.User
import com.example.service.UserService
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/users")
class UserController(private val userService: UserService) {

    @PostMapping
    fun addUser(@RequestBody user: User): Map<String, String> {
        val savedUser = userService.saveUser(user)
        return mapOf("age" to savedUser.calculateAge())
    }

    @GetMapping
    fun getUsers(): List<Map<String, Any>> {
        return userService.getAllUsersWithAge()
    }
}
