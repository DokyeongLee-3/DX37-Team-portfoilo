
#include "MainSceneMode.h"
#include "Scene/Scene.h"
#include "Scene/SceneResource.h"
#include "Scene/Viewport.h"
#include "../Object/Player.h"
#include "GameObject/LightObj.h"
#include "Component/LightComponent.h"
#include "Resource/Material/Material.h"

CMainSceneMode::CMainSceneMode()
{
	SetTypeID<CMainSceneMode>();
}

CMainSceneMode::~CMainSceneMode()
{
}

bool CMainSceneMode::Init()
{
	LoadMesh();

	CreateMaterial();

	CreateAnimationSequence();

	CreateParticle();

	if (m_LoadingFunction)
		m_LoadingFunction(false, 0.3f);

	CPlayer* Player = m_Scene->CreateGameObject<CPlayer>("Player");

	SetPlayerObject(Player);

 //	CLightObj* Light = m_Scene->CreateGameObject<CLightObj>("Light1");
 //
 //	((CLightComponent*)Light->GetRootComponent())->SetRelativePos(-3.f, 5.f, 0.f);
 //	((CLightComponent*)Light->GetRootComponent())->SetLightType(Light_Type::Point);
 //	((CLightComponent*)Light->GetRootComponent())->SetDistance(10.f);
 //	((CLightComponent*)Light->GetRootComponent())->SetAtt3(0.02f);
 //	((CLightComponent*)Light->GetRootComponent())->SetColor(Vector4(1.f, 0.f, 0.f, 1.f));
 //
 //	CLightObj* Light2 = m_Scene->CreateGameObject<CLightObj>("Light2");
 //
 //	((CLightComponent*)Light2->GetRootComponent())->SetRelativePos(3.f, 5.f, 0.f);
 //	((CLightComponent*)Light2->GetRootComponent())->SetLightType(Light_Type::Point);
 //	((CLightComponent*)Light2->GetRootComponent())->SetDistance(10.f);
 //	((CLightComponent*)Light2->GetRootComponent())->SetAtt3(0.02f);
 //	((CLightComponent*)Light2->GetRootComponent())->SetColor(Vector4(0.f, 1.f, 0.f, 1.f));
 //	
	return true;
}

void CMainSceneMode::LoadMesh()
{
	m_Scene->GetResource()->LoadMesh(Mesh_Type::Animation, "PlayerMesh",
		TEXT("AhariIdle.msh"));

	m_Scene->GetResource()->LoadMesh(Mesh_Type::Animation, "AhariRun",
		TEXT("AhariRun.fbx"));

	CMesh* Mesh = m_Scene->GetResource()->FindMesh("PlayerMesh");

	/*CSharedPtr<CMaterial>	Mtrl = Mesh->GetMaterial(2);

	Mtrl->AddTexture(3, (int)Buffer_Shader_Type::Pixel,
		"CageEmv", TEXT("Player_Default.fbm/DXT1_cage003_EM.dds"),
		MESH_PATH);

	for (int i = 0; i < Mesh->GetMaterialSlots()->size(); ++i)
	{
		Mtrl = Mesh->GetMaterial(i);

		Mtrl->SetEmissiveColor(1.f, 1.f, 1.f, 1.f);
	}*/

	m_Scene->GetResource()->LoadSkeleton("PlayerSkeleton",
		TEXT("AhariIdle.bne"), MESH_PATH);

	m_Scene->GetResource()->SetMeshSkeleton("PlayerMesh", "PlayerSkeleton");

	m_Scene->GetResource()->LoadAnimationSequence(true, "PlayerIdle",
		TEXT("AhariIdle.sqc"), MESH_PATH);

	m_Scene->GetResource()->LoadAnimationSequence(false, "PlayerAttack",
		TEXT("AhariIdle.sqc"), MESH_PATH);

	m_Scene->GetResource()->LoadAnimationSequence(true, "PlayerWalk",
		TEXT("AhariRun.sqc"), MESH_PATH);
}

void CMainSceneMode::CreateMaterial()
{
	
}

void CMainSceneMode::CreateAnimationSequence()
{
}

void CMainSceneMode::CreateParticle()
{
}
