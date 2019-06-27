Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C087CC5B576
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE0F2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfF0U5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 16:57:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726443AbfF0U5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 16:57:07 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RKqjs5108027
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 16:57:06 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2td2fh7ete-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 16:57:06 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 27 Jun 2019 21:57:05 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 21:57:02 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RKv1JY50200954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 20:57:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D1C7B2064;
        Thu, 27 Jun 2019 20:57:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FC27B2067;
        Thu, 27 Jun 2019 20:57:01 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 20:57:01 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3CCA616C5D69; Thu, 27 Jun 2019 13:57:03 -0700 (PDT)
Date:   Thu, 27 Jun 2019 13:57:03 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <byungchul.park@lge.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v2] rcu: Change return type of
 rcu_spawn_one_boost_kthread()
Reply-To: paulmck@linux.ibm.com
References: <1561619266-8850-1-git-send-email-byungchul.park@lge.com>
 <20190627134240.GB215968@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627134240.GB215968@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062720-0052-0000-0000-000003D716BA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011343; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224163; UDB=6.00644283; IPR=6.01005351;
 MB=3.00027495; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-27 20:57:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062720-0053-0000-0000-0000617BFAED
Message-Id: <20190627205703.GF26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 09:42:40AM -0400, Joel Fernandes wrote:
> On Thu, Jun 27, 2019 at 04:07:46PM +0900, Byungchul Park wrote:
> > Hello,
> > 
> > I tested if the WARN_ON_ONCE() is fired with my box and it was ok.
> 
> Looks pretty safe to me and nice clean up!
> 
> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Agreed, but I still cannot find where this applies.  I did try rcu/next,
which is currently here:

commit b989ff070574ad8b8621d866de0a8e9a65d42c80 (rcu/rcu/next, rcu/next)
Merge: 4289ee7d5a83 11ca7a9d541d
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Mon Jun 24 09:12:39 2019 -0700

    Merge LKMM and RCU commits

Help?

							Thanx, Paul

>  - Joel
> 
> > 
> > Thanks,
> > Byungchul
> > 
> > Changes from v1
> > -. WARN_ON_ONCE() on failing to create rcu_boost_kthread.
> > -. Changed title and commit message a bit.
> > 
> > ---8<---
> > From 7100fcf82202f063f70f45def208ea5198412f5a Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul.park@lge.com>
> > Date: Thu, 27 Jun 2019 15:58:10 +0900
> > Subject: [PATCH v2] rcu: Change return type of rcu_spawn_one_boost_kthread()
> > 
> > The return value of rcu_spawn_one_boost_kthread() is not used any
> > longer. Change return type of that function from int to void.
> > 
> > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > ---
> >  kernel/rcu/tree_plugin.h | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 1102765..3c8444e 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -1131,7 +1131,7 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
> >   * already exist.  We only create this kthread for preemptible RCU.
> >   * Returns zero if all is well, a negated errno otherwise.
> >   */
> > -static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> > +static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> >  {
> >  	int rnp_index = rnp - rcu_get_root();
> >  	unsigned long flags;
> > @@ -1139,25 +1139,24 @@ static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> >  	struct task_struct *t;
> >  
> >  	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> > -		return 0;
> > +		return;
> >  
> >  	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
> > -		return 0;
> > +		return;
> >  
> >  	rcu_state.boost = 1;
> >  	if (rnp->boost_kthread_task != NULL)
> > -		return 0;
> > +		return;
> >  	t = kthread_create(rcu_boost_kthread, (void *)rnp,
> >  			   "rcub/%d", rnp_index);
> > -	if (IS_ERR(t))
> > -		return PTR_ERR(t);
> > +	if (WARN_ON_ONCE(IS_ERR(t)))
> > +		return;
> >  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> >  	rnp->boost_kthread_task = t;
> >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >  	sp.sched_priority = kthread_prio;
> >  	sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
> >  	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
> > -	return 0;
> >  }
> >  
> >  static void rcu_cpu_kthread_setup(unsigned int cpu)
> > @@ -1265,7 +1264,7 @@ static void __init rcu_spawn_boost_kthreads(void)
> >  	if (WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__))
> >  		return;
> >  	rcu_for_each_leaf_node(rnp)
> > -		(void)rcu_spawn_one_boost_kthread(rnp);
> > +		rcu_spawn_one_boost_kthread(rnp);
> >  }
> >  
> >  static void rcu_prepare_kthreads(int cpu)
> > @@ -1275,7 +1274,7 @@ static void rcu_prepare_kthreads(int cpu)
> >  
> >  	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
> >  	if (rcu_scheduler_fully_active)
> > -		(void)rcu_spawn_one_boost_kthread(rnp);
> > +		rcu_spawn_one_boost_kthread(rnp);
> >  }
> >  
> >  #else /* #ifdef CONFIG_RCU_BOOST */
> > -- 
> > 1.9.1
> > 

