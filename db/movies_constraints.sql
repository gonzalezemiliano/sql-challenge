--
-- Name: casts casts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY casts
    ADD CONSTRAINT casts_pkey PRIMARY KEY (movie_id, person_id, job_id, role);


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: movie_genres movie_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movie_genres
    ADD CONSTRAINT movie_genres_pkey PRIMARY KEY (movie_id, genre_id);


--
-- Name: movie_in_saga movie_in_saga_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movie_in_saga
    ADD CONSTRAINT movie_in_saga_pkey PRIMARY KEY (movie_id);


--
-- Name: movie_languages movie_languages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movie_languages
    ADD CONSTRAINT movie_languages_pkey PRIMARY KEY (movie_id, language);


--
-- Name: movie_references movie_references_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movie_references
    ADD CONSTRAINT movie_references_pkey PRIMARY KEY (reference_to, referenced_by);


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- Name: sagas sagas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sagas
    ADD CONSTRAINT sagas_pkey PRIMARY KEY (id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: casts casts_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY casts
    ADD CONSTRAINT casts_job_id_fkey FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE;


--
-- Name: casts casts_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY casts
    ADD CONSTRAINT casts_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE;


--
-- Name: casts casts_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY casts
    ADD CONSTRAINT casts_person_id_fkey FOREIGN KEY (person_id) REFERENCES people(id) ON DELETE CASCADE;


--
-- Name: movie_genres movie_genres_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movie_genres
    ADD CONSTRAINT movie_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE;


--
-- Name: movie_genres movie_genres_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movie_genres
    ADD CONSTRAINT movie_genres_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE;


--
-- Name: movie_in_saga movie_in_saga_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movie_in_saga
    ADD CONSTRAINT movie_in_saga_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES movies(id) NOT VALID;


--
-- Name: movie_in_saga movie_in_saga_saga_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movie_in_saga
    ADD CONSTRAINT movie_in_saga_saga_id_fkey FOREIGN KEY (saga_id) REFERENCES sagas(id) NOT VALID;


--
-- Name: movie_languages movie_languages_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movie_languages
    ADD CONSTRAINT movie_languages_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE;


--
-- Name: movie_references movie_references_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movie_references
    ADD CONSTRAINT movie_references_reference_to_fkey FOREIGN KEY (reference_to) REFERENCES movies(id) ON DELETE CASCADE;


--
-- Name: movie_references movie_references_referenced_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movie_references
    ADD CONSTRAINT movie_references_referenced_by_fkey FOREIGN KEY (referenced_by) REFERENCES movies(id) ON DELETE CASCADE;



