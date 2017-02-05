package diabetesModel;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
/**
 * Created by Owner on 1/28/2017.
 */
@Entity
@Table(name = "memo", schema = "jedp", catalog = "")
public class MemoEntity {
    private int id;
    private String memoDateTime;
    private String content;
    private String authorName;
    private String identity;
    private String projectId;

    @Id
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "memoDateTime", nullable = true, length = 45)
    public String getMemoDateTime() {
        return memoDateTime;
    }

    public void setMemoDateTime(String memoDateTime) {
        this.memoDateTime = memoDateTime;
    }

    @Basic
    @Column(name = "content", nullable = true, length = 3000)
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Basic
    @Column(name = "authorName", nullable = true, length = 45)
    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    @Basic
    @Column(name = "identity", nullable = true, length = 45)
    public String getIdentity() {
        return identity;
    }

    public void setIdentity(String identity) {
        this.identity = identity;
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

        MemoEntity that = (MemoEntity) o;

        if (id != that.id) return false;
        if (memoDateTime != null ? !memoDateTime.equals(that.memoDateTime) : that.memoDateTime != null) return false;
        if (content != null ? !content.equals(that.content) : that.content != null) return false;
        if (authorName != null ? !authorName.equals(that.authorName) : that.authorName != null) return false;
        if (identity != null ? !identity.equals(that.identity) : that.identity != null) return false;
        if (projectId != null ? !projectId.equals(that.projectId) : that.projectId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (memoDateTime != null ? memoDateTime.hashCode() : 0);
        result = 31 * result + (content != null ? content.hashCode() : 0);
        result = 31 * result + (authorName != null ? authorName.hashCode() : 0);
        result = 31 * result + (identity != null ? identity.hashCode() : 0);
        result = 31 * result + (projectId != null ? projectId.hashCode() : 0);
        return result;
    }
}
