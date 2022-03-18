package com.ray.ecommerce.controller;

import com.ray.ecommerce.dao.BookRepository;
import com.ray.ecommerce.entity.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/book")
public class BooksController {

    private BookRepository bookRepository;

    @Autowired
    public BooksController(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    @PostMapping()
    public Book postProduct(@RequestBody Book book) {
        return this.bookRepository.save(book);
    }

//    @DeleteMapping("/{id}")
//    public void deleteUser(@PathVariable("id") Long id)  {
//        bookRepository.deleteById(id);
//        return ;
//    }

//    private ResponseEntity<HttpResponse> response(HttpStatus httpStatus, String message) {
//        return new ResponseEntity<>(new HttpResponse(httpStatus.value(),
//                httpStatus, httpStatus.getReasonPhrase(), message), httpStatus);
//    }
}
