from statistics import mode
from time import time
from django.db import models
import datetime

class Note(models.Model):
    id = models.CharField(max_length=128,primary_key=True)
    isImportant = models.BooleanField()
    number = models.IntegerField()
    title = models.CharField(max_length=200, blank=True)
    description = models.CharField(max_length=200, blank=True)
    createdTime=  models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return self.title
    
    class Meta:
        ordering = ['createdTime']