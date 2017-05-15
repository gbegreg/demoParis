{ =======================================================================================================================
  Développé par Grégory Bersegeay (http://www.gbesoft.fr)
  Petit jeu de démonstration réalisé pour le séminaire Delphi Tokyo par les sociétés Barnsten et Embarcadero
  à Paris le 17 mai 2017.

  Ce code n'utilise aucun composant tiers et il est compilable et testé sous Windows, Mac OS et Android. Il doit être
  compilable pour IOS mais je n'ai pas de périphérique pour tester.
  ======================================================================================================================= }
unit principale;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Layouts, FMX.Viewport3D,
  System.Math.Vectors, FMX.Ani, FMX.MaterialSources, FMX.Controls3D, FMX.Objects3D, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Types3D, System.ImageList, System.IniFiles, System.Sensors, System.Sensors.Components,
  System.Generics.Collections,
  FMX.Effects, uNiveau, FMX.Filter.Effects, System.IOUtils, FMX.Layers3D, System.Math;

type
  TfPrincipale = class(TForm)
    Viewport3D: TViewport3D;
    hautPage: TLayout;
    rrPanneau: TRoundRect;
    tmlDelphi: TTextureMaterialSource;
    BasPage: TLayout;
    pnlDirection: TLayout;
    GadgetsCircle: TCircle;
    GadgetsLayout: TLayout;
    sbArrowDown: TSpeedButton;
    ptArrowDown: FMX.Objects.TPath;
    sbArrowUp: TSpeedButton;
    ptArrowUp: FMX.Objects.TPath;
    sbArrowLeft: TSpeedButton;
    ptArrowLeft: FMX.Objects.TPath;
    sbArrowRight: TSpeedButton;
    ptArrowRight: FMX.Objects.TPath;
    dLogoDelphi: TDisk;
    aniBouclePrincipale: TFloatAnimation;
    base: TRectangle3D;
    dmyPrincipal: TDummy;
    lmsBase: TLightMaterialSource;
    lumiere: TLight;
    balle: TSphere;
    lmsBalle: TLightMaterialSource;
    Center: TCircle;
    ombre: TDisk;
    lmsOmbre: TLightMaterialSource;
    bordDroit: TRectangle3D;
    lmsMur: TLightMaterialSource;
    bordGauche: TRectangle3D;
    bordFond: TRectangle3D;
    bordProche: TRectangle3D;
    LogoEmbarcadero: TPlane;
    sbChangeCamera: TSpeedButton;
    CameraTV: TCamera;
    CameraOpposee: TCamera;
    lblCamera: TLabel;
    sbApropos: TSpeedButton;
    tmsEmbarcadero: TTextureMaterialSource;
    layOptions: TLayout;
    Rectangle1: TRectangle;
    btnOk: TImage;
    lOptions: TLabel;
    Layout2: TLayout;
    Layout4: TLayout;
    animOptions: TFloatAnimation;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    tbGyroSensibilite: TTrackBar;
    cbGyroActive: TCheckBox;
    cameraSuiveuse: TCamera;
    MotionSensor: TMotionSensor;
    arrivee: TDisk;
    lmsArrivee: TLightMaterialSource;
    tGagne: TText3D;
    lmsGagne: TLightMaterialSource;
    GagneRotation: TFloatAnimation;
    arriveeCone: TCone;
    arriveeAnimation: TFloatAnimation;
    arriveeCylindre: TCylinder;
    dmyIntro: TDummy;
    textIntro: TText3D;
    lblTitre: TLabel;
    BalleIntro: TSphere;
    animBalleIntro: TFloatAnimation;
    animRotationBalle: TFloatAnimation;
    pnlBoutonStart: TPlane;
    lmsBtnJouer: TLightMaterialSource;
    lmsObstacle: TLightMaterialSource;
    lblParis: TTextLayer3D;
    aniClic: TFloatAnimation;
    CylinderX: TCylinder;
    ConeX: TCone;
    ConeY: TCone;
    CylinderY: TCylinder;
    CMSY: TColorMaterialSource;
    ConeZ: TCone;
    CylinderZ: TCylinder;
    CMSX: TColorMaterialSource;
    CMSZ: TColorMaterialSource;
    cbAfficherAxes: TCheckBox;
    dmyBalle: TDummy;
    anitextIntro: TFloatAnimation;
    aniTransition: TFloatAnimation;
    aniDegrade: TGradientAnimation;
    procedure aniBouclePrincipaleProcess(Sender: TObject);
    procedure sbArrowUpClick(Sender: TObject);
    procedure sbArrowLeftClick(Sender: TObject);
    procedure sbArrowDownClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure sbChangeCameraClick(Sender: TObject);
    procedure sbAproposClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure sbArrowRightClick(Sender: TObject);
    procedure aniBouclePrincipaleFinish(Sender: TObject);
    procedure GagneRotationFinish(Sender: TObject);
    procedure animBalleIntroFinish(Sender: TObject);
    procedure pnlBoutonStartClick(Sender: TObject);
    procedure animRotationBalleFinish(Sender: TObject);
    procedure cbGyroActiveChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure aniTransitionFinish(Sender: TObject);
    procedure aniTransitionProcess(Sender: TObject);
    procedure GadgetsLayoutMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure GadgetsLayoutMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure GadgetsLayoutMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  private
    procedure ResetGame;
    procedure DeplacementBalle;
    procedure DeplacementBalleVersFond;
    procedure DeplacementBalleVersProche;
    procedure DeplacementBalleVersGauche;
    procedure DeplacementBalleVersDroite;
    procedure ChargerConfig;
    procedure SauverConfig;
    procedure ProcessAccelerometer;
    function TestPositionBalle(point: TPoint3D): boolean;
    procedure ChargerNiveau(level: integer);
    procedure AppIdle(Sender: TObject; var Done: boolean);
    procedure RotationBalle(oldPosBalle, newPosBalle: TPoint3D);
    procedure InitialiserJoystick;
    { Déclarations privées }
  public
    { Déclarations publiques }
    fichierConfig: string; // fichier de persistence des options
    limiteDroite, limiteGauche, limiteFond, limiteProche: single;
                           // limites des bordures du plateau (calculées lors du chargement du niveau et utilisées lors du déplacement de la balle)
    gagne: boolean;        // boolean indiquant si le joueur a gagné
    NiveauActuel: TNiveau; // informations du niveau en cours
    niveau, jeu: integer;  // niveau = indice du niveau en cours, jeu = indice de la phase de jeu (intro ou jeu)
    anglex, angley, anglez: single;
    joystick : boolean;    // sert pour le joystick virtuel
    Offset: TPointF;       // Décallage entre l'endroit du clic et le centre du cercle du joystick

  end;

const
  angleMax = 10; // + ou - amplitude du plateau en degré
  pasAngle = 0.1; // pas de l'angle à chaque action d'inclinaison du plateau
  pasVitesse = 0.1; // pas de vitesse de la balle à chaque action d'inclinaison du plateau

var
  fPrincipale: TfPrincipale;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

{ =======================================================================================================================
  Fin de la boucle principale du jeu
  ======================================================================================================================= }
procedure TfPrincipale.aniBouclePrincipaleFinish(Sender: TObject);
begin
  // Si le joueur a gagné, on affiche le message et la petite animation
  if gagne then
  begin
    if arriveeAnimation.Running then arriveeAnimation.Stop;
    tGagne.Visible := true;
    GagneRotation.Start;
  end;
end;

{ =======================================================================================================================
  Boucle principale du jeu :
  la variable "jeu" permet de savoir quelle phase du jeu on souhaite afficher : jeu = 0 c'est l'introduction, jeu = 1
  c'est le jeu en lui même.
  ======================================================================================================================= }
procedure TfPrincipale.aniBouclePrincipaleProcess(Sender: TObject);
begin

  // On fait tourner le petit logo Delphi en bas à gauche de la vue
  dLogoDelphi.RotationAngle.Z := dLogoDelphi.RotationAngle.Z + 3;

  // Intro du jeu
  if jeu = 0 then
  begin
    // On masque les éléments du jeu
    dmyPrincipal.Visible := false;
    hautPage.Visible := false;
    BasPage.Visible := false;

    // Sur Mac OS, le TText3D apparait en plus gros que sur PC et Android (peut être que la police utilisée n'est pas
    // la même sur Mac OS...
    {$IF DEFINED(MACOS)}
      textIntro.scale.Y := 0.25;
    {$ELSE}
      textIntro.scale.Y := 2;
    {$ENDIF}

    // Sur Android, les speedbuttons apparaissent plus petits
    {$IF DEFINED(Android)}
      hautPage.Height := 75;
    {$ELSE}
      hautPage.Height := 50;
    {$ENDIF}


    dmyIntro.Visible := true;

    // On force la caméra par défaut
    Viewport3D.UsingDesignCamera := true;

    // On active et rend visible les éléments de l'introduction
    lblParis.Visible := true;

    // La variable niveau indique le niveau du jeu à charger
    niveau := 1;
  end;

  // Lancement du jeu en lui même
  if jeu = 1 then
  begin
    if aniDegrade.Running then aniDegrade.stop;

    // On rend visible si nécessaire les éléments du jeu et on masque ceux de l'introduction
    if not dmyPrincipal.visible then
    begin
      dmyPrincipal.Visible := true;
      hautPage.Visible := true;
      BasPage.Visible := true;
      dmyIntro.Visible := false;
      pnlBoutonStart.Visible := false;
    end;

    // Utilisation du motionSensor si celui ci est activé par l'utilisateur
    if MotionSensor.Active then
      ProcessAccelerometer;

    // Affichage des axes de la balle
    if cbAfficherAxes.IsChecked then
    begin
      ConeX.Visible := true;
      ConeY.Visible := true;
      ConeZ.Visible := true;
      CylinderX.Visible := true;
      CylinderY.Visible := true;
      CylinderZ.Visible := true;
    end
    else
    begin
      ConeX.Visible := false;
      ConeY.Visible := false;
      ConeZ.Visible := false;
      CylinderX.Visible := false;
      CylinderY.Visible := false;
      CylinderZ.Visible := false;
    end;

    // Gestion du déplacement de la balle
    DeplacementBalle;
  end;
end;

{ =======================================================================================================================
  ======================================================================================================================= }
procedure TfPrincipale.animBalleIntroFinish(Sender: TObject);
begin
  // On arrête aussi l'animation de rotation de la balle d'intro
  if animRotationBalle.Running then animRotationBalle.Stop;
end;

{ =======================================================================================================================
  ======================================================================================================================= }
procedure TfPrincipale.animRotationBalleFinish(Sender: TObject);
begin
  pnlBoutonStart.Visible := true;
end;

procedure TfPrincipale.aniTransitionFinish(Sender: TObject);
begin
  // Au départ, la variable jeu est à 0 c'est l'introduction. On la passe à 1 lors du clic sur le viewport3d pour
  // passer à la phase jeu
  if jeu = 0 then
  begin
    niveau := 1;
    jeu := 1;
    ResetGame;
  end;
end;

{ =======================================================================================================================
  ======================================================================================================================= }
procedure TfPrincipale.aniTransitionProcess(Sender: TObject);
begin
  dmyIntro.Opacity := dmyIntro.Opacity - 0.05;
end;

{ =======================================================================================================================
  ======================================================================================================================= }
procedure TfPrincipale.AppIdle(Sender: TObject; var Done: boolean);
begin
  DeplacementBalle;
end;

{ =======================================================================================================================
  Inclinaison du plateau sur la droite (sur la vue d'origine)
  ======================================================================================================================= }
procedure TfPrincipale.sbArrowRightClick(Sender: TObject);
begin
  // angleMax est l'amplitude maximum autorisée
  // A noter : les propriétés RotationAngle vont de 0 à 359. Si on renseigne par exemple un angle sur un des axes de 365,
  // la propriété passe automatiquement à 5.
  if (trunc(dmyPrincipal.RotationAngle.Z) < angleMax) or (trunc(dmyPrincipal.RotationAngle.Z) >= 360 - angleMax) then
    dmyPrincipal.RotationAngle.Z := dmyPrincipal.RotationAngle.Z + pasAngle;
end;

{ =======================================================================================================================
  Inclinaison du plateau sur la gauche (sur la vue d'origine)
  ======================================================================================================================= }
procedure TfPrincipale.sbArrowLeftClick(Sender: TObject);
begin
  if (trunc(dmyPrincipal.RotationAngle.Z) <= angleMax) or (trunc(dmyPrincipal.RotationAngle.Z) > 360 - angleMax) then
    dmyPrincipal.RotationAngle.Z := dmyPrincipal.RotationAngle.Z - pasAngle;
end;

{ =======================================================================================================================
  Inclinaison du plateau vers le joueur (sur la vue d'origine)
  ======================================================================================================================= }
procedure TfPrincipale.sbArrowDownClick(Sender: TObject);
begin
  if (trunc(dmyPrincipal.RotationAngle.X) < angleMax) or (trunc(dmyPrincipal.RotationAngle.X) >= 360 - angleMax) then
    dmyPrincipal.RotationAngle.X := dmyPrincipal.RotationAngle.X + pasAngle;
end;

{ =======================================================================================================================
  Inclinaison du plateau vers le fond (sur la vue d'origine)
  ======================================================================================================================= }
procedure TfPrincipale.sbArrowUpClick(Sender: TObject);
begin
  if (trunc(dmyPrincipal.RotationAngle.X) <= angleMax) or (trunc(dmyPrincipal.RotationAngle.X) > 360 - angleMax) then
    dmyPrincipal.RotationAngle.X := dmyPrincipal.RotationAngle.X - pasAngle;
end;

{ =======================================================================================================================
  Clic sur le bouton de changement de caméra
  On bascule d'une caméra à l'autre toujours dans le même ordre
  ======================================================================================================================= }
procedure TfPrincipale.sbChangeCameraClick(Sender: TObject);
begin
  // Si la vue d'origine est activée
  if Viewport3D.UsingDesignCamera then
  begin
    // On force l'utilisation de la cameraTV
    Viewport3D.Camera := CameraTV;
    lblCamera.Text := 'Caméra TV avec suivi';
    Viewport3D.UsingDesignCamera := false;
  end
  else
  begin
    // Si la caméraTV est activée
    if Viewport3D.Camera = CameraTV then
    begin
      // On force l'utilisation de la cameraOpposée
      Viewport3D.Camera := CameraOpposee;
      lblCamera.Text := 'Caméra opposée';
    end
    else
    begin
      if Viewport3D.Camera = CameraOpposee then
      begin
        // Puis la caméra suiveuse
        Viewport3D.Camera := cameraSuiveuse;
        lblCamera.Text := 'Caméra suiveuse';
      end
      else
      begin
        // Retour à la vue d'origine
        Viewport3D.UsingDesignCamera := true;
        lblCamera.Text := 'Caméra classique';
      end;
    end;
  end;
end;

{ =======================================================================================================================
  Charger les options
  ======================================================================================================================= }
procedure TfPrincipale.ChargerConfig;
var
  IniFile: TMemIniFile;
begin
  // Si le fichier ini existe on le lit pour récupérer les infos
  if fileexists(fichierConfig + 'demooptions.ini') then
  begin
    IniFile := TMemIniFile.Create(fichierConfig + 'demooptions.ini');
    cbGyroActive.IsChecked := IniFile.ReadBool('OPTIONS', 'Gyroscope', false);
    tbGyroSensibilite.Value := IniFile.ReadFloat('OPTIONS', 'GyroSensibilite', 2.5);
    MotionSensor.Active := cbGyroActive.IsChecked;
    if cbGyroActive.IsChecked then
      tbGyroSensibilite.Enabled := true
    else
      tbGyroSensibilite.Enabled := false;
    cbAfficherAxes.IsChecked := IniFile.ReadBool('OPTIONS', 'AfficherAxes', false);

    IniFile.UpdateFile;
    IniFile.Free;
  end;
end;

{ =======================================================================================================================
  Sauvegarde des options
  ======================================================================================================================= }
procedure TfPrincipale.SauverConfig;
var
  IniFile: TMemIniFile;
begin
  // On sauvegarde les options dans le fichier ini
  IniFile := TMemIniFile.Create(fichierConfig + 'demooptions.ini');
  IniFile.WriteBool('OPTIONS', 'Gyroscope', cbGyroActive.IsChecked);
  IniFile.WriteFloat('OPTIONS', 'GyroSensibilite', tbGyroSensibilite.Value);
  IniFile.WriteBool('OPTIONS', 'AfficherAxes', cbAfficherAxes.IsChecked);
  IniFile.UpdateFile;
  IniFile.Free;
end;

{ =======================================================================================================================
  Gestion du déplacement de la balle
  ======================================================================================================================= }
procedure TfPrincipale.DeplacementBalle;
var
  pBalle, pArrivee: TPoint3D;
  oldPosBalle, newPosBalle: TPoint3D;
begin
  oldPosBalle := dmyBalle.position.point;

  if (dmyPrincipal.RotationAngle.Z >= 0) and (dmyPrincipal.RotationAngle.Z <= angleMax) then
    DeplacementBalleVersDroite;
  if (dmyPrincipal.RotationAngle.Z >= 360 - angleMax) then
    DeplacementBalleVersGauche;
  if (dmyPrincipal.RotationAngle.X >= 0) and (dmyPrincipal.RotationAngle.X <= angleMax) then
    DeplacementBalleVersProche;
  if (dmyPrincipal.RotationAngle.X >= 360 - angleMax) then
    DeplacementBalleVersFond;

  newPosBalle := dmyBalle.position.point;

  RotationBalle(oldPosBalle, newPosBalle);

  // Si la balle est sur le disque symbolisant l'arrivée, alors c'est gagné !
  pBalle := dmyBalle.LocalToAbsolute3D(dmyBalle.position.point);
  pArrivee := dmyBalle.LocalToAbsolute3D(arrivee.position.point);
  if pBalle.Distance(pArrivee) < 1 then
  begin
    gagne := true;
    if aniBouclePrincipale.Running then aniBouclePrincipale.Stop;
  end;
end;

{ =======================================================================================================================
  Gestion du déplacement de la balle vers le fond (par rapport à la vue par défaut)
  ======================================================================================================================= }
procedure TfPrincipale.DeplacementBalleVersFond;
var
  newPos: TPoint3D;
begin
  newPos := dmyBalle.position.point;
  // calcul de la nouvelle position de la dmyBalle
  newPos.Z := dmyBalle.position.Z + pasVitesse * (360 - dmyPrincipal.RotationAngle.X);

  // Test si la nouvelle position est valide (elle n'est pas valide si on rencontre un obstacle ou une bordure)
  if TestPositionBalle(newPos) then
  begin
    // Déplacement de la dmyBalle
    TAnimator.AnimateFloat(dmyBalle, 'Position.Z', newPos.Z);
    anglex := anglex - angleMax * (360 - dmyPrincipal.RotationAngle.X);
  end;
end;

{ =======================================================================================================================
  Gestion du déplacement de la balle vers la bordure proche (par rapport à la vue par défaut)
  ======================================================================================================================= }
procedure TfPrincipale.DeplacementBalleVersProche;
var
  newPos: TPoint3D;
begin
  newPos := dmyBalle.position.point;
  newPos.Z := dmyBalle.position.Z - pasVitesse * dmyPrincipal.RotationAngle.X;
  if TestPositionBalle(newPos) then
  begin
    TAnimator.AnimateFloat(dmyBalle, 'Position.Z', newPos.Z);
    anglex := anglex + angleMax * dmyPrincipal.RotationAngle.X;
  end;
end;

{ =======================================================================================================================
  Gestion du déplacement de la balle vers la bordure gauche (par rapport à la vue par défaut)
  ======================================================================================================================= }
procedure TfPrincipale.DeplacementBalleVersGauche;
var
  newPos: TPoint3D;
begin
  newPos := dmyBalle.position.point;
  newPos.X := dmyBalle.position.X - pasVitesse * (360 - dmyPrincipal.RotationAngle.Z);
  if TestPositionBalle(newPos) then
  begin
    TAnimator.AnimateFloat(dmyBalle, 'Position.X', newPos.X);
    anglez := anglez - angleMax * (360 - dmyPrincipal.RotationAngle.Z);
  end;
end;

{ =======================================================================================================================
  Gestion du déplacement de la balle vers la bordure droite (par rapport à la vue par défaut)
  ======================================================================================================================= }
procedure TfPrincipale.DeplacementBalleVersDroite;
var
  newPos: TPoint3D;
begin
  newPos := dmyBalle.position.point;
  newPos.X := dmyBalle.position.X + pasVitesse * dmyPrincipal.RotationAngle.Z;
  if TestPositionBalle(newPos) then
  begin
    TAnimator.AnimateFloat(dmyBalle, 'Position.X', newPos.X);
    anglez := anglez + angleMax * dmyPrincipal.RotationAngle.Z;
  end;
end;

{ =======================================================================================================================
  Test la position de la raquette par rapport à la zone de jeu où elle peut évoluer
  ======================================================================================================================= }
function TfPrincipale.TestPositionBalle(point: TPoint3D): boolean;
var
  resultat: boolean;
  i: integer;
  balleXMin, balleXMax, obstacleXMin, obstacleXMax, balleZMin, BalleZMax, obstacleZMin, obstacleZMax: single;
  moitieBalleLargeur, moitieBalleProfondeur: single;
begin
  resultat := true;

  // Juste pour éviter de faire ces 2 calculs systématiquement dans le for plus loin
  moitieBalleLargeur := balle.Width / 2;
  moitieBalleProfondeur := balle.Depth / 2;

  // Si la balle est sur la bordure gauche, sur la bordure droite, sur la bordure du fond ou sur la bordure de devant,
  // on bloque sa position
  if (point.X <= limiteGauche) or (point.X >= limiteDroite) or (point.Z >= limiteFond) or (point.Z <= limiteProche) then
    resultat := false;

  // Test de la balle et des obstacles
  for i := 0 to NiveauActuel.NbObstacle - 1 do
  begin
    with NiveauActuel.fListObstacle[i] do
    begin
      balleXMin := point.X - moitieBalleLargeur;
      balleXMax := point.X + moitieBalleLargeur;
      balleZMin := point.Z - moitieBalleProfondeur;
      BalleZMax := point.Z + moitieBalleProfondeur;

      obstacleXMin := position.X - Width / 2;
      obstacleXMax := position.X + Width / 2;
      obstacleZMin := position.Z - Depth / 2;
      obstacleZMax := position.Z + Depth / 2;

      // Méthode de test de collision simple mais efficace => nécessite des obstacles parralèles ou perpendiculaires aux bordures du plateau
      if ((obstacleXMin >= balleXMin) and (obstacleXMin <= balleXMax)) or
         ((obstacleXMax >= balleXMin) and (obstacleXMax <= balleXMax)) or
         ((balleXMin >= obstacleXMin) and (balleXMin <= obstacleXMax)) or
         ((balleXMax >= obstacleXMin) and (balleXMax <= obstacleXMax)) then
      begin
        if ((balleZMin >= obstacleZMin) and (balleZMin <= obstacleZMax)) or
           ((BalleZMax >= obstacleZMin) and (BalleZMax <= obstacleZMax)) or
           ((obstacleZMin >= balleZMin) and (obstacleZMin <= BalleZMax)) or
           ((obstacleZMax >= balleZMin) and (obstacleZMax <= BalleZMax)) then
          resultat := false;
      end;
    end;
  end;

  result := resultat;
end;

{ =======================================================================================================================
  Gestion de la rotation de la balle pour un rendu réaliste (on doit pouvoir faire mieux : ce n'est pas encore le cas...)
  ======================================================================================================================= }
procedure TfPrincipale.RotationBalle(oldPosBalle, newPosBalle: TPoint3D);
var
 P1 : TPoint3D;
begin
   if newPosBalle.Distance(oldPosBalle) < epsilon then exit;

   P1.X := angleX;
   P1.Y := 0;
   P1.Z := angleZ;

   balle.BeginUpdate;
   Balle.RotationAngle.Point := NullPoint3D;
   Balle.RotationAngle.Point := P1;
   balle.EndUpdate;
end;

{ =======================================================================================================================
  Affichage de l'écran des options
  ======================================================================================================================= }
procedure TfPrincipale.sbAproposClick(Sender: TObject);
begin
  // On met en pause l'animation boucle principale
  aniBouclePrincipale.Pause := true;
  // On rend le layout des options visible
  layOptions.Visible := true;
  // Paramétrage de l'animation de scrolling vertical de l'écran des options
  animOptions.StartValue := -layOptions.Height;
  animOptions.StopValue := Round(fPrincipale.Height / 2) - Round(layOptions.Height / 2);
  animOptions.Start;
end;

{ =======================================================================================================================
  Clic sur le bouton Ok des options
  ======================================================================================================================= }
procedure TfPrincipale.btnOkClick(Sender: TObject);
begin
  animOptions.StartValue := Round(fPrincipale.Height / 2) - Round(layOptions.Height / 2);
  animOptions.StopValue  := -layOptions.Height;
  animOptions.Start;

  MotionSensor.Active := cbGyroActive.IsChecked;

  // Sauvegarde des paramètres
  SauverConfig;

  // On réactive l'animation boucle principale
  aniBouclePrincipale.Pause := false;
end;

{ =======================================================================================================================
  Activation du trackbar de sensibilité du gyroscope si la case est cochée
  ======================================================================================================================= }
procedure TfPrincipale.cbGyroActiveChange(Sender: TObject);
begin
  tbGyroSensibilite.Enabled := cbGyroActive.IsChecked;
end;

procedure TfPrincipale.InitialiserJoystick;
begin
  TAnimator.AnimateFloat(Center,'Position.X',20);
  TAnimator.AnimateFloat(Center,'Position.Y',20);
  dmyPrincipal.RotationAngle.X := 0;
  dmyPrincipal.RotationAngle.z := 0;
end;

{ =======================================================================================================================
  Création de la form
  ======================================================================================================================= }
procedure TfPrincipale.FormCreate(Sender: TObject);
begin
  // Récupération du répertoire où est stocké le fichier de persistence du paramétrage
  // Sous Windows, on le place dans le même répertoire que l'exe
  // pour les autres plate-formes, on le place dans le répertoire des documents de l'utilisateur
  {$IF DEFINED(MSWINDOWS)}
    fichierConfig := ExtractFilePath(ParamStr(0));
  {$ELSE}
    fichierConfig := System.IOUtils.TPath.GetDocumentsPath + System.SysUtils.PathDelim;
  {$ENDIF}
  ChargerConfig;
  jeu := 0;
  niveau := 1;
  center.AutoCapture := true;
  joystick := false;
  ResetGame;
  Application.OnIdle := AppIdle;
end;

{ =======================================================================================================================
  Prise en compte de l'appuie sur les flèches du clavier pour incliner le plateau
  ======================================================================================================================= }
procedure TfPrincipale.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = VKUP then
    sbArrowUpClick(Sender);
  if Key = VKDOWN then
    sbArrowDownClick(Sender);
  if Key = VKLEFT then
    sbArrowLeftClick(Sender);
  if Key = VKRIGHT then
    sbArrowRightClick(Sender);
end;

{ =======================================================================================================================
  A la fin de l'animation "Gagné", on passe au niveau suivant
  ======================================================================================================================= }
procedure TfPrincipale.GadgetsLayoutMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Offset.X := X;
  Offset.Y := Y;
  GadgetsLayout.Root.Captured := GadgetsLayout;
  joystick := true;
end;

{ =======================================================================================================================
  Gestion du joysticke virtuel
  ======================================================================================================================= }
procedure TfPrincipale.GadgetsLayoutMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
  diffX, diffY, newX, newY : single;
begin
  if joystick then
  begin
    if X > (GadgetsLayout.Width + Offset.X ) then
      X := GadgetsLayout.Width + Offset.X  ;
    if Y > (GadgetsLayout.Height + Offset.Y  ) then
      Y := GadgetsLayout.Height + Offset.Y ;

    newX := X - Offset.X + center.Width/3;
    newY := Y - Offset.Y + center.Width/3;

    diffX := (center.Position.X - newX) * pasAngle/2.5;
    diffY := (center.Position.Y - newY) * pasAngle/2.5;
    dmyPrincipal.RotationAngle.Z := dmyPrincipal.RotationAngle.Z - diffX;
    dmyPrincipal.RotationAngle.X := dmyPrincipal.RotationAngle.X - diffY;
    center.Position.X := newX;
    center.Position.Y := newY;
  end;
end;

procedure TfPrincipale.GadgetsLayoutMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  joystick := false;
  InitialiserJoystick;
end;

procedure TfPrincipale.GagneRotationFinish(Sender: TObject);
begin
  inc(niveau);
  ResetGame;
  aniBouclePrincipale.Start;
end;

{ =======================================================================================================================
  Clic sur le bouton start de l'écran d'intro, on déclenche l'animation du bouton
  ======================================================================================================================= }
procedure TfPrincipale.pnlBoutonStartClick(Sender: TObject);
begin
  aniClic.Start;
  aniTransition.Start;
end;

{ =======================================================================================================================
  Réinitialisation du niveau en cours
  ======================================================================================================================= }
procedure TfPrincipale.ResetGame;
begin
  if aniBouclePrincipale.Running then aniBouclePrincipale.Stop;
  if GagneRotation.Running then GagneRotation.Stop;
  if arriveeAnimation.Running then arriveeAnimation.Stop;

  if assigned(NiveauActuel) then NiveauActuel.Free;
  NiveauActuel := TNiveau.Create(Viewport3D, dmyPrincipal, lmsObstacle);

  if niveau > 0 then
  begin
    ChargerNiveau(niveau);

    lblTitre.Text := NiveauActuel.Titre;

    dmyPrincipal.RotationAngle.X := 0;
    dmyPrincipal.RotationAngle.Y := 0;
    dmyPrincipal.RotationAngle.Z := 0;

    dmyBalle.position.X := NiveauActuel.PositionDepart.X;
    dmyBalle.position.Y := NiveauActuel.PositionDepart.Y;
    dmyBalle.position.Z := NiveauActuel.PositionDepart.Z;

    arrivee.position.X := NiveauActuel.PositionArrivee.X;
    arrivee.position.Y := NiveauActuel.PositionArrivee.Y;
    arrivee.position.Z := NiveauActuel.PositionArrivee.Z;

    balle.RotationAngle.X := 0;
    balle.RotationAngle.Y := 0;
    balle.RotationAngle.Z := 0;

    limiteDroite := bordDroit.position.X  - bordDroit.Width / 2  - balle.Width / 2;
    limiteGauche := bordGauche.position.X + bordGauche.Width / 2 + balle.Width / 2;
    limiteFond   := bordFond.position.Z   - bordFond.Depth / 2   - balle.Depth / 2;
    limiteProche := bordProche.position.Z + bordProche.Depth / 2 + balle.Depth / 2;
    gagne := false;
    tGagne.Visible := false;
    arriveeAnimation.Start;
  end;

  aniBouclePrincipale.Start;
end;

{ =======================================================================================================================
  Mouvement du plateau en fonction du gyroscope
  ======================================================================================================================= }
procedure TfPrincipale.ProcessAccelerometer;
var
  AccX, AccZ: single;
begin
  if MotionSensor.Sensor = nil then
    Exit;

  // Récupération des infos du capteur multipliées par le trackbar de sensibilité
  AccX := (MotionSensor.Sensor.AccelerationX * tbGyroSensibilite.Value);
  AccZ := (MotionSensor.Sensor.AccelerationZ * tbGyroSensibilite.Value);

  with dmyPrincipal.RotationAngle do
  begin
    if (X + accZ > 360-angleMax) or (X + accZ < angleMax) then
    begin
      if (Z + accX > 360-angleMax) or (Z + accX < angleMax) then
      begin
        //  Nouvelle position du plateau
        X := X + AccZ;
        Z := Z + AccX;
      end;
    end;
  end;
end;

{ =======================================================================================================================
  Chargement d'un niveau, si le niveau n'existe pas, retour à l'écran d'accueil
  ======================================================================================================================= }
procedure TfPrincipale.ChargerNiveau(level: integer);
begin
  angleX := 0;
  angleY := 0;
  angleZ := 0;

  case level of
    1:
      NiveauActuel.chargerNiveau1;
    2:
      NiveauActuel.chargerNiveau2;
    3:
      NiveauActuel.chargerNiveau3;
  else
    begin
      jeu := 0;
      niveau := 0;
      dmyIntro.Opacity := 1;
      pnlBoutonStart.Visible := true;
    end;
  end;
end;

end.
