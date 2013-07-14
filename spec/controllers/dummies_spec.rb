require 'spec_helpers/boot'

describe DummiesController do
  before(:all) do
    Dummy.create! id: 1
  end

  after(:all) do
    Dummy.find(1).destroy
  end

  describe "entities assignation" do
    context "without integration" do
      it "works for index" do
        expect{ get :index }.to raise_error(CanCan::AccessDenied)
      end

      it "works for show" do
        expect{ get :show, id: 1 }.to raise_error(CanCan::AccessDenied)
      end

      it "works for create" do
        expect{ post :create }.to raise_error(CanCan::AccessDenied)
      end

      it "works for edit" do
        expect{ get :edit, id: 1 }.to raise_error(CanCan::AccessDenied)
      end

      it "works for update" do
        expect{ put :edit, id: 1 }.to raise_error(CanCan::AccessDenied)
      end

      it "works for destroy" do
        expect{ delete :destroy, id: 1 }.to raise_error(CanCan::AccessDenied)
      end
    end

    context "with integration" do
      it "works for index" do
        get :index, protector: true
        expect(response).to be_success
        assigns(:dummies).protector_subject?.should == true
        assigns(:dummies).protector_subject.should == 'user'
      end

      it "works for show" do
        get :show, id: 1, protector: true
        expect(response).to be_success
        assigns(:dummy).protector_subject?.should == true
        assigns(:dummy).protector_subject.should == 'user'
      end

      it "works for create" do
        post :create, protector: true
        expect(response).to be_success
        assigns(:dummy).protector_subject?.should == true
        assigns(:dummy).protector_subject.should == 'user'
      end

      it "works for edit" do
        get :edit, id: 1, protector: true
        expect(response).to be_success
        assigns(:dummy).protector_subject?.should == true
        assigns(:dummy).protector_subject.should == 'user'
      end

      it "works for update" do
        put :edit, id: 1, protector: true
        expect(response).to be_success
        assigns(:dummy).protector_subject?.should == true
        assigns(:dummy).protector_subject.should == 'user'
      end

      it "works for destroy" do
        delete :destroy, id: 1, protector: true
        expect(response).to be_success
        assigns(:dummy).protector_subject?.should == true
        assigns(:dummy).protector_subject.should == 'user'
      end

      it "does not override set subject" do
        get :test, protector: true
        expect(response).to be_success
        assigns(:dummies).protector_subject?.should == true
        assigns(:dummies).protector_subject.should == 'test'
      end
    end
  end
end