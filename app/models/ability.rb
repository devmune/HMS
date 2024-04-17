# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      cannot :manage, :all
      cannot :read, Hospital
    elsif user.Admin?
      can :manage, :all
    elsif user.Doctor?
      can :manage, Request, user_id: user.id
      can :read, Hospital, hospital_treatments: { doctor_id: user.id }
      can :read, Treatment, hospital_treatments: { doctor_id: user.id }
      can :manage, HospitalTreatment, hospital: { hospital_treatments: { doctor_id: user.id } }
      # # Doctor can only read hospitals where they are a member
      # can :read, Hospital, :HospitalTreatment => { :user_id => user.id }
      # # Doctor can manage their own requests
      # can :manage, Request, :user_id => user.id
      # # Doctor can manage hospital treatments where they are a member
      # can :manage, HospitalTreatment, :hospital => { :HospitalTreatment => { :user_id => user.id } }
    elsif user.Patient?
      # Patient can read all hospitals and their treatments
      can :read, Hospital
      can :read, Treatment
      # Patient can manage their own requests
      can :manage, Request, :user_id => user.id
    end
  end
end

    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md


