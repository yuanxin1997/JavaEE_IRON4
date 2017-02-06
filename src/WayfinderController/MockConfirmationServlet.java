package WayfinderController;

import java.util.ArrayList;

/**
 * Created by admin on 2/1/2017.
 */
public class MockConfirmationServlet {

    public void generateMap()
    {
        //prepare list of co-ordinates from session
        ArrayList<Integer> offXList = new ArrayList<Integer>();
        ArrayList<Integer> offYList = new ArrayList<Integer>();

        ImageRenderController irc = new ImageRenderController();

        //spawning waypoints
        for(int i = 0; i < offXList.size(); i++)
        {
            irc.spawnWaypoint(offXList.get(i), offYList.get(i));
        }

        //spawning arrows
        for(int i = 0; i < offXList.size() - 1; i++)
        {
            if(isNorth(offYList.get(i), offYList.get(i+1)))
            {
                irc.spawnNorth(offXList.get(i+1) - (irc.getNorth().getWidth()/2), offYList.get(i+1), offYList.get(i) - offYList.get(i+1));
            }else if(isSouth(offYList.get(i), offYList.get(i+1)))
            {
                irc.spawnSouth(offXList.get(i) - (irc.getSouth().getWidth()/2), offYList.get(i), offYList.get(i+1) - offYList.get(i));
            }else if(isEast(offXList.get(i), offXList.get(i+1)))
            {
                irc.spawnEast(offXList.get(i), offYList.get(i) - (irc.getEast().getHeight()/2), offXList.get(i+1) - offXList.get(i));
            }else if(isWest(offXList.get(i), offXList.get(i+1)))
            {
                irc.spawnWest(offXList.get(i+1), offYList.get(i+1) - (irc.getEast().getHeight()/2), offXList.get(i) - offXList.get(i+1));
            }
        }

        //spawning currentIndicator
        //current co-ordinate from session
        int ciX = 0;
        int ciY = 0;
        irc.spawnCurrentIndicator(ciX, ciY);

    }

    public static boolean isNorth(int y1, int y2)
    {
        boolean n = false;
        n = y2 < y1;
        return n;
    }

    public static boolean isSouth(int y1, int y2)
    {
        boolean s = false;
        s = y2 > y1;
        return s;
    }

    public static boolean isEast(int x1, int x2)
    {
        boolean e = false;
        e = x2 > x1;
        return e;
    }

    public static boolean isWest(int x1, int x2)
    {
        boolean w = false;
        w = x2 < x1;
        return w;
    }
}
