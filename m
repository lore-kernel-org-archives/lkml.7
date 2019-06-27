Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A12C5B576
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1124C208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfF0WUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:20:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726445AbfF0WUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:20:50 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RMHJ2a031424;
        Thu, 27 Jun 2019 18:19:54 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2td45hdtat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 18:19:53 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5RMJcw0000585;
        Thu, 27 Jun 2019 22:19:52 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 2t9by7hcxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 22:19:52 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RMJq8K50004430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 22:19:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09096B2064;
        Thu, 27 Jun 2019 22:19:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFFD2B205F;
        Thu, 27 Jun 2019 22:19:51 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 22:19:51 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2147F16C5D5C; Thu, 27 Jun 2019 15:19:54 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:19:54 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     mingo@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        benbjiang@tencent.com, joel@joelfernandes.org,
        neeraju@codeaurora.org, oleg@redhat.com, bigeasy@linutronix.de,
        longman@redhat.com, zhenzhong.duan@oracle.com
Subject: [GIT PULL rcu/next + tools/memory-model] RCU and LKMM commits for 5.3
Message-ID: <20190627221954.GA27221@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo,

This pull request contains the following changes:

1.	RCU flavor consolidation cleanups and optmizations.

	http://lkml.kernel.org/r/20190530145204.GA28526@linux.ibm.com

2.	Documentation updates.

	http://lkml.kernel.org/r/20190530145504.GA29820@linux.ibm.com

3.	Miscellaneous fixes.

	http://lkml.kernel.org/r/20190530145942.GA30318@linux.ibm.com

4.	SRCU updates.

	http://lkml.kernel.org/r/20190530150347.GA31311@linux.ibm.com

5.	RCU-sync flavor consolidation.

	http://lkml.kernel.org/r/20190530150816.GA32130@linux.ibm.com

6.	Torture-test updates.

	http://lkml.kernel.org/r/20190530151650.GA422@linux.ibm.com

7.	Linux-kernel memory-consistency-model updates, most notably
	the addition of plain C-language accesses.

	http://lkml.kernel.org/r/20190530144202.GA26201@linux.ibm.com
	http://lkml.kernel.org/r/Pine.LNX.4.44L0.1906201151210.1512-100000@iolanthe.rowland.org
	http://lkml.kernel.org/r/Pine.LNX.4.44L0.1906201152370.1512-100000@iolanthe.rowland.org
	http://lkml.kernel.org/r/Pine.LNX.4.44L0.1906201153470.1512-100000@iolanthe.rowland.org

	These last three were relatively late additions responding to
	LKML feedback.	However, the resulting memory model passes its
	rather large library of tests, and these changes are furthermore
	required to correctly model some tricky situations involving
	use of RCU without rcu_assign_pointer() and rcu_dereference().
	These tricky sequences are not theoretical in nature, but rather
	from fixes identified by Herbert Xu.  It therefore seems best
	to get these upstream sooner rather than later.

All of these changes have been subjected to 0day Test Robot and -next
testing, and are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to b989ff070574ad8b8621d866de0a8e9a65d42c80:

  Merge LKMM and RCU commits (2019-06-24 09:12:39 -0700)

These changes do increase the size of the kernel by about 300 lines.
About 150 of this was due largely to improvements in rcutorture's
forward-progress testing.  Not quite another 100 of this was due to
allowing Tree SRCU to be used from modules without needing to adjust the
size of the reserved region.  Not quite an additional 100 of this was for
cleanups after the RCU flavor consolidation effort, including accidentally
fixing a self-deadlock encountered by Sebastian Siewior when booting
with the threadirqs kernel parameter.  Finally, yet another not quite
100 of this was for adding LKMM's support for plain C-language accesses.
This totals to more than 300 because other changes removed code.

----------------------------------------------------------------
Alan Stern (7):
      tools/memory-model: Prepare for data-race detection
      tools/memory-model: Add definitions of plain and marked accesses
      tools/memory-model: Add data-race detection
      Documentation: atomic_t.txt: Explain ordering provided by smp_mb__{before,after}_atomic()
      tools/memory-model: Expand definition of barrier
      tools/memory-model: Change definition of rcu-fence
      tools/memory-model: Improve data-race detection

