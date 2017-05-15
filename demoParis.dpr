program demoParis;

uses
  System.StartUpCopy,
  FMX.Forms,
  principale in 'principale.pas' {fPrincipale},
  uNiveau in 'uNiveau.pas';

{$R *.res}

begin
  // Forcer l'émulation logicielle de DirectX si la carte graphique n'est pas compatible
  // shader model 5 et DirectX 11
  // Décommentez la ligne suivante :
  // fmx.types.GlobalUseDXSoftware := True;

  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TfPrincipale, fPrincipale);
  Application.Run;
end.
