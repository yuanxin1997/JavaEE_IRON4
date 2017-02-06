package WayfinderModel;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;

/**
 * Created by admin on 1/31/2017.
 */
public class Route {
    private String startPoint;
    private String destPoint;
    private int totalEffort;
    private int totalDistance;
    private int shortestDistance;
    private ArrayList<String> pointList;
    private ArrayList<String> shortestList;
    private ArrayList<String> accessList;
    private String previousCurrent = null;

    public Route(String start, String dest)
    {
        this.setStartPoint(start);
        this.setDestPoint(dest);
        this.setTotalEffort(0);
        this.setTotalDistance(0);
        this.setShortestDistance(0);
        this.pointList = new ArrayList<String>();
        this.shortestList = new ArrayList<String>();
        this.accessList = new ArrayList<String>();
    }

    public String getStartPoint() {
        return startPoint;
    }

    public ArrayList<String> getShortestList() {
        return shortestList;
    }

    public void setShortestList(ArrayList<String> shortestList) {
        this.shortestList = shortestList;
    }

    public ArrayList<String> getAccessList() {
        return accessList;
    }

    public void setAccessList(ArrayList<String> accessList) {
        this.accessList = accessList;
    }

    public void setStartPoint(String startPoint) {
        this.startPoint = startPoint;
    }

    public String getDestPoint() {
        return destPoint;
    }

    public void setDestPoint(String destPoint) {
        this.destPoint = destPoint;
    }

    public int getTotalEffort() {
        return totalEffort;
    }

    public void setTotalEffort(int totalEffort) {
        this.totalEffort = totalEffort;
    }

    public int getTotalDistance() {
        return totalDistance;
    }

    public void setTotalDistance(int totalDistance) {
        this.totalDistance = totalDistance;
    }

    public int getShortestDistance() {
        return shortestDistance;
    }

    public void setShortestDistance(int shortestDistance) {
        this.shortestDistance = shortestDistance;
    }

    public ArrayList<String> getPointList() {
        return pointList;
    }

    public void setPointList(ArrayList<String> pointList) {
        this.pointList = pointList;
    }

    public void addPoint(String id)
    {
        this.getPointList().add(id);
    }

    public boolean isPointExist(String id)
    {
        boolean exist = false;
        for(int i = 0; i < this.pointList.size(); )
        {
            if(this.pointList.get(i).equalsIgnoreCase(id))
            {
                exist = true;
            }
        }
        return exist;
    }

