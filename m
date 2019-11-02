Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C9BCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3EC20862
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfKBKXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 06:23:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726163AbfKBKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:23:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA2A7xEg100511
        for <linux-kernel@vger.kernel.org>; Sat, 2 Nov 2019 06:23:47 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w12qs7hft-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 06:23:47 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Sat, 2 Nov 2019 10:23:46 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 2 Nov 2019 10:23:44 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA2ANgGa38142360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 2 Nov 2019 10:23:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB4F7A4051;
        Sat,  2 Nov 2019 10:23:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BDCDA4040;
        Sat,  2 Nov 2019 10:23:42 +0000 (GMT)
Received: from localhost (unknown [9.145.64.238])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  2 Nov 2019 10:23:42 +0000 (GMT)
Date:   Sat, 2 Nov 2019 11:23:40 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.4-rc6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
x-cbid: 19110210-0028-0000-0000-000003B2032F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110210-0029-0000-0000-0000247452C5
Message-Id: <your-ad-here.call-01572690220-ext-8522@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911020099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.4-rc6.

Thank you,
Vasily

The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-6

for you to fetch changes up to 3d7efa4edd07be5c5c3ffa95ba63e97e070e1f3f:

  s390/idle: fix cpu idle time calculation (2019-10-31 17:26:48 +0100)

----------------------------------------------------------------
s390 updates for 5.4-rc6

- Fix cpu idle time accounting.

- Fix stack unwinder case when both pt_regs and sp are specified.

- Fix information leak via cmm timeout proc handler.

----------------------------------------------------------------
Heiko Carstens (1):
      s390/idle: fix cpu idle time calculation

Ilya Leoshkevich (1):
      s390/unwind: fix mixing regs and sp

Yihui ZENG (1):
      s390/cmm: fix information leak in cmm_timeout_handler()

 arch/s390/include/asm/unwind.h |  1 +
 arch/s390/kernel/idle.c        | 29 ++++++++++++++++++++++-------
 arch/s390/kernel/unwind_bc.c   | 18 +++++++++++++-----
 arch/s390/mm/cmm.c             | 12 ++++++------
 4 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/arch/s390/include/asm/unwind.h b/arch/s390/include/asm/unwind.h
