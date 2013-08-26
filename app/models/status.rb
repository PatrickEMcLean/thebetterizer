class Status
  def self.all
    {
      created_not_authorized: "Created - Awaiting Payment",
      authorized: "Paid",
      in_progress: "Work has begun",
      coaching_complete: "Coaching Complete",
      administrative_review: "Dotting I's and Crossing T's",
      approved: "Approved",
      payment_pending: "Payment Pending",
      paid: "Paid",
      delivered: "Delivered",
      student_feedback_complete: "Feedback Complete",
      complete: "Complete"
    }.with_indifferent_access
  end

  def self.labelize key
    self.all[key]
  end

end
