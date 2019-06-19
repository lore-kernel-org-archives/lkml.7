Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9302C31E5D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98771206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfFSMuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:50:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727134AbfFSMup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:50:45 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JCkYo3043026
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:50:43 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t7m2p4kee-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:50:42 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 19 Jun 2019 13:50:42 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Jun 2019 13:50:39 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5JCocin24314322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 12:50:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B17BB2065;
        Wed, 19 Jun 2019 12:50:38 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55851B206A;
        Wed, 19 Jun 2019 12:50:38 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.196.99])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jun 2019 12:50:38 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C5A6D16C5D91; Wed, 19 Jun 2019 05:50:38 -0700 (PDT)
Date:   Wed, 19 Jun 2019 05:50:38 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     mingo@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        benbjiang@tencent.com, zhenzhong.duan@oracle.com,
        neeraju@codeaurora.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, oleg@redhat.com
Subject: Re: [GIT PULL rcu/next] RCU commits for 5.3
Reply-To: paulmck@linux.ibm.com
References: <20190618180742.GA8043@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618180742.GA8043@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19061912-0052-0000-0000-000003D2C597
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011290; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01220220; UDB=6.00641886; IPR=6.01001362;
 MB=3.00027374; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-19 12:50:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061912-0053-0000-0000-000061614843
Message-Id: <20190619125038.GA8922@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906190106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 11:07:42AM -0700, Paul E. McKenney wrote:
> Hello, Ingo,
> 
> This pull request contains the following changes:

Gah!!!  This one has some duplicated commits, so please ignore.
I will send an updated pull request early next week.

It is functionally correct, but...

One of those weeks, I guess.  :-/

							Thanx, Paul

