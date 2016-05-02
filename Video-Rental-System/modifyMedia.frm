VERSION 5.00
Begin VB.Form modifyMedia 
   Caption         =   "Modify Media"
   ClientHeight    =   5655
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   8805
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   5655
   ScaleWidth      =   8805
   Begin VB.Frame Frame1 
      Caption         =   "Modify Media"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   4215
      Left            =   720
      TabIndex        =   0
      Top             =   600
      Width           =   7335
      Begin VB.CommandButton Command1 
         Caption         =   "Update"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   615
         Left            =   4920
         TabIndex        =   4
         Top             =   3120
         Width           =   1575
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Index           =   1
         Left            =   3240
         TabIndex        =   3
         Top             =   2280
         Width           =   3255
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Index           =   0
         Left            =   3240
         TabIndex        =   2
         Top             =   1560
         Width           =   3255
      End
      Begin VB.ComboBox Combo1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   420
         ItemData        =   "modifyMedia.frx":0000
         Left            =   3240
         List            =   "modifyMedia.frx":000D
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   840
         Width           =   3255
      End
      Begin VB.Label Label2 
         Caption         =   "Rent"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   360
         TabIndex        =   7
         Top             =   2400
         Width           =   2775
      End
      Begin VB.Label Label1 
         Caption         =   "Type"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   615
         Left            =   360
         TabIndex        =   6
         Top             =   1680
         Width           =   2175
      End
      Begin VB.Label Label4 
         Caption         =   "Select Media"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   360
         TabIndex        =   5
         Top             =   840
         Width           =   2175
      End
   End
End
Attribute VB_Name = "modifyMedia"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim rs As New ADODB.Recordset
Dim i As Integer

Private Sub Combo1_Click()
    Dim x As String
    x = "mid=" & Combo1.List(Combo1.ListIndex)
    
    rs.MoveFirst
    rs.Find x
    
    For i = Text1.LBound To Text1.UBound
        Text1(i).Text = rs.Fields(i + 1)
   
    Next
End Sub

Private Sub Command1_Click()
    
    For i = Text1.LBound To Text1.UBound
        rs.Fields(i + 1) = Text1(i).Text
    Next
    rs.Update
    MsgBox "Media Modified"
    
    
End Sub

Private Sub Form_Load()
    rs.Open "select * from Media", conn, adOpenDynamic, adLockOptimistic
    populateCombo
End Sub

Private Sub Form_Unload(Cancel As Integer)
    rs.Close
    
End Sub

Private Sub populateCombo()
    Combo1.Clear
    
    rs.MoveFirst
    Do While Not rs.EOF
        Combo1.AddItem rs.Fields(0)
        rs.MoveNext
    Loop
    
    Combo1.ListIndex = 0
End Sub