    public ArrayList<String> setShortestRoute(ArrayList<Point> pointList)
    {
        if(this.getStartPoint().equalsIgnoreCase(this.getDestPoint()))
        {
            ArrayList<String> strList = new ArrayList<String>();
            strList.add(this.getStartPoint());
            this.setPointList(strList);
            return strList;
        }else
        {
            ArrayList<ArrayList<String>> routeList = new ArrayList<ArrayList<String>>();

            //add first point
            Point current = null;
            breakloop:
            for(Point a : pointList)
            {
                if(a.getId().equalsIgnoreCase(this.getStartPoint()))
                {
                    current = a;
                    routeList.add(new ArrayList<String>(Arrays.asList(current.getId())));
                    //debug print
                    System.out.println("added first");
                    break breakloop;
                }
            }

            ArrayList<String> tempCPList = new ArrayList<String>();
            boolean finish = true;
            //debug print
            System.out.println("next go to loop");
            do
            {
                boolean test = true;
                finish = true;
                breakloop:
                for(ArrayList<String> route: routeList)
                {
                    if(!route.get(route.size()-1).equalsIgnoreCase(this.getDestPoint()))
                    {
                        for(Point a: pointList)
                        {
                            if(a.getId().equalsIgnoreCase(route.get(route.size()-1)))
                            {
                                current = a;
                                //debug print
                                System.out.println("new current");
                                if(test)
                                {
                                    this.previousCurrent = route.size() > 1? route.get(route.size() - 2): route.get(0);
                                    test = false;
                                }
                                break breakloop;
                            }
                        }
                    }
                }

                int count = -1;

                for(int i = 0; i < current.getConnectedPointList().size(); i++)
                {

                    for(ArrayList<String> route: routeList)
                    {

                        if(!route.contains(current.getConnectedPointList().get(i)) && route.get(route.size()-1).equalsIgnoreCase(current.getId()))
                        {
                            boolean addCP = route.size() > 1 ? route.get(route.size() -2).equalsIgnoreCase(this.previousCurrent) : true;
                            if(addCP)
                            {
                                String debugString = route.get(route.size() > 1 ? route.size()-2 : 0);
                                ArrayList<String> debugRoute = route;
                                String debugString2 = current.getConnectedPointList().get(i);
                                if(!isReverse(pointList, current.getId(), route.get(route.size() > 1 ? route.size()-2 : 0), current.getConnectedPointList().get(i)))
                                {

                                    tempCPList.add(current.getConnectedPointList().get(i));
                                    count++;
                                    //debug print
                                    System.out.println("added tempCP");
                                }
                            }


                        }
                    }
                }

                if(count == -1)
                {
                    for(int i = 0; i < routeList.size(); i++)
                    {
                        if(routeList.get(i).get(routeList.get(i).size()-1).equalsIgnoreCase(current.getId()))
                        {
                            routeList.remove(i);
                            //debug print
                            System.out.println("removed death end");
                        }
                    }
                }


                while(count>0)
                {
                    ArrayList<String> tempList = null;

                    breakloop:
                    for(ArrayList<String> route: routeList)
                    {
                        if(route.get(route.size()-1).equalsIgnoreCase(current.getId())) {
                            tempList = new ArrayList<String>(route);
                            break breakloop;
                        }
                    }
                    routeList.add(tempList);
                    //debug print
                    System.out.println("copied list");
                    count--;
                }

                for(String cp: tempCPList)
                {
                    breakloop:
                    for(ArrayList<String> route: routeList)
                    {
                        if(route.get(route.size()-1).equalsIgnoreCase(current.getId()))
                        {
                            boolean append = false;
                            if(route.size() > 1)
                            {
                                append = route.get(route.size() - 2).equalsIgnoreCase(this.previousCurrent);
                            }else
                            {
                                append = true;
                            }
                            if(append)
                            {
                                {
                                    route.add(cp);
                                    //debug print
                                    System.out.println("routed new points");

                                    break breakloop;
                                }
                            }
                        }



                    }
                }
                breakloop:
                for(ArrayList<String> route: routeList)
                {
                    if(!route.get(route.size()-1).equalsIgnoreCase(this.getDestPoint()))
                    {
                        finish = false;
                        //debug print
                        System.out.println("checked for completion");
                        break breakloop;
                    }
                }
                tempCPList.clear();
                //remove duplicated routes
                for(int i = 0; i < routeList.size(); i++)
                {
                    int contain = 0;
                    breakloop:
                    for(int j = 0; j < routeList.size(); j++)
                    {
                        if(j != i)
                        {
                            contain = 0;
                            for(String s: routeList.get(i))
                            {
                                if(routeList.get(j).contains(s))
                                {
                                    contain++;
                                }
                            }
                            int size = routeList.get(i).size();
                            String dest = this.getDestPoint();
                            String lastString = routeList.get(i).get(routeList.get(i).size() - 1);
                            boolean remove = contain == routeList.get(i).size() && !routeList.get(i).get(routeList.get(i).size() -1).equalsIgnoreCase(this.getDestPoint());
                            if(remove)
                            {
                                routeList.remove(i);
                                i--;
                                contain = 0;
                                break breakloop;
                            }

                        }
                    }
                }



            }while(finish == false);


//        for(int i = 0; i < routeList.size(); i++)
//        {
//            int frequency = 0;
//            frequency = Collections.frequency(routeList, routeList.get(i));
//            while(frequency > 1)
//            {
//                int indexes[] = new int[frequency];
//                int count = 0;
//                for(int j = routeList.size()-1; j >=0; j--)
//                {
//                    if(routeList.get(j).equals(routeList.get(i)))
//                    {
//                        indexes[count] = j;
//                        count++;
//                    }
//                }
//                for(int j = 0; j < frequency-1; j++)
//                {
//                    routeList.remove(indexes[j]);
//                    frequency--;
//                }
//
//            }
//        }


            ArrayList<String> shortestRoute = getBestRoute(routeList);
            System.out.println("");
            System.out.println("The shortest route is : ");
            for(String a: shortestRoute)
            {
                System.out.print(a + ", ");
            }

            System.out.println("");
            this.setShortestList(shortestRoute);


            ArrayList<String> bestRoute = getBestRoute(routeList);
            System.out.print("");
            System.out.println("The best route is: ");
            for(String a: bestRoute)
            {
                System.out.print(a + ", ");
            }
            System.out.println("");

            this.setPointList(bestRoute);

            return this.getBestRoute(routeList);
            //compute distance and effort
        }
    }

