from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import NoteSerializer
from .models import Note

@api_view(['GET'])
def getRoutes(request):
    routes = [
        {
            'Endpoint': '/notes/create/'
        }
    ]

    return Response(routes)

@api_view(['GET'])
def getNotes(request):
    notes = Note.objects.all()

    serializer = NoteSerializer(notes, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getNote(request, pk):
    notes = Note.objects.get(id=pk)

    serializer = NoteSerializer(notes, many=False)
    return Response(serializer.data)

@api_view(['POST'])
def createNote(request):
    data = request.data
    note = Note.objects.create(
        id=data['id'],
        theBorrower=data['theBorrower'],
        borrowerType=data['borrowerType'],
        nominal=data['nominal'],
        description=data['description'],
        date_borrowed=data['date_borrowed'],
        time_borrowed=data['time_borrowed'],
    )
    serializer = NoteSerializer(note, many=False)
    return Response(serializer.data)

@api_view(['PUT'])
def updateNote(request, pk):
    data = request.data
    note = Note.objects.get(id=pk)
    serializer = NoteSerializer(note, data=data, partial=True)
    print(data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)

@api_view(['DELETE'])
def deleteNote(request,pk):
    note = Note.objects.get(id=pk)
    note.delete()
    return Response('Note was deleted')