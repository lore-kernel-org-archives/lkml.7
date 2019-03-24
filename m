Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5B5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965EA20870
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfCXXo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 19:44:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729077AbfCXXoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 19:44:55 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2ONi6wO008438
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 19:44:54 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2recmuxc6e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 19:44:54 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 24 Mar 2019 23:44:53 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 24 Mar 2019 23:44:50 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2ONinFT23134358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Mar 2019 23:44:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DD21B2065;
        Sun, 24 Mar 2019 23:44:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 517BFB205F;
        Sun, 24 Mar 2019 23:44:49 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 24 Mar 2019 23:44:49 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A6FB116C2DE1; Sun, 24 Mar 2019 16:45:45 -0700 (PDT)
Date:   Sun, 24 Mar 2019 16:45:45 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2019.03.20b 59/83] kernel/rcu/tree_plugin.h:612:8:
 error: 'rcu_softirq_enabled' undeclared; did you mean
 'trace_softirqs_enabled'?
Reply-To: paulmck@linux.ibm.com
References: <201903231021.iCMNAdLb%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903231021.iCMNAdLb%lkp@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032423-2213-0000-0000-00000369669F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010809; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01179188; UDB=6.00617003; IPR=6.00959899;
 MB=3.00026141; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-24 23:44:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032423-2214-0000-0000-00005DC82B7C
Message-Id: <20190324234545.GY4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-24_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903240182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 10:16:23AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.03.20b
> head:   6d4434b4b4df791620743178e1419de882b44c7b
> commit: d0f41d341df0520e900cac03de05bbbd11abdcd9 [59/83] rcu: Enable elimination of Tree-RCU softirq processing
> config: i386-randconfig-x002-201911 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout d0f41d341df0520e900cac03de05bbbd11abdcd9
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> Note: the rcu/dev.2019.03.20b HEAD 6d4434b4b4df791620743178e1419de882b44c7b builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/rcu/tree.c:3489:0:
>    kernel/rcu/tree_plugin.h: In function 'rcu_read_unlock_special':
> >> kernel/rcu/tree_plugin.h:612:8: error: 'rcu_softirq_enabled' undeclared (first use in this function); did you mean 'trace_softirqs_enabled'?
>        if (rcu_softirq_enabled)
>            ^~~~~~~~~~~~~~~~~~~
>            trace_softirqs_enabled
>    kernel/rcu/tree_plugin.h:612:8: note: each undeclared identifier is reported only once for each function it appears in

This commit has been superseced by 132e805a28dc, which I believe has fixed
this.  (Famous last words!)

							Thanx, Paul

> vim +612 kernel/rcu/tree_plugin.h
> 
>    588	
>    589	/*
>    590	 * Handle special cases during rcu_read_unlock(), such as needing to
>    591	 * notify RCU core processing or task having blocked during the RCU
>    592	 * read-side critical section.
>    593	 */
>    594	static void rcu_read_unlock_special(struct task_struct *t)
>    595	{
>    596		unsigned long flags;
>    597		bool preempt_bh_were_disabled =
>    598				!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
>    599		bool irqs_were_disabled;
>    600	
>    601		/* NMI handlers cannot block and cannot safely manipulate state. */
>    602		if (in_nmi())
>    603			return;
>    604	
>    605		local_irq_save(flags);
>    606		irqs_were_disabled = irqs_disabled_flags(flags);
>    607		if (preempt_bh_were_disabled || irqs_were_disabled) {
>    608			WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
>    609			/* Need to defer quiescent state until everything is enabled. */
>    610			if (irqs_were_disabled) {
>    611				/* Enabling irqs does not reschedule, so... */
>  > 612				if (rcu_softirq_enabled)
>    613					raise_softirq_irqoff(RCU_SOFTIRQ);
>    614				else
>    615					invoke_rcu_core();
>    616			} else {
>    617				/* Enabling BH or preempt does reschedule, so... */
>    618				set_tsk_need_resched(current);
>    619				set_preempt_need_resched();
>    620			}
>    621			local_irq_restore(flags);
>    622			return;
>    623		}
>    624		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
>    625		rcu_preempt_deferred_qs_irqrestore(t, flags);
>    626	}
>    627	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


