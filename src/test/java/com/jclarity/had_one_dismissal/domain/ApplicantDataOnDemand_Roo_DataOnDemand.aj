// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.jclarity.had_one_dismissal.domain;

import com.jclarity.had_one_dismissal.domain.Applicant;
import com.jclarity.had_one_dismissal.domain.ApplicantDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.stereotype.Component;

privileged aspect ApplicantDataOnDemand_Roo_DataOnDemand {
    
    declare @type: ApplicantDataOnDemand: @Component;
    
    private Random ApplicantDataOnDemand.rnd = new SecureRandom();
    
    private List<Applicant> ApplicantDataOnDemand.data;
    
    public Applicant ApplicantDataOnDemand.getNewTransientApplicant(int index) {
        Applicant obj = new Applicant();
        setForename(obj, index);
        setSurname(obj, index);
        setYearsExperience(obj, index);
        return obj;
    }
    
    public void ApplicantDataOnDemand.setForename(Applicant obj, int index) {
        String forename = "forename_" + index;
        obj.setForename(forename);
    }
    
    public void ApplicantDataOnDemand.setSurname(Applicant obj, int index) {
        String surname = "surname_" + index;
        obj.setSurname(surname);
    }
    
    public void ApplicantDataOnDemand.setYearsExperience(Applicant obj, int index) {
        int yearsExperience = index;
        obj.setYearsExperience(yearsExperience);
    }
    
    public Applicant ApplicantDataOnDemand.getSpecificApplicant(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Applicant obj = data.get(index);
        Long id = obj.getId();
        return Applicant.findApplicant(id);
    }
    
    public Applicant ApplicantDataOnDemand.getRandomApplicant() {
        init();
        Applicant obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return Applicant.findApplicant(id);
    }
    
    public boolean ApplicantDataOnDemand.modifyApplicant(Applicant obj) {
        return false;
    }
    
    public void ApplicantDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Applicant.findApplicantEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Applicant' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Applicant>();
        for (int i = 0; i < 10; i++) {
            Applicant obj = getNewTransientApplicant(i);
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
