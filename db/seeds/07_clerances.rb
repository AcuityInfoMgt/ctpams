if Clearance.count == 0

  proj = Project.find_by old_id: 1
  c = Clearance.create(name: 'Proposal Submitted', clearance_status: 2, clearance_date: '2011-11-18')
  c.clearable = proj
  c.save
  c = Clearance.create(name: 'Proposal Pre-legal Cleared', clearance_status: 2, clearance_date: '2012-01-04')
  c.clearable = proj
  c.save
  c = Clearance.create(name: 'Proposal Approved', clearance_status: 2, clearance_date: '2012-01-04')
  c.clearable = proj
  c.save
  c = Clearance.create(name: 'Project CN Cleared', clearance_status: 2, clearance_date: '2012-01-04')
  c.clearable = proj
  c.save
  c = Clearance.create(name: 'Project Funding Approved', clearance_status: 2, clearance_date: '2011-08-20')
  c.clearable = proj
  c.save
  c = Clearance.create(name: 'Project Fully Obligated', clearance_status: 2, clearance_date: '2012-01-04')
  c.clearable = proj
  c.save

  proj = Project.find_by old_id: 2
  c = Clearance.create(name: 'Proposal Submitted', clearance_status: 2, clearance_date: '2011-11-14')
  c.clearable = proj
  c.save
  c = Clearance.create(name: 'Proposal Pre-legal Cleared', clearance_status: 2, clearance_date: '2011-11-14')
  c.clearable = proj
  c.save
  c = Clearance.create(name: 'Proposal Approved', clearance_status: 2, clearance_date: '2012-07-25')
  c.clearable = proj
  c.save
  c = Clearance.create(name: 'Project CN Cleared', clearance_status: 2, clearance_date: '2012-09-19')
  c.clearable = proj
  c.save
  c = Clearance.create(name: 'Project Funding Approved', clearance_status: 2, clearance_date: '2012-09-26')
  c.clearable = proj
  c.save
  c = Clearance.create(name: 'Project Fully Obligated', clearance_status: 2, clearance_date: '2012-11-02')
  c.clearable = proj
  c.save

end