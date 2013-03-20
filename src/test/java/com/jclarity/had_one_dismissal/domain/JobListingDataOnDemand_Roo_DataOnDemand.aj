// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.jclarity.had_one_dismissal.domain;

import com.jclarity.had_one_dismissal.domain.CompanyDataOnDemand;
import com.jclarity.had_one_dismissal.domain.JobListing;
import com.jclarity.had_one_dismissal.domain.JobListingDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect JobListingDataOnDemand_Roo_DataOnDemand {
    
    declare @type: JobListingDataOnDemand: @Component;
    
    private Random JobListingDataOnDemand.rnd = new SecureRandom();
    
    private List<JobListing> JobListingDataOnDemand.data;
    
    @Autowired
    CompanyDataOnDemand JobListingDataOnDemand.companyDataOnDemand;
    
    public JobListing JobListingDataOnDemand.getNewTransientJobListing(int index) {
        JobListing obj = new JobListing();
        setDescription(obj, index);
        setPostedAt(obj, index);
        setSalaryLowerBound(obj, index);
        setSalaryUpperBound(obj, index);
        setTitle(obj, index);
        return obj;
    }
    
    public void JobListingDataOnDemand.setDescription(JobListing obj, int index) {
        String description = "description_" + index;
        obj.setDescription(description);
    }
    
    public void JobListingDataOnDemand.setPostedAt(JobListing obj, int index) {
        Date postedAt = new GregorianCalendar(Calendar.getInstance().get(Calendar.YEAR), Calendar.getInstance().get(Calendar.MONTH), Calendar.getInstance().get(Calendar.DAY_OF_MONTH), Calendar.getInstance().get(Calendar.HOUR_OF_DAY), Calendar.getInstance().get(Calendar.MINUTE), Calendar.getInstance().get(Calendar.SECOND) + new Double(Math.random() * 1000).intValue()).getTime();
        obj.setPostedAt(postedAt);
    }
    
    public void JobListingDataOnDemand.setSalaryLowerBound(JobListing obj, int index) {
        int salaryLowerBound = index;
        obj.setSalaryLowerBound(salaryLowerBound);
    }
    
    public void JobListingDataOnDemand.setSalaryUpperBound(JobListing obj, int index) {
        int salaryUpperBound = index;
        obj.setSalaryUpperBound(salaryUpperBound);
    }
    
    public void JobListingDataOnDemand.setTitle(JobListing obj, int index) {
        String title = "title_" + index;
        obj.setTitle(title);
    }
    
    public JobListing JobListingDataOnDemand.getSpecificJobListing(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        JobListing obj = data.get(index);
        Long id = obj.getId();
        return JobListing.findJobListing(id);
    }
    
    public JobListing JobListingDataOnDemand.getRandomJobListing() {
        init();
        JobListing obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return JobListing.findJobListing(id);
    }
    
    public boolean JobListingDataOnDemand.modifyJobListing(JobListing obj) {
        return false;
    }
    
    public void JobListingDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = JobListing.findJobListingEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'JobListing' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<JobListing>();
        for (int i = 0; i < 10; i++) {
            JobListing obj = getNewTransientJobListing(i);
            try {
                obj.persist();
            } catch (ConstraintViolationException e) {
                StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getConstraintDescriptor()).append(":").append(cv.getMessage()).append("=").append(cv.getInvalidValue()).append("]");
                }
                throw new RuntimeException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}
