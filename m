Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763F2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5C3206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfDWMqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:46:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726204AbfDWMqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:46:25 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NCewwO111606
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 08:46:24 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s211j5cty-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 08:46:23 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 23 Apr 2019 13:46:22 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 13:46:20 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NCkJIr24444988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 12:46:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE19BB2067;
        Tue, 23 Apr 2019 12:46:19 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B42E0B2065;
        Tue, 23 Apr 2019 12:46:19 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.109])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 12:46:19 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4E27F16C101C; Tue, 23 Apr 2019 05:46:19 -0700 (PDT)
Date:   Tue, 23 Apr 2019 05:46:19 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2019.04.16a 38/72] kernel/rcu/tree.c:2408:36: sparse:
 sparse: incorrect type in initializer (different address spaces)
Reply-To: paulmck@linux.ibm.com
References: <201904231828.a3jAyl28%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201904231828.a3jAyl28%lkp@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042312-0072-0000-0000-0000041D7E25
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010980; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193220; UDB=6.00625495; IPR=6.00974040;
 MB=3.00026557; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-23 12:46:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042312-0073-0000-0000-00004BED9BC3
Message-Id: <20190423124619.GH3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 06:33:33PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.04.16a
> head:   ca8714f549be5a186d086a223184095759eb7094
> commit: 9a1a31194644dfc6b8f19755ea44ecf84f37cf40 [38/72] rcu: Enable elimination of Tree-RCU softirq processing
> reproduce:
>         # apt-get install sparse
>         git checkout 9a1a31194644dfc6b8f19755ea44ecf84f37cf40
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> kernel/rcu/tree.c:2408:36: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected struct task_struct [noderef] <asn:3> **store @@    got struct task_struct [noderef] <asn:3> **store @@

Line 2408 of kernel/rcu/tree.c for commit 9a1a31194644 ("rcu: Enable
elimination of Tree-RCU softirq processing") is this:

	.store			= &rcu_data.rcu_cpu_kthread_task,

So I am having some difficulty understanding this sparse diagnostic.

Help?

							Thanx, Paul

> >> kernel/rcu/tree.c:2408:36: sparse:    expected struct task_struct [noderef] <asn:3> **store
> >> kernel/rcu/tree.c:2408:36: sparse:    got struct task_struct *[noderef] <asn:3> *
>    kernel/rcu/tree.c:3234:13: sparse: sparse: incorrect type in argument 1 (different modifiers) @@    expected int ( *threadfn )( ... ) @@    got int ( [noreint ( *threadfn )( ... ) @@
>    kernel/rcu/tree.c:3234:13: sparse:    expected int ( *threadfn )( ... )
>    kernel/rcu/tree.c:3234:13: sparse:    got int ( [noreturn] * )( ... )
>    kernel/rcu/tree.c:1110:13: sparse: sparse: context imbalance in 'rcu_start_this_gp' - different lock contexts for basic block
>    kernel/rcu/tree.c:1502:9: sparse: sparse: context imbalance in 'rcu_gp_init' - different lock contexts for basic block
>    kernel/rcu/tree.c:2190:9: sparse: sparse: context imbalance in 'force_qs_rnp' - different lock contexts for basic block
>    kernel/rcu/tree.c:2243:25: sparse: sparse: context imbalance in 'rcu_force_quiescent_state' - unexpected unlock
>    kernel/rcu/tree_stall.h:640:9: sparse: sparse: context imbalance in 'rcu_check_gp_start_stall' - different lock contexts for basic block
>    kernel/rcu/tree_exp.h:193:9: sparse: sparse: context imbalance in '__rcu_report_exp_rnp' - different lock contexts for basic block
> 
> vim +2408 kernel/rcu/tree.c
> 
>   2406	
>   2407	static struct smp_hotplug_thread rcu_cpu_thread_spec = {
> > 2408		.store			= &rcu_data.rcu_cpu_kthread_task,
>   2409		.thread_should_run	= rcu_cpu_kthread_should_run,
>   2410		.thread_fn		= rcu_cpu_kthread,
>   2411		.thread_comm		= "rcuc/%u",
>   2412		.setup			= rcu_cpu_kthread_setup,
>   2413		.park			= rcu_cpu_kthread_park,
>   2414	};
>   2415	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

