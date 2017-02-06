package WayfinderModel;

import java.util.ArrayList;

/**
 * Created by admin on 1/31/2017.
 */
public class Point {
    private String id;
    private int offX;
    private int offY;
    private boolean access;
    private ArrayList<String> connectedPointList;

    public Point()
    {

    };

    public Point(String id, int offX, int offY, boolean access)
    {
        this.setId(id);
        this.setOffX(offX);
        this.setOffY(offY);
        this.setAccess(access);
    }

    public ArrayList<String> getConnectedPointList() {
        return connectedPointList;
    }

    public void setConnectedPointList(ArrayList<String> connectedPointList) {
        this.connectedPointList = connectedPointList;
    }

    public int getOffX() {
        return offX;
    }

    public void setOffX(int offX) {
        this.offX = offX;
    }

    public int getOffY() {
        return offY;
    }

    public void setOffY(int offY) {
        this.offY = offY;
    }

    public boolean isAccess() {
        return access;
    }

    public void setAccess(boolean access) {
        this.access = access;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getDistance(String id1, String id2)
    {
        double distance = 0;

        return distance;
    }
}
