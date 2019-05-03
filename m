Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C41CC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354642075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfECOPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 10:15:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726681AbfECOPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:15:49 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x43E914X034296
        for <linux-kernel@vger.kernel.org>; Fri, 3 May 2019 10:15:48 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s8pvjh4qf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 10:15:48 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 3 May 2019 15:15:47 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 May 2019 15:15:43 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x43EFgSr24379454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 May 2019 14:15:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC25EB2066;
        Fri,  3 May 2019 14:15:42 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E5E7B206C;
        Fri,  3 May 2019 14:15:42 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 May 2019 14:15:42 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1FA8816C2A49; Fri,  3 May 2019 07:15:43 -0700 (PDT)
Date:   Fri, 3 May 2019 07:15:43 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2019.04.28a 85/85] htmldocs: kernel/rcu/sync.c:74:
 warning: Function parameter or member 'rcu' not described in 'rcu_sync_func'
Reply-To: paulmck@linux.ibm.com
References: <201905031452.Nu9N5LwE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905031452.Nu9N5LwE%lkp@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19050314-0052-0000-0000-000003B78801
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011041; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01198004; UDB=6.00628393; IPR=6.00978865;
 MB=3.00026714; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-03 14:15:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050314-0053-0000-0000-000060BCD055
Message-Id: <20190503141543.GY3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-03_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905030089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 02:58:59PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.04.28a
> head:   a4e0e069df6e8718bf165fb009cd3a23e7a808a3
> commit: a4e0e069df6e8718bf165fb009cd3a23e7a808a3 [85/85] rcu/sync: Simplify the state machine
> reproduce: make htmldocs
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
>    include/linux/generic-radix-tree.h:1: warning: no structured comments found
>    kernel/rcu/tree_plugin.h:1: warning: no structured comments found
> >> kernel/rcu/sync.c:74: warning: Function parameter or member 'rcu' not described in 'rcu_sync_func'
>    kernel/rcu/sync.c:74: warning: Excess function parameter 'rhp' description in 'rcu_sync_func'

Good catch!  I will be folding in the diff shown below.

>    kernel/rcu/tree_plugin.h:1: warning: no structured comments found

Maybe I should add some?  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit 54479fcd0f2956d4168a5e2dd170bc9b2689df45
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Fri May 3 07:13:42 2019 -0700

    squash! rcu/sync: Simplify the state machine
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
    [ paulmck: Tweaks to make htmldocs happy. (Reported by kbuild test robot.) ]

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index f72b779f9a8a..d4558ab7a07d 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -40,7 +40,7 @@ void rcu_sync_enter_start(struct rcu_sync *rsp)
 }
 
 
-static void rcu_sync_func(struct rcu_head *rcu);
+static void rcu_sync_func(struct rcu_head *rhp);
 
 static void rcu_sync_call(struct rcu_sync *rsp)
 {
@@ -70,9 +70,9 @@ static void rcu_sync_call(struct rcu_sync *rsp)
  * rcu_sync_exit().  Otherwise, set all state back to idle so that readers
  * can again use their fastpaths.
  */
-static void rcu_sync_func(struct rcu_head *rcu)
+static void rcu_sync_func(struct rcu_head *rhp)
 {
-	struct rcu_sync *rsp = container_of(rcu, struct rcu_sync, cb_head);
+	struct rcu_sync *rsp = container_of(rhp, struct rcu_sync, cb_head);
 	unsigned long flags;
 
 	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);

