unit uNiveau;

interface

uses System.Math.Vectors, System.Generics.Collections, FMX.Objects3D, FMX.Viewport3D, System.SysUtils, FMX.MaterialSources,
FMX.Ani;

type
  TNiveau = class
    fPositionDepart, fPositionArrivee, fPositionPlateau : TPoint3D;
    fLargeurPlateau, fProfondeurPlateau : single;
    fListObstacle :  TObjectList<TRectangle3D>;
    fTitre : string;
    fOwner : TViewport3D;
    fDummy : TDummy;
    fObstacleMaterial : TLightMaterialSource;
    private
      function getNbObstacle: integer;
    public
      constructor Create(AOwner : TViewport3D; dummy : TDummy; obstacleMaterial : TLightMaterialSource);
      destructor Destroy; override;

      procedure chargerNiveau1;
      procedure chargerNiveau2;
      procedure chargerNiveau3;

      property PositionDepart : TPoint3D read fPositionDepart write fPositionDepart;
      property PositionArrivee : TPoint3D read fPositionArrivee write fPositionArrivee;
      property PositionPlateau : TPoint3D read fPositionPlateau write fPositionPlateau;
      property LargeurPlateau : single read fLargeurPlateau write fLargeurPlateau;
      property ProfondeurPlateau : single read fProfondeurPlateau write fProfondeurPlateau;
      property Titre : String read fTitre write fTitre;
      property NbObstacle : integer read getNbObstacle;

  end;

implementation

{ TNiveau }

constructor TNiveau.Create(AOwner: TViewport3D; dummy : TDummy; obstacleMaterial : TLightMaterialSource);
begin
  // liste contenant les obstacles du niveau autres que la bordure du plateau
   fListObstacle := TObjectList<TRectangle3D>.Create;
   fOwner := AOwner;
   fDummy := dummy;
   fObstacleMaterial := obstacleMaterial;
end;

// Niveau 1 simple sans obstacle
procedure TNiveau.chargerNiveau1;
begin
  Titre := 'Level 1';

  fPositionDepart.X := 0;
  fPositionDepart.Y := -0.56;
  fPositionDepart.Z := -7;

  fPositionArrivee.X := 1.8;
  fPositionArrivee.Y := -0.15;
  fPositionArrivee.Z := 7.8;

  fPositionPlateau.X := 0;
  fPositionPlateau.Y := 0;
  fPositionPlateau.Z := 0;

  fLargeurPlateau := 5.8;
  fProfondeurPlateau := 19.8;
end;

// Niveau 2 avec 3 obstacles
procedure TNiveau.chargerNiveau2;
var
  obstacle, obstacle2, obstacle3 : TRectangle3D;
begin
  Titre := 'Level 2';

  fPositionDepart.X := 0;
  fPositionDepart.Y := -0.56;
  fPositionDepart.Z := -7;

  fPositionArrivee.X := 0;
  fPositionArrivee.Y := -0.15;
  fPositionArrivee.Z := 2;

  fPositionPlateau.X := 0;
  fPositionPlateau.Y := 0;
  fPositionPlateau.Z := 0;

  fLargeurPlateau := 5.8;
  fProfondeurPlateau := 19.8;

  // Création des obstacles
  obstacle := TRectangle3D.Create(fOwner);
  obstacle.Position.Z := -1;
  obstacle.Position.Y := -0.53;
  obstacle.Position.X := -0.75;
  obstacle.Width := 4;
  obstacle.height := 0.6;
  obstacle.Depth := 0.25;
  obstacle.Parent := fdummy;
  obstacle.MaterialSource := fObstacleMaterial;
  obstacle.MaterialBackSource := fObstacleMaterial;
  obstacle.MaterialShaftSource := fObstacleMaterial;

  fListObstacle.Add(obstacle);

  obstacle2 := TRectangle3D.Create(fOwner);
  obstacle2.Position.Z := 1.63;
  obstacle2.Position.Y := -0.53;
  obstacle2.Position.X := 1.12;
  obstacle2.Width := 0.25;
  obstacle2.height := 0.6;
  obstacle2.Depth := 5;
  obstacle2.Parent := fdummy;
  obstacle2.MaterialSource := fObstacleMaterial;
  obstacle2.MaterialBackSource := fObstacleMaterial;
  obstacle2.MaterialShaftSource := fObstacleMaterial;

  fListObstacle.Add(obstacle2);

  obstacle3 := TRectangle3D.Create(fOwner);
  obstacle3.Position.Z := 4;
  obstacle3.Position.Y := -0.53;
  obstacle3.Position.X := -0.25;
  obstacle3.Width := 2.5;
  obstacle3.height := 0.6;
  obstacle3.Depth := 0.25;
  obstacle3.Parent := fdummy;
  obstacle3.MaterialSource := fObstacleMaterial;
  obstacle3.MaterialBackSource := fObstacleMaterial;
  obstacle3.MaterialShaftSource := fObstacleMaterial;

  fListObstacle.Add(obstacle3);