> 1.	Yet another round of flavor-consolidation cleanups.
> 
> 	http://lkml.kernel.org/r/20190530145204.GA28526@linux.ibm.com
> 
> 2.	Documentation updates.
> 
> 	http://lkml.kernel.org/r/20190530145504.GA29820@linux.ibm.com
> 
> 3.	Miscellaneous fixes.
> 
> 	http://lkml.kernel.org/r/20190530145942.GA30318@linux.ibm.com
> 
> 4.	SRCU updates.
> 
> 	http://lkml.kernel.org/r/20190530150347.GA31311@linux.ibm.com
> 
> 5.	RCU-sync updates.
> 
> 	http://lkml.kernel.org/r/20190530150816.GA32130@linux.ibm.com
> 
> 6.	Torture-test updates.
> 
> 	http://lkml.kernel.org/r/20190530151650.GA422@linux.ibm.com
> 
> This pull request does not contain LKMM updates, which will be the
> subject of a later pull request.  (Apologies for the hassle, but there
> is still work in progress on handling plain assignment statements.)
> 
> All of these changes have been subjected to 0day Test Robot and -next
> testing, and are available in the Git repository at:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo
> 
> for you to fetch changes up to 8bec773060bd068bddc1014d25a7d16ac84c4fd4:
> 
>   Merge branches 'consolidate.2019.05.28a', 'doc.2019.05.28a', 'fixes.2019.06.13a', 'fixes.2019.05.28a', 'srcu.2019.05.28a', 'sync.2019.05.28a' and 'torture.2019.05.28a' into HEAD (2019-06-13 15:39:55 -0700)
> 
> ----------------------------------------------------------------
> Andrea Parri (2):
>       rcu: Don't return a value from rcu_assign_pointer()
>       rcu: Don't return a value from rcu_assign_pointer()
> 
> Jiang Biao (2):
>       rcu: Remove unused rdp local from synchronize_rcu_expedited()
>       rcu: Make __call_srcu static
> 
> Joel Fernandes (Google) (7):
>       lockdep: Add assertion to check if in an interrupt
>       rcu: Add checks for dynticks counters in rcu_is_cpu_rrupt_from_idle()
>       doc/rcuref: Document real world examples in kernel
>       srcu: Remove unused vmlinux srcu linker entries
>       module: Make srcu_struct ptr array as read-only
>       rcutorture: Select from only online CPUs
>       rcutorture: Add cpu0 to the set of CPUs to add jitter
> 
> Neeraj Upadhyay (2):
>       rcu: Dump specified number of blocked tasks
>       rcu: Correctly unlock root node in rcu_check_gp_start_stall()
> 
> Oleg Nesterov (4):
>       rcu/sync: Kill rcu_sync_type/gp_type
>       uprobes: Use DEFINE_STATIC_PERCPU_RWSEM() to initialize dup_mmap_sem
>       locking/percpu-rwsem: Add DEFINE_PERCPU_RWSEM(), use it to initialize cgroup_threadgroup_rwsem
>       rcu/sync: Simplify the state machine
> 
> Paul E. McKenney (35):
>       rcu: Check for wakeup-safe conditions in rcu_read_unlock_special()
>       rcu: Only do rcu_read_unlock_special() wakeups if expedited
>       rcu: Allow rcu_read_unlock_special() to raise_softirq() if in_irq()
>       rcu: Use irq_work to get scheduler's attention in clean context
>       rcu: Inline invoke_rcu_callbacks() into its sole remaining caller
>       rcu: Avoid self-IPI in sync_rcu_exp_select_node_cpus()
>       rcu: Avoid self-IPI in sync_sched_exp_online_cleanup()
>       rcu: Rename rcu_data's ->deferred_qs to ->exp_deferred_qs
>       rcu: Upgrade sync_exp_work_done() to smp_mb()
>       rcu: Make kfree_rcu() ignore NULL pointers
>       rcu: Fix irritating whitespace error in rcu_assign_pointer()
>       rcu: Set a maximum limit for back-to-back callback invocation
>       doc: Remove ".vnet" from paulmck email addresses
>       srcu: Allocate per-CPU data for DEFINE_SRCU() in modules
>       rcutorture: Add cond_resched() to forward-progress free-up loop
>       rcutorture: Fix stutter_wait() return value and freelist checks
>       torture: Allow inter-stutter interval to be specified
>       torture: Make kvm-find-errors.sh and kvm-recheck.sh provide exit status
>       rcutorture: Provide rudimentary Makefile
>       rcutorture: Exempt tasks RCU from timely draining of grace periods
>       rcutorture: Exempt TREE01 from forward-progress testing
>       rcutorture: Give the scheduler a chance on PREEMPT && NO_HZ_FULL kernels
>       rcutorture: Halt forward-progress checks at end of run
>       rcutorture: Add trivial RCU implementation
>       torture: Capture qemu output
>       torture: Add function graph-tracing cheat sheet
>       torture: Run kernel build in source directory
>       torture: Make --cpus override idleness calculations
>       torture: Add --trust-make to suppress "make clean"
>       rcutorture: Dump trace buffer for callback pipe drain failures
>       torture: Suppress propagating trace_printk() warning
>       rcutorture: Upper case solves the case of the vanishing NULL pointer
>       rcu: Upgrade sync_exp_work_done() to smp_mb()
>       rcu: Fix irritating whitespace error in rcu_assign_pointer()
>       Merge branches 'consolidate.2019.05.28a', 'doc.2019.05.28a', 'fixes.2019.06.13a', 'fixes.2019.05.28a', 'srcu.2019.05.28a', 'sync.2019.05.28a' and 'torture.2019.05.28a' into HEAD
> 
> Sebastian Andrzej Siewior (2):
>       rcu: Enable elimination of Tree-RCU softirq processing
>       rcutorture: Tweak kvm options
> 
> Waiman Long (2):
>       rcu: Force inlining of rcu_read_lock()
>       rcu: Force inlining of rcu_read_lock()
> 
> Zhenzhong Duan (1):
>       doc: Fixup definition of rcupdate.rcu_task_stall_timeout
> 
>  Documentation/RCU/rcuref.txt                       |  21 +-
>  Documentation/RCU/stallwarn.txt                    |   2 +-
>  Documentation/RCU/whatisRCU.txt                    |   8 +-
>  Documentation/admin-guide/kernel-parameters.txt    |   6 +
>  Documentation/core-api/circular-buffers.rst        |   2 +-
>  Documentation/memory-barriers.txt                  |   2 +-
>  .../translations/ko_KR/memory-barriers.txt         |   2 +-
>  include/linux/lockdep.h                            |   7 +
>  include/linux/module.h                             |   5 +
>  include/linux/percpu-rwsem.h                       |  10 +-
>  include/linux/rcu_sync.h                           |  40 ++--
>  include/linux/rcupdate.h                           |  21 +-
>  include/linux/sched.h                              |   2 +-
>  include/linux/srcutree.h                           |  14 +-
>  include/linux/torture.h                            |   2 +-
>  kernel/cgroup/cgroup.c                             |   3 +-
>  kernel/events/uprobes.c                            |   4 +-
>  kernel/locking/locktorture.c                       |   2 +-
>  kernel/locking/percpu-rwsem.c                      |   2 +-
>  kernel/module.c                                    |   5 +
>  kernel/rcu/rcu.h                                   |   5 +
>  kernel/rcu/rcutorture.c                            |  96 +++++++--
>  kernel/rcu/srcutree.c                              |  69 ++++++-
>  kernel/rcu/sync.c                                  | 214 ++++++++++-----------
>  kernel/rcu/tree.c                                  | 164 +++++++++++++---
>  kernel/rcu/tree.h                                  |   6 +-
>  kernel/rcu/tree_exp.h                              |  53 +++--
>  kernel/rcu/tree_plugin.h                           | 195 ++++++-------------
>  kernel/rcu/tree_stall.h                            |   4 +-
>  kernel/rcu/update.c                                |  13 ++
>  kernel/torture.c                                   |  23 ++-
>  tools/include/linux/rcu.h                          |   4 +-
>  tools/testing/radix-tree/linux/rcupdate.h          |   2 +-
>  tools/testing/selftests/rcutorture/Makefile        |   3 +
>  .../testing/selftests/rcutorture/bin/configinit.sh |  39 ++--
>  tools/testing/selftests/rcutorture/bin/cpus2use.sh |   5 +
>  .../testing/selftests/rcutorture/bin/functions.sh  |  13 +-
>  tools/testing/selftests/rcutorture/bin/jitter.sh   |  13 +-
>  .../testing/selftests/rcutorture/bin/kvm-build.sh  |   9 +-
>  .../selftests/rcutorture/bin/kvm-find-errors.sh    |   3 +
>  .../selftests/rcutorture/bin/kvm-recheck.sh        |  13 +-
>  .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  23 +--
>  tools/testing/selftests/rcutorture/bin/kvm.sh      |  14 +-
>  .../selftests/rcutorture/bin/parse-build.sh        |   2 +-
>  .../selftests/rcutorture/bin/parse-console.sh      |   1 +
>  .../selftests/rcutorture/configs/rcu/CFcommon      |   3 +
>  .../selftests/rcutorture/configs/rcu/TREE01.boot   |   1 +
>  .../selftests/rcutorture/configs/rcu/TRIVIAL       |  14 ++
>  .../selftests/rcutorture/configs/rcu/TRIVIAL.boot  |   3 +
>  49 files changed, 736 insertions(+), 431 deletions(-)
>  create mode 100644 tools/testing/selftests/rcutorture/Makefile
>  create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
>  create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL.boot

