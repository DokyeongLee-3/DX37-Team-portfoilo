
#include "Player.h"
#include "PlayerAnimation.h"
#include "Input.h"

CPlayer::CPlayer()
{
	SetTypeID<CPlayer>();
}

CPlayer::CPlayer(const CPlayer& obj)	:
	CGameObject(obj)
{
	m_Mesh = (CAnimationMeshComponent*)FindComponent("Mesh");
	m_Arm = (CArm*)FindComponent("Arm");
	m_Camera = (CCameraComponent*)FindComponent("Camera");
}

CPlayer::~CPlayer()
{
}

bool CPlayer::Init()
{
	m_Mesh = CreateComponent<CAnimationMeshComponent>("Mesh");
	m_Arm = CreateComponent<CArm>("Arm");
	m_Camera = CreateComponent<CCameraComponent>("Camera");

	m_Mesh->AddChild(m_Arm);

	m_Arm->AddChild(m_Camera);

	m_Camera->SetInheritRotX(true);
	m_Camera->SetInheritRotY(true);
	m_Camera->SetInheritRotZ(true);

	m_Mesh->SetMesh("PlayerMesh");
	m_Mesh->CreateAnimationInstance<CPlayerAnimation>();

	m_Animation = (CPlayerAnimation*)m_Mesh->GetAnimationInstance();

	m_Mesh->SetRelativeScale(0.05f, 0.05f, 0.05f);

	m_Arm->SetOffset(0.f, 1.f, 0.f);
	m_Arm->SetRelativeRotation(15.f, 0.f, 0.f);
	m_Arm->SetTargetDistance(10.f);


	//CInput::GetInst()->SetKeyCallback<CPlayer>("MoveFront", KeyState_Push,
	//	this, &CPlayer::MoveFront);
	//CInput::GetInst()->SetKeyCallback<CPlayer>("MoveBack", KeyState_Push,
	//	this, &CPlayer::MoveBack);

	//CInput::GetInst()->SetKeyCallback<CPlayer>("Attack1", KeyState_Down,
	//	this, &CPlayer::Attack);


	return true;
}

void CPlayer::Update(float DeltaTime)
{
	CGameObject::Update(DeltaTime);

	//if (CInput::GetInst()->GetWheelDir())
	//{
	//	float Length = m_Arm->GetTargetDistance() +
	//		CInput::GetInst()->GetWheelDir() * 0.1f;

	//	m_Arm->SetTargetDistance(Length);
	//}

	////m_Arm->AddRelativeRotationY(90.f * DeltaTime);
	//if (m_Velocity.Length() > 0.f)
	//{
	//	m_Animation->ChangeAnimation("Walk");
	//	m_Animation->SetIdleEnable(true);
	//}

	//else if(m_Animation->GetIdleEnable())
	//{
	//	m_Animation->ChangeAnimation("Idle");
	//}
}

void CPlayer::PostUpdate(float DeltaTime)
{
	CGameObject::PostUpdate(DeltaTime);

	m_Velocity = Vector3::Zero;
}

CPlayer* CPlayer::Clone()
{
	return new CPlayer(*this);
}

void CPlayer::MoveFront(float DeltaTime)
{
	m_Velocity += GetWorldAxis(AXIS_Z) * 1.f * DeltaTime;

	AddWorldPos(GetWorldAxis(AXIS_Z) * 1.f * DeltaTime);
}

void CPlayer::MoveBack(float DeltaTime)
{
	m_Velocity += GetWorldAxis(AXIS_Z) * -1.f * DeltaTime;

	AddWorldPos(GetWorldAxis(AXIS_Z) * -1.f * DeltaTime);
}

void CPlayer::RotationYInv(float DeltaTime)
{
}

void CPlayer::RotationY(float DeltaTime)
{
}

void CPlayer::Attack(float DeltaTime)
{
	m_Animation->ChangeAnimation("Attack");
	m_Animation->SetIdleEnable(false);
}
