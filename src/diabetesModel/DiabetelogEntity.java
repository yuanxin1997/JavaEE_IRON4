package diabetesModel;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
/**
 * Created by Owner on 1/28/2017.
 */
@Entity
@Table(name = "diabetelog", schema = "jedp", catalog = "")
public class DiabetelogEntity {
    private int id;
    private String trackDate;
    private String trackTime;
    private Integer glucoseLevel;
    private String notes;
    private String projectId;

    public  DiabetelogEntity(){};

    public DiabetelogEntity(String trackDate, Integer glucoseLevel) {
        this.trackDate = trackDate;
        this.glucoseLevel = glucoseLevel;
    }

    @Id
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "trackDate", nullable = true, length = 45)
    public String getTrackDate() {
        return trackDate;
    }

    public void setTrackDate(String trackDate) {
        this.trackDate = trackDate;
    }

    @Basic
    @Column(name = "trackTime", nullable = true, length = 45)
    public String getTrackTime() {
        return trackTime;
    }

    public void setTrackTime(String trackTime) {
        this.trackTime = trackTime;
    }

    @Basic
    @Column(name = "glucoseLevel", nullable = true)
    public Integer getGlucoseLevel() {
        return glucoseLevel;
    }

    public void setGlucoseLevel(Integer glucoseLevel) {
        this.glucoseLevel = glucoseLevel;
    }

    @Basic
    @Column(name = "notes", nullable = true, length = 45)
    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    @Basic
    @Column(name = "projectId", nullable = true, length = 45)
    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DiabetelogEntity that = (DiabetelogEntity) o;

        if (id != that.id) return false;
        if (trackDate != null ? !trackDate.equals(that.trackDate) : that.trackDate != null) return false;
        if (trackTime != null ? !trackTime.equals(that.trackTime) : that.trackTime != null) return false;
        if (glucoseLevel != null ? !glucoseLevel.equals(that.glucoseLevel) : that.glucoseLevel != null) return false;
        if (notes != null ? !notes.equals(that.notes) : that.notes != null) return false;
        if (projectId != null ? !projectId.equals(that.projectId) : that.projectId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (trackDate != null ? trackDate.hashCode() : 0);
        result = 31 * result + (trackTime != null ? trackTime.hashCode() : 0);
        result = 31 * result + (glucoseLevel != null ? glucoseLevel.hashCode() : 0);
        result = 31 * result + (notes != null ? notes.hashCode() : 0);
        result = 31 * result + (projectId != null ? projectId.hashCode() : 0);
        return result;
    }
}