    public static int[] computeDistanceAndEffort(String id1, String id2, ArrayList<Point> pointList)
    {
        int[] ints = new int[2];
        int diffX = 0, diffY = 0;
        breakloop:
        for(Point a: pointList)
        {
            if(a.getId().equalsIgnoreCase(id1))
            {
                for(Point b: pointList)
                {
                    if(b.getId().equalsIgnoreCase(id2))
                    {
                        diffX = (int)Math.abs(a.getOffX() - b.getOffX());
                        diffY = (int)Math.abs(a.getOffY() - b.getOffY());
                        //debug print
                        System.out.print(diffX + " : " + diffY + " : ");
                        break breakloop;
                    }
                }
            }
        }
        ints[0] = (int)Math.sqrt((diffX*diffX)+(diffY*diffY));
        int effort = 1;
        if((id1.equals("5") && id2.equals("7") || (id1.equals("7") && id2.equals("6"))))
        {
            effort = 20;
        }
        ints[1] = ints[0] * effort;
        return ints;
    }

    public ArrayList<String> getShortestRoute(ArrayList<ArrayList<String>> routeList, ArrayList<Point> pointList)
    {
        ArrayList<ArrayList<String>> debugList = routeList;
        ArrayList<String> shortestRoute = null;
        shortestRoute = getBestRoute(routeList);
        return shortestRoute;
    }

    public ArrayList<String> getBestRoute(ArrayList<ArrayList<String>> routeList, ArrayList<Point> pointList)
    {
        ArrayList<String> bestRoute = null;
        int totalEffort = 0;
        int lowestEffort = 0;
        int bestRouteIndex = 0;
        for(int j = 0; j < routeList.size(); j++)
        {
            for(int i = 0; i < routeList.get(j).size() - 1 ; i++)
            {
                int ints[] = Route.computeDistanceAndEffort(routeList.get(j).get(i), routeList.get(j).get(i+1), pointList);
                System.out.println(ints[0]);
                totalEffort += ints[1];
            }
            //debug print
            System.out.println("Effort: " + totalEffort);
            System.out.println("Lowest: " + lowestEffort);
            if(lowestEffort == 0)
            {
                lowestEffort = totalEffort;
                bestRouteIndex = j;
                totalEffort = 0;
            }else if(totalEffort < lowestEffort)
            {
                lowestEffort = totalEffort;
                bestRouteIndex = j;
                totalEffort = 0;
            }
        }
        bestRoute = routeList.get(bestRouteIndex);
        this.setTotalDistance(lowestEffort);
        return bestRoute;
    }

    public ArrayList<String> getAccessRoute(ArrayList<Point> pointList, ArrayList<Point> accessPointList, ArrayList<Point> accessBorderList, ArrayList<Point> universalPoints)
    {
        ArrayList<String> accessRoute = null;
        String nearestEntry = "";
        int leastDistance = 0;
        String nearestExit = "";

        ArrayList<Route> rtaList = new ArrayList<Route>();
        for(Point p: accessBorderList)
        {
            rtaList.add(new Route(this.getStartPoint(), p.getId()));

        }
        int leastRTA = 0;
        int shortIndex = -1;
        for(int i = 0; i < rtaList.size(); i++)
        {
            int routeSize = rtaList.get(i).setShortestRoute(pointList).size();
            if(shortIndex == -1)
            {
                shortIndex = i;
                leastRTA = rtaList.get(i).setShortestRoute(pointList).size();
                nearestEntry = rtaList.get(i).getDestPoint();
            }else if(routeSize < leastRTA)
            {
                shortIndex = i;
                leastRTA = rtaList.get(i).setShortestRoute(pointList).size();
                nearestEntry = rtaList.get(i).getDestPoint();
            }
        }
        ArrayList<Route> rfaList = new ArrayList<Route>();

        for(Point p: accessBorderList)
        {
            rfaList.add(new Route(p.getId(), this.getDestPoint()));
        }
        int outIndex = -1;
        int leastRFA = 0;
        for(int i = 0; i < rfaList.size(); i++)
        {
            int routeSize = rfaList.get(i).setShortestRoute(pointList).size();
            if(outIndex == -1)
            {
                outIndex = i;
                leastRFA = rfaList.get(i).setShortestRoute(pointList).size();
                nearestExit = rfaList.get(i).getStartPoint();

            }else if(routeSize < leastRFA)
            {
                outIndex = i;
                leastRFA = rfaList.get(i).setShortestRoute(pointList).size();
                nearestExit = rfaList.get(i).getStartPoint();
            }
        }
        ArrayList<String> tempRoute = new ArrayList<String>();

        Route tRoute = new Route(nearestEntry, nearestExit);
        for(String a: rtaList.get(shortIndex).getShortestList())
        {
            tempRoute.add(a);
        }
        tRoute.setShortestRoute(accessPointList);
        for(String a: tRoute.getShortestList())
        {
            if(!tempRoute.contains(a))
            {
                tempRoute.add(a);
            }
        }
        ArrayList<String> debugList = rfaList.get(outIndex).getShortestList();
        for(int i = 1; i < rfaList.get(outIndex).getShortestList().size(); i++)
        {
            tempRoute.add(rfaList.get(outIndex).getShortestList().get(i));
        }


        accessRoute = tempRoute;
        System.out.println("Test Access Route: ");
        this.setAccessList(accessRoute);
        for(String a: this.getAccessList())
        {
            System.out.print(a + ", ");
        }




        return accessRoute;
    }

