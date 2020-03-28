from django.shortcuts import render
from django.http import Http404,HttpResponse
import json
import MySQLdb


def index(request):    
    return render(request, 'personal/header.html')