Andrea Parri (3):
      rcu: Don't return a value from rcu_assign_pointer()
      tools/memory-model: Fix comment in MP+poonceonces.litmus
      tools/memory-model: Do not use "herd" to refer to "herd7"

Jiang Biao (2):
      rcu: Remove unused rdp local from synchronize_rcu_expedited()
      rcu: Make __call_srcu static

Joel Fernandes (Google) (7):
      lockdep: Add assertion to check if in an interrupt
      rcu: Add checks for dynticks counters in rcu_is_cpu_rrupt_from_idle()
      doc/rcuref: Document real world examples in kernel
      srcu: Remove unused vmlinux srcu linker entries
      module: Make srcu_struct ptr array as read-only
      rcutorture: Select from only online CPUs
      rcutorture: Add cpu0 to the set of CPUs to add jitter

Neeraj Upadhyay (2):
      rcu: Dump specified number of blocked tasks
      rcu: Correctly unlock root node in rcu_check_gp_start_stall()

Oleg Nesterov (4):
      rcu/sync: Kill rcu_sync_type/gp_type
      uprobes: Use DEFINE_STATIC_PERCPU_RWSEM() to initialize dup_mmap_sem
      locking/percpu-rwsem: Add DEFINE_PERCPU_RWSEM(), use it to initialize cgroup_threadgroup_rwsem
      rcu/sync: Simplify the state machine

Paul E. McKenney (34):
      rcu: Check for wakeup-safe conditions in rcu_read_unlock_special()
      rcu: Only do rcu_read_unlock_special() wakeups if expedited
      rcu: Allow rcu_read_unlock_special() to raise_softirq() if in_irq()
      rcu: Use irq_work to get scheduler's attention in clean context
      rcu: Inline invoke_rcu_callbacks() into its sole remaining caller
      rcu: Avoid self-IPI in sync_rcu_exp_select_node_cpus()
      rcu: Avoid self-IPI in sync_sched_exp_online_cleanup()
      rcu: Rename rcu_data's ->deferred_qs to ->exp_deferred_qs
      rcu: Make kfree_rcu() ignore NULL pointers
      rcu: Set a maximum limit for back-to-back callback invocation
      doc: Remove ".vnet" from paulmck email addresses
      srcu: Allocate per-CPU data for DEFINE_SRCU() in modules
      rcutorture: Add cond_resched() to forward-progress free-up loop
      rcutorture: Fix stutter_wait() return value and freelist checks
      torture: Allow inter-stutter interval to be specified
      torture: Make kvm-find-errors.sh and kvm-recheck.sh provide exit status
      rcutorture: Provide rudimentary Makefile
      rcutorture: Exempt tasks RCU from timely draining of grace periods
      rcutorture: Exempt TREE01 from forward-progress testing
      rcutorture: Give the scheduler a chance on PREEMPT && NO_HZ_FULL kernels
      rcutorture: Halt forward-progress checks at end of run
      rcutorture: Add trivial RCU implementation
      torture: Capture qemu output
      torture: Add function graph-tracing cheat sheet
      torture: Run kernel build in source directory
      torture: Make --cpus override idleness calculations
      torture: Add --trust-make to suppress "make clean"
      rcutorture: Dump trace buffer for callback pipe drain failures
      torture: Suppress propagating trace_printk() warning
      rcutorture: Upper case solves the case of the vanishing NULL pointer
      rcu: Upgrade sync_exp_work_done() to smp_mb()
      rcu: Fix irritating whitespace error in rcu_assign_pointer()
      Merge branches 'consolidate.2019.05.28a', 'doc.2019.05.28a', 'fixes.2019.06.13a', 'srcu.2019.05.28a', 'sync.2019.05.28a' and 'torture.2019.05.28a' into HEAD
      Merge LKMM and RCU commits

Sebastian Andrzej Siewior (2):
      rcu: Enable elimination of Tree-RCU softirq processing
      rcutorture: Tweak kvm options

Waiman Long (1):
      rcu: Force inlining of rcu_read_lock()