    public boolean isReverse(ArrayList<Point> universalPoints, String id1, String id2, String id3)
    {
//        for(int i=0; i<universalPoints.size(); i++){
//            System.out.println("getoff X "+universalPoints.get(i).getOffX());
//        }
//        System.out.println("id1 "+id1);
//        System.out.println("id2 "+id2);
//        System.out.println("id3 "+id3);

        boolean reverse = false;
        Point point1 = null, point2 = null, point3 = null;
        for(Point p: universalPoints)
        {

            Point debugPoint = p;
            if(p.getId().equalsIgnoreCase(id1))
            {
                point1 = p;System.out.println("point 1" + point1);
            }
            if(p.getId().equalsIgnoreCase(id2))
            {
                point2 = p;System.out.println("point 2" + point2);
            }
            if(p.getId().equalsIgnoreCase(id3))
            {
                point3 = p;System.out.println("point 3" + point3);
            }
        }
        char direction1 = 0;
        if((point1.getOffX() - point2.getOffX() == 0) && (point1.getOffY() - point2.getOffY() > 0))
        {
            direction1 = 'N';
        }else if((point1.getOffX() - point2.getOffX() == 0) && (point1.getOffY() - point2.getOffY() < 0))
        {
            direction1 = 'S';
        }else if((point1.getOffX() - point2.getOffX() > 0) && (point1.getOffY() - point2.getOffY() == 0))
        {
            direction1 = 'E';
        }else if((point1.getOffX() - point2.getOffX() < 0) && (point1.getOffY() - point2.getOffY() == 0))
        {
            direction1 = 'W';
        }
        char direction2 = 0;
        if((point3.getOffX() - point1.getOffX() == 0) && (point3.getOffY() - point1.getOffY() > 0))
        {
            direction2 = 'N';
        }else if((point3.getOffX() - point1.getOffX() == 0) && (point3.getOffY() - point1.getOffY() < 0))
        {
            direction2 = 'S';
        }else if((point3.getOffX() - point1.getOffX() > 0) && (point3.getOffY() - point1.getOffY() == 0))
        {
            direction2 = 'E';
        }else if((point3.getOffX() - point1.getOffX() < 0) && (point3.getOffY() - point1.getOffY() == 0))
        {
            direction2 = 'W';
        }
        char dirs1[] = "NSEW".toCharArray();
        char dirs2[] = "SNWE".toCharArray();
        for(int i = 0; i < dirs1.length; i++)
        {
            if(direction1 == dirs1[i] && direction2 == dirs2[i])
            {
                reverse = true;
            }
        }
        return reverse;
    }


    public static ArrayList<String> getBestRoute(ArrayList<ArrayList<String>> routeList)
    {
        int smallest = routeList.get(0).size();
        int index = 0;
        for(int i = 0; i < routeList.size(); i++)
        {
            if(routeList.get(i).size() < smallest)
            {
                smallest = routeList.get(i).size();
                index = i;
            }
        }
        return routeList.get(index);
    }
}
