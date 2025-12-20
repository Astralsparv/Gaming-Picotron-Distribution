--[[pod_format="raw",created="2025-12-20 06:21:03",modified="2025-12-20 06:21:03",revision=0]]

-- send a message to process manager
send_message(2, {event="kill_process", proc_id = tonum(env().argv[1])})
