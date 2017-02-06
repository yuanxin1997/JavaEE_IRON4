package WayfinderModel;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDateTime;

/**
 * Created by admin on 12/13/2016.
 */
public class Feedback {
    String id;
    String name;
    String waypointId;
    boolean crit;
    int type;
    Date date;
    Time time;

    public Feedback(String id, String name, String waypointId, boolean crit, int type, Date date, Time time) {
        this.id = id;
        this.name = name;
        this.waypointId = waypointId;
        this.crit = crit;
        this.type = type;
        this.date = date;
        this.time = time;
    }

    public Time getTime() {
        return time;
    }

    public void setTime(Time time) {
        this.time = time;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getWaypointId() {
        return waypointId;
    }

    public void setWaypointId(String waypointId) {
        this.waypointId = waypointId;
    }

    public boolean getCrit() {
        return crit;
    }

    public void setCrit(boolean crit) {
        this.crit = crit;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