end;

// Niveau 3 avec obstacles en mouvement
procedure TNiveau.chargerNiveau3;
var
  obstacle, obstacle2, obstacle3, obstacle4, obstacle5, obstacle6 : TRectangle3D;
begin
  Titre := 'Level 3';

  fPositionDepart.X := -1.5;
  fPositionDepart.Y := -0.56;
  fPositionDepart.Z := -6;

  fPositionArrivee.X := -1.5;
  fPositionArrivee.Y := -0.15;
  fPositionArrivee.Z := 8;

  fPositionPlateau.X := 0;
  fPositionPlateau.Y := 0;
  fPositionPlateau.Z := 0;

  fLargeurPlateau := 5.8;
  fProfondeurPlateau := 19.8;

  // Création des obstacles
  obstacle := TRectangle3D.Create(fOwner);
  obstacle.Position.Z := 4;
  obstacle.Position.Y := -0.53;
  obstacle.Position.X := -0.94;
  obstacle.Width := 3.63;
  obstacle.height := 0.6;
  obstacle.Depth := 0.25;
  obstacle.Parent := fdummy;
  obstacle.MaterialSource := fObstacleMaterial;
  obstacle.MaterialBackSource := fObstacleMaterial;
  obstacle.MaterialShaftSource := fObstacleMaterial;

  fListObstacle.Add(obstacle);

  obstacle2 := TRectangle3D.Create(fOwner);
  obstacle2.Position.Z := 4;
  obstacle2.Position.Y := -0.53;
  obstacle2.Position.X := 1;
  obstacle2.Width := 0.25;
  obstacle2.height := 0.6;
  obstacle2.Depth := 4;
  obstacle2.Parent := fdummy;
  obstacle2.MaterialSource := fObstacleMaterial;
  obstacle2.MaterialBackSource := fObstacleMaterial;
  obstacle2.MaterialShaftSource := fObstacleMaterial;

  fListObstacle.Add(obstacle2);

  obstacle3 := TRectangle3D.Create(fOwner);
  obstacle3.Position.Z := 0;
  obstacle3.Position.Y := -0.53;
  obstacle3.Position.X := 0.94;
  obstacle3.Width := 3.63;
  obstacle3.height := 0.6;
  obstacle3.Depth := 0.25;
  obstacle3.Parent := fdummy;
  obstacle3.MaterialSource := fObstacleMaterial;
  obstacle3.MaterialBackSource := fObstacleMaterial;
  obstacle3.MaterialShaftSource := fObstacleMaterial;

  fListObstacle.Add(obstacle3);

  obstacle4 := TRectangle3D.Create(fOwner);
  obstacle4.Position.Z := 0;
  obstacle4.Position.Y := -0.53;
  obstacle4.Position.X := -1;
  obstacle4.Width := 0.25;
  obstacle4.height := 0.6;
  obstacle4.Depth := 4;
  obstacle4.Parent := fdummy;
  obstacle4.MaterialSource := fObstacleMaterial;
  obstacle4.MaterialBackSource := fObstacleMaterial;
  obstacle4.MaterialShaftSource := fObstacleMaterial;

  fListObstacle.Add(obstacle4);

  obstacle5 := TRectangle3D.Create(fOwner);
  obstacle5.Position.Z := -4;
  obstacle5.Position.Y := -0.53;
  obstacle5.Position.X := -0.94;
  obstacle5.Width := 3.63;
  obstacle5.height := 0.6;
  obstacle5.Depth := 0.25;
  obstacle5.Parent := fdummy;
  obstacle5.MaterialSource := fObstacleMaterial;
  obstacle5.MaterialBackSource := fObstacleMaterial;
  obstacle5.MaterialShaftSource := fObstacleMaterial;

  fListObstacle.Add(obstacle5);

  obstacle6 := TRectangle3D.Create(fOwner);
  obstacle6.Position.Z := -4;
  obstacle6.Position.Y := -0.53;
  obstacle6.Position.X := 1;
  obstacle6.Width := 0.25;
  obstacle6.height := 0.6;
  obstacle6.Depth := 4;
  obstacle6.Parent := fdummy;
  obstacle6.MaterialSource := fObstacleMaterial;
  obstacle6.MaterialBackSource := fObstacleMaterial;
  obstacle6.MaterialShaftSource := fObstacleMaterial;

  fListObstacle.Add(obstacle6);
end;

destructor TNiveau.Destroy;
begin
  FreeAndNil(fListObstacle);
  inherited;
end;

function TNiveau.getNbObstacle: integer;
begin
  result := fListObstacle.Count;
end;

end.
