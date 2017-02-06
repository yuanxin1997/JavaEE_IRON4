package WayfinderModel;

/**
 * Created by admin on 12/13/2016.
 */
public class Path {
    String id;
    String parentA;
    String parentB;
    boolean accessibility;
    boolean availability;
    String description;

    public Path(String id, String parentA, String parentB, boolean accessibility, boolean availability, String description) {
        this.id = id;
        this.parentA = parentA;
        this.parentB = parentB;
        this.accessibility = accessibility;
        this.availability = availability;
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getParentA() {
        return parentA;
    }

    public void setParentA(String parentA) {
        this.parentA = parentA;
    }

    public String getParentB() {
        return parentB;
    }

    public void setParentB(String parentB) {
        this.parentB = parentB;
    }

    public boolean isAccessibility() {
        return accessibility;
    }

    public void setAccessibility(boolean accessibility) {
        this.accessibility = accessibility;
    }

    public boolean isAvailability() {
        return availability;
    }

    public void setAvailability(boolean availability) {
        this.availability = availability;
    }

}
