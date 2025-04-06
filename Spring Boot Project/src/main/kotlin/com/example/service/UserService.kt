package com.example.service

import com.example.model.User
import com.example.repository.UserRepository
import org.springframework.stereotype.Service

@Service
class UserService(private val userRepository: UserRepository) {
    fun saveUser(user: User): User = userRepository.save(user)

    fun getAllUsersWithAge(): List<Map<String, Any>> {
        return userRepository.findAll().map { user ->
            mapOf<String, Any>(
                "id" to user.id as Any, // Explicitly cast to Any
                "name" to user.name as Any,
                "dateOfBirth" to user.dateOfBirth as Any,
                "age" to user.calculateAge() as Any
            )
        }
    }
}
