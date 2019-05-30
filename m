Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04230C46470
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB61C25BA2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfE3OwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:52:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbfE3OwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:52:10 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEpooU105077
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:52:09 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgu3shvh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:52:09 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:52:08 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 15:52:03 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEq2Cu30933256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:52:02 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7B47B2065;
        Thu, 30 May 2019 14:52:02 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A99C3B2064;
        Thu, 30 May 2019 14:52:02 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:52:02 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6EC0616C373B; Thu, 30 May 2019 07:52:04 -0700 (PDT)
Date:   Thu, 30 May 2019 07:52:04 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/12]
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19053014-0040-0000-0000-000004F681C7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210783; UDB=6.00636156; IPR=6.00991817;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 14:52:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053014-0041-0000-0000-000009029C18
Message-Id: <20190530145204.GA28526@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=854 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides yet more cleanups and fixes for the RCU flavor
consolidation effort:

1.	Enable elimination of Tree-RCU softirq processing, courtesy of
	Sebastian Andrzej Siewior.  (More along the lines of real-time
	than consolidation, but placed here to avoid conflicts.)

2.	Check for wakeup-safe conditions in rcu_read_unlock_special().

3.	Only do rcu_read_unlock_special() wakeups if expedited.

4.	Allow rcu_read_unlock_special() to raise_softirq() if in_irq().

5.	Use irq_work to get scheduler's attention in clean context.

6.	Inline invoke_rcu_callbacks() into its sole remaining caller.

7.	Avoid self-IPI in sync_rcu_exp_select_node_cpus().

8.	Avoid self-IPI in sync_sched_exp_online_cleanup().

9.	Add assertion to check if in an interrupt, courtesy of Joel
	Fernandes.

10.	Add checks for dynticks counters in rcu_is_cpu_rrupt_from_idle(),
	courtesy of Joel Fernandes.

11.	Rename rcu_data's ->deferred_qs to ->exp_deferred_qs.

12.	Remove unused rdp local from synchronize_rcu_expedited(),
	courtesy of Jiang Biao.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |    6 
 include/linux/lockdep.h                         |    7 
 include/linux/sched.h                           |    2 
 kernel/rcu/tree.c                               |  179 +++++++++++++++++----
 kernel/rcu/tree.h                               |    6 
 kernel/rcu/tree_exp.h                           |   50 ++++-
 kernel/rcu/tree_plugin.h                        |  201 +++++++-----------------
 7 files changed, 267 insertions(+), 184 deletions(-)

