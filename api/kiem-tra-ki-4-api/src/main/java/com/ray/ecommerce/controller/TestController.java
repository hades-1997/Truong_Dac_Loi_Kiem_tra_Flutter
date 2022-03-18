package com.ray.ecommerce.controller;

import com.ray.ecommerce.dao.BookRepository;
import com.ray.ecommerce.entity.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/test")
public class TestController {
    private BookRepository booksRepository;

    @Autowired
    public TestController(BookRepository booksRepository) {
        this.booksRepository = booksRepository;
    }

    @PostMapping("/books")
    public Book placeOrder(@RequestBody Book book) {
        Book temp = booksRepository.save(book);
        return temp;
    }
}
