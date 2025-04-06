package com.example.model

import jakarta.persistence.*
import java.time.LocalDate
import java.time.Period

@Entity
@Table(name = "users")
data class User(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,

    @Column(nullable = false)
    val name: String,

    @Column(nullable = false)
    val dateOfBirth: LocalDate
) {
    fun calculateAge(): String {
        val now = LocalDate.now()
        val age = Period.between(dateOfBirth, now)
        return "${age.years} years, ${age.months} months, and ${age.days} days"
    }
}