Zhenzhong Duan (1):
      doc: Fixup definition of rcupdate.rcu_task_stall_timeout

 Documentation/RCU/rcuref.txt                       |  21 +-
 Documentation/RCU/stallwarn.txt                    |   2 +-
 Documentation/RCU/whatisRCU.txt                    |   8 +-
 Documentation/admin-guide/kernel-parameters.txt    |   6 +
 Documentation/atomic_t.txt                         |  17 +-
 Documentation/core-api/circular-buffers.rst        |   2 +-
 Documentation/memory-barriers.txt                  |   2 +-
 .../translations/ko_KR/memory-barriers.txt         |   2 +-
 include/linux/lockdep.h                            |   7 +
 include/linux/module.h                             |   5 +
 include/linux/percpu-rwsem.h                       |  10 +-
 include/linux/rcu_sync.h                           |  40 ++--
 include/linux/rcupdate.h                           |  21 +-
 include/linux/sched.h                              |   2 +-
 include/linux/srcutree.h                           |  14 +-
 include/linux/torture.h                            |   2 +-
 kernel/cgroup/cgroup.c                             |   3 +-
 kernel/events/uprobes.c                            |   4 +-
 kernel/locking/locktorture.c                       |   2 +-
 kernel/locking/percpu-rwsem.c                      |   2 +-
 kernel/module.c                                    |   5 +
 kernel/rcu/rcu.h                                   |   5 +
 kernel/rcu/rcutorture.c                            |  96 +++++++--
 kernel/rcu/srcutree.c                              |  69 ++++++-
 kernel/rcu/sync.c                                  | 214 ++++++++++-----------
 kernel/rcu/tree.c                                  | 164 +++++++++++++---
 kernel/rcu/tree.h                                  |   6 +-
 kernel/rcu/tree_exp.h                              |  53 +++--
 kernel/rcu/tree_plugin.h                           | 195 ++++++-------------
 kernel/rcu/tree_stall.h                            |   4 +-
 kernel/rcu/update.c                                |  13 ++
 kernel/torture.c                                   |  23 ++-
 tools/include/linux/rcu.h                          |   4 +-
 tools/memory-model/linux-kernel.bell               |   6 +
 tools/memory-model/linux-kernel.cat                | 102 +++++++---
 tools/memory-model/linux-kernel.def                |   1 +
 .../litmus-tests/MP+poonceonces.litmus             |   2 +-
 tools/memory-model/litmus-tests/README             |   2 +-
 tools/memory-model/lock.cat                        |   2 +-
 tools/memory-model/scripts/README                  |   4 +-
 tools/memory-model/scripts/checkalllitmus.sh       |   2 +-
 tools/memory-model/scripts/checklitmus.sh          |   2 +-
 tools/memory-model/scripts/parseargs.sh            |   2 +-
 tools/memory-model/scripts/runlitmushist.sh        |   2 +-
 tools/testing/radix-tree/linux/rcupdate.h          |   2 +-
 tools/testing/selftests/rcutorture/Makefile        |   3 +
 .../testing/selftests/rcutorture/bin/configinit.sh |  39 ++--
 tools/testing/selftests/rcutorture/bin/cpus2use.sh |   5 +
 .../testing/selftests/rcutorture/bin/functions.sh  |  13 +-
 tools/testing/selftests/rcutorture/bin/jitter.sh   |  13 +-
 .../testing/selftests/rcutorture/bin/kvm-build.sh  |   9 +-
 .../selftests/rcutorture/bin/kvm-find-errors.sh    |   3 +
 .../selftests/rcutorture/bin/kvm-recheck.sh        |  13 +-
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  23 +--
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  14 +-
 .../selftests/rcutorture/bin/parse-build.sh        |   2 +-
 .../selftests/rcutorture/bin/parse-console.sh      |   1 +
 .../selftests/rcutorture/configs/rcu/CFcommon      |   3 +
 .../selftests/rcutorture/configs/rcu/TREE01.boot   |   1 +
 .../selftests/rcutorture/configs/rcu/TRIVIAL       |  14 ++
 .../selftests/rcutorture/configs/rcu/TRIVIAL.boot  |   3 +
 61 files changed, 845 insertions(+), 466 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/Makefile
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL.boot
