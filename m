Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C5FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA66820700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfC0UWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:22:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725787AbfC0UW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:22:27 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2RKAmSf017239
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 16:22:26 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rgd5ffa1b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 16:22:25 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 27 Mar 2019 20:22:25 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Mar 2019 20:22:18 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2RKMHDv18415854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 20:22:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D018B2064;
        Wed, 27 Mar 2019 20:22:17 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A340B2066;
        Wed, 27 Mar 2019 20:22:17 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Mar 2019 20:22:17 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8D75616C0EAC; Wed, 27 Mar 2019 13:22:17 -0700 (PDT)
Date:   Wed, 27 Mar 2019 13:22:17 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH tip/core/rcu 1/2] doc/kprobes: Update obsolete RCU update
 functions
Reply-To: paulmck@linux.ibm.com
References: <20190326230011.GA16275@linux.ibm.com>
 <20190326230050.16840-1-paulmck@linux.ibm.com>
 <20190327122112.1993060d4b8500125adf9c2d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327122112.1993060d4b8500125adf9c2d@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032720-0040-0000-0000-000004D82AB6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010825; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180554; UDB=6.00606765; IPR=6.00961271;
 MB=3.00026184; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-27 20:22:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032720-0041-0000-0000-000008E34CB3
Message-Id: <20190327202217.GH4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 12:21:12PM +0900, Masami Hiramatsu wrote:
> On Tue, 26 Mar 2019 16:00:49 -0700
> "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> 
> > The RCU flavors have been consolidated, so this commit replaces mentions
> > of the now-obsolete synchronize_sched() function with synchronize_rcu().
> 
> Thank you for updating!
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Applied, thank you!

							Thanx, Paul

> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> > Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: <linux-doc@vger.kernel.org>
> > ---
> >  Documentation/kprobes.txt | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
> > index 10f4499e677c..ee60e519438a 100644
> > --- a/Documentation/kprobes.txt
> > +++ b/Documentation/kprobes.txt
> > @@ -243,10 +243,10 @@ Optimization
> >  ^^^^^^^^^^^^
> >  
> >  The Kprobe-optimizer doesn't insert the jump instruction immediately;
> > -rather, it calls synchronize_sched() for safety first, because it's
> > +rather, it calls synchronize_rcu() for safety first, because it's
> >  possible for a CPU to be interrupted in the middle of executing the
> > -optimized region [3]_.  As you know, synchronize_sched() can ensure
> > -that all interruptions that were active when synchronize_sched()
> > +optimized region [3]_.  As you know, synchronize_rcu() can ensure
> > +that all interruptions that were active when synchronize_rcu()
> >  was called are done, but only if CONFIG_PREEMPT=n.  So, this version
> >  of kprobe optimization supports only kernels with CONFIG_PREEMPT=n [4]_.
> >  
> > -- 
> > 2.17.1
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
> 

