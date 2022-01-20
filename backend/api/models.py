from statistics import mode
from time import time
from django.db import models
import datetime
borrower_choices = (('Karyawan','Karyawan'),('Non-Karyawan','Non-Karyawan'))

class Note(models.Model):
    id = models.CharField(max_length=128,primary_key=True)
    theBorrower = models.TextField()
    borrowerType = models.TextField(choices=borrower_choices)
    nominal = models.IntegerField()
    description = models.CharField(max_length=200, blank=True)
    date_borrowed = models.DateField(blank=True, null=True)
    time_borrowed = models.TimeField(blank=True, null=True)
    updated = models.DateTimeField(auto_now=True)
    created=  models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.theBorrower[0:50]
    
    class Meta:
        ordering = ['updated']