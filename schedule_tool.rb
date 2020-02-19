# Create new feature that arranges meetings in 8 hour day
# If meetings cannot fit, let user know "No, can't fit"
# 2 kinds of meetings: onsite/offsite
# onsite: can be back to back w/o gaps
# offsite: 	-30 min buffer on either end (travel time)
# 			    -can overlap off-site meetings
# 			    -can extends past Start/End of Day

#INPUT example 1:
# {
	# {name: "Meeting 1", duration: 3, type: :onsite},
	# {name: "Meeting 2", duration: 2, type: :offsite},
	# {name: "Meeting 3", duration: 1, type: :offsite},
	# {name: "Meeting 4", duration: 0.5, type: :onsite}
# }

# OUTPUT example 1:
# 	9:00-12:00 - Meeting 1
# 	12:00-12:30 - Meeting 4
# 	1:00-3:00 - Meeting 2
# 	3:30-4:30 -Meeting 3

# INPUT example 2:
# {
# 	{ name: “Meeting 1”, duration: 4, type: :offsite },
# 	{ name: “Meeting 2”, duration: 4, type: :offsite }
# }

# OUTPUT example 2:
# No, can’t fit.

