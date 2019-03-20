Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DABC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3D82183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfCTQfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:35:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726817AbfCTQfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:35:06 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2KGT85W012947
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:35:05 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rbqxcmt17-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:35:04 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 20 Mar 2019 16:35:03 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Mar 2019 16:35:00 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2KGZ0nK18612422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 16:35:00 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65FD6B206A;
        Wed, 20 Mar 2019 16:35:00 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48BE2B2065;
        Wed, 20 Mar 2019 16:35:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Mar 2019 16:35:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AFBBC16C30D6; Wed, 20 Mar 2019 09:35:50 -0700 (PDT)
Date:   Wed, 20 Mar 2019 09:35:50 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU: Adjust comments for force_qs_rnp
Reply-To: paulmck@linux.ibm.com
References: <1553052780-3789-1-git-send-email-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553052780-3789-1-git-send-email-zhouzhouyi@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032016-0072-0000-0000-0000040DF0AC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010789; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01177144; UDB=6.00615766; IPR=6.00957839;
 MB=3.00026075; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-20 16:35:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032016-0073-0000-0000-00004B8D0D81
Message-Id: <20190320163550.GL4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 03:33:00AM +0000, Zhouyi Zhou wrote:
> Previously, threads blocked on offlining CPUS are migrated to root
> rcu_node, so there is a need to initiate RCU priority boosting on root
> rcu_node,
> 
> Current RCU does not migrate blocked tasks even if all corresponding CPUs
> offline. 
> commit d19fb8d1f3f6 ("rcu: Don't migrate blocked tasks even if all corresponding CPUs offline")'
> 
> Consequently, rcu does not initiate RCU priority boosting on root rcu_node.
> commit 1be0085b515e ("rcu: Don't initiate RCU priority boosting on root rcu_node")'
> 
> So I think the comments for force_qs_rnp should be adjusted.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Great catch, thank you!  I have queued it with wordsmithing as shown
below.  Please let me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 24bbb0754fdfabe3976c42e82620d1d1a86da9d6
Author: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed Mar 20 03:33:00 2019 +0000

    rcu: Fix force_qs_rnp() header comment
    
    Previously, threads blocked on offlining CPUS were migrated to the
    root rcu_node structure, thus requiring RCU priority boosting on this
    structure.  However, since commit d19fb8d1f3f6 ("rcu: Don't migrate
    blocked tasks even if all corresponding CPUs offline"), RCU does not
    migrate blocked tasks.  Consequently, RCU no longer does RCU priority
    boosting on the root rcu_node structure as of commit 1be0085b515e ("rcu:
    Don't initiate RCU priority boosting on root rcu_node").
    
    This commit therefore brings comments for the force_qs_rnp() function's
    header comment in line with this new no-root-boosting reality.
    
    Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
    [ paulmck: Also remove obsolete comment on suppressing new grace periods. ]
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c719929c9316..961dbc7b8949 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2171,11 +2171,11 @@ void rcu_sched_clock_irq(int user)
 }
 
 /*
- * Scan the leaf rcu_node structures, processing dyntick state for any that
- * have not yet encountered a quiescent state, using the function specified.
- * Also initiate boosting for any threads blocked on the root rcu_node.
- *
- * The caller must have suppressed start of new grace periods.
+ * Scan the leaf rcu_node structures.  For each structure on which all
+ * CPUs have reported a quiescent state and on which there are tasks
+ * blocking the current grace period, initiate RCU priority boosting.
+ * Otherwise, invoke the specified function to check dyntick state for
+ * each CPU that has not yet reported a quiescent state.
  */
 static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 {