index d827b5b9a32c..eaaefeceef6f 100644
--- a/arch/s390/include/asm/unwind.h
+++ b/arch/s390/include/asm/unwind.h
@@ -35,6 +35,7 @@ struct unwind_state {
 	struct task_struct *task;
 	struct pt_regs *regs;
 	unsigned long sp, ip;
+	bool reuse_sp;
 	int graph_idx;
 	bool reliable;
 	bool error;
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index b9d8fe45737a..8f8456816d83 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -69,18 +69,26 @@ DEVICE_ATTR(idle_count, 0444, show_idle_count, NULL);
 static ssize_t show_idle_time(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
+	unsigned long long now, idle_time, idle_enter, idle_exit, in_idle;
 	struct s390_idle_data *idle = &per_cpu(s390_idle, dev->id);
-	unsigned long long now, idle_time, idle_enter, idle_exit;
 	unsigned int seq;
 
 	do {
-		now = get_tod_clock();
 		seq = read_seqcount_begin(&idle->seqcount);
 		idle_time = READ_ONCE(idle->idle_time);
 		idle_enter = READ_ONCE(idle->clock_idle_enter);
 		idle_exit = READ_ONCE(idle->clock_idle_exit);
 	} while (read_seqcount_retry(&idle->seqcount, seq));
-	idle_time += idle_enter ? ((idle_exit ? : now) - idle_enter) : 0;
+	in_idle = 0;
+	now = get_tod_clock();
+	if (idle_enter) {
+		if (idle_exit) {
+			in_idle = idle_exit - idle_enter;
+		} else if (now > idle_enter) {
+			in_idle = now - idle_enter;
+		}
+	}
+	idle_time += in_idle;
 	return sprintf(buf, "%llu\n", idle_time >> 12);
 }
 DEVICE_ATTR(idle_time_us, 0444, show_idle_time, NULL);
@@ -88,17 +96,24 @@ DEVICE_ATTR(idle_time_us, 0444, show_idle_time, NULL);
 u64 arch_cpu_idle_time(int cpu)
 {
 	struct s390_idle_data *idle = &per_cpu(s390_idle, cpu);
-	unsigned long long now, idle_enter, idle_exit;
+	unsigned long long now, idle_enter, idle_exit, in_idle;
 	unsigned int seq;
 
 	do {
-		now = get_tod_clock();
 		seq = read_seqcount_begin(&idle->seqcount);
 		idle_enter = READ_ONCE(idle->clock_idle_enter);
 		idle_exit = READ_ONCE(idle->clock_idle_exit);
 	} while (read_seqcount_retry(&idle->seqcount, seq));
-
-	return cputime_to_nsecs(idle_enter ? ((idle_exit ?: now) - idle_enter) : 0);
+	in_idle = 0;
+	now = get_tod_clock();
+	if (idle_enter) {
+		if (idle_exit) {
+			in_idle = idle_exit - idle_enter;
+		} else if (now > idle_enter) {
+			in_idle = now - idle_enter;
+		}
+	}
+	return cputime_to_nsecs(in_idle);
 }
 
 void arch_cpu_idle_enter(void)
diff --git a/arch/s390/kernel/unwind_bc.c b/arch/s390/kernel/unwind_bc.c
index 8fc9daae47a2..a8204f952315 100644
--- a/arch/s390/kernel/unwind_bc.c
+++ b/arch/s390/kernel/unwind_bc.c
@@ -46,10 +46,15 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	regs = state->regs;
 	if (unlikely(regs)) {
-		sp = READ_ONCE_NOCHECK(regs->gprs[15]);
-		if (unlikely(outside_of_stack(state, sp))) {
-			if (!update_stack_info(state, sp))
-				goto out_err;
+		if (state->reuse_sp) {
+			sp = state->sp;
+			state->reuse_sp = false;
+		} else {
+			sp = READ_ONCE_NOCHECK(regs->gprs[15]);
+			if (unlikely(outside_of_stack(state, sp))) {
+				if (!update_stack_info(state, sp))
+					goto out_err;
+			}
 		}
 		sf = (struct stack_frame *) sp;
 		ip = READ_ONCE_NOCHECK(sf->gprs[8]);
@@ -107,9 +112,9 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 {
 	struct stack_info *info = &state->stack_info;
 	unsigned long *mask = &state->stack_mask;
+	bool reliable, reuse_sp;
 	struct stack_frame *sf;
 	unsigned long ip;
-	bool reliable;
 
 	memset(state, 0, sizeof(*state));
 	state->task = task;
@@ -134,10 +139,12 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 	if (regs) {
 		ip = READ_ONCE_NOCHECK(regs->psw.addr);
 		reliable = true;
+		reuse_sp = true;
 	} else {
 		sf = (struct stack_frame *) sp;
 		ip = READ_ONCE_NOCHECK(sf->gprs[8]);
 		reliable = false;
+		reuse_sp = false;
 	}
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
@@ -151,5 +158,6 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 	state->sp = sp;
 	state->ip = ip;
 	state->reliable = reliable;
+	state->reuse_sp = reuse_sp;
 }
 EXPORT_SYMBOL_GPL(__unwind_start);
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 510a18299196..a51c892f14f3 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -298,16 +298,16 @@ static int cmm_timeout_handler(struct ctl_table *ctl, int write,
 	}
 
 	if (write) {
-		len = *lenp;
-		if (copy_from_user(buf, buffer,
-				   len > sizeof(buf) ? sizeof(buf) : len))
+		len = min(*lenp, sizeof(buf));
+		if (copy_from_user(buf, buffer, len))
 			return -EFAULT;
-		buf[sizeof(buf) - 1] = '\0';
+		buf[len - 1] = '\0';
 		cmm_skip_blanks(buf, &p);
 		nr = simple_strtoul(p, &p, 0);
 		cmm_skip_blanks(p, &p);
 		seconds = simple_strtoul(p, &p, 0);
 		cmm_set_timeout(nr, seconds);
+		*ppos += *lenp;
 	} else {
 		len = sprintf(buf, "%ld %ld\n",
 			      cmm_timeout_pages, cmm_timeout_seconds);
@@ -315,9 +315,9 @@ static int cmm_timeout_handler(struct ctl_table *ctl, int write,
 			len = *lenp;
 		if (copy_to_user(buffer, buf, len))
 			return -EFAULT;
+		*lenp = len;
+		*ppos += len;
 	}
-	*lenp = len;
-	*ppos += len;
 	return 0;
 }
 

