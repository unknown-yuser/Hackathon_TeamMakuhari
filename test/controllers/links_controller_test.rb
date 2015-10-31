require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  setup do
    @link = links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create link" do
    assert_difference('Link.count') do
      post :create, link: { blind_guide: @link.blind_guide, bus_stop: @link.bus_stop, bus_stop_latitude: @link.bus_stop_latitude, bus_stop_longitude: @link.bus_stop_longitude, dst_node_id: @link.dst_node_id, gap: @link.gap, gap_latitude: @link.gap_latitude, gap_longitude: @link.gap_longitude, hill: @link.hill, length: @link.length, id: @link.id, signals: @link.signals, src_node_id: @link.src_node_id, steps: @link.steps, street_name: @link.street_name, type: @link.link_type, width: @link.width }
    end

    assert_redirected_to link_path(assigns(:link))
  end

  test "should show link" do
    get :show, id: @link
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @link
    assert_response :success
  end

  test "should update link" do
    patch :update, id: @link, link: { blind_guide: @link.blind_guide, bus_stop: @link.bus_stop, bus_stop_latitude: @link.bus_stop_latitude, bus_stop_longitude: @link.bus_stop_longitude, dst_node_id: @link.dst_node_id, gap: @link.gap, gap_latitude: @link.gap_latitude, gap_longitude: @link.gap_longitude, hill: @link.hill, length: @link.length, id: @link.id, signals: @link.signals, src_node_id: @link.src_node_id, steps: @link.steps, street_name: @link.street_name, type: @link.link_type, width: @link.width }
    assert_redirected_to link_path(assigns(:link))
  end

  test "should destroy link" do
    assert_difference('Link.count', -1) do
      delete :destroy, id: @link
    end

    assert_redirected_to links_path
  end
end
