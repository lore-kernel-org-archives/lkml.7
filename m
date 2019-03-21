Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCBEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700462175B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfCUQm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:42:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728016AbfCUQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:42:56 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2LGeWTS065074
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 12:42:55 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rcd3a4h2r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 12:42:54 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 21 Mar 2019 16:42:51 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Mar 2019 16:42:47 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2LGgnDj19267630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 16:42:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1912B2064;
        Thu, 21 Mar 2019 16:42:48 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF256B205F;
        Thu, 21 Mar 2019 16:42:48 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 21 Mar 2019 16:42:48 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A056316C3296; Thu, 21 Mar 2019 09:43:40 -0700 (PDT)
Date:   Thu, 21 Mar 2019 09:43:40 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Barret Rhoden <brho@google.com>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [LKP] [rcu] f836ea2ec9: BUG:unable_to_handle_kernel
Reply-To: paulmck@linux.ibm.com
References: <20190321084936.GK2813@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321084936.GK2813@shao2-debian>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032116-0068-0000-0000-000003A92DA6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010789; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01177623; UDB=6.00616055; IPR=6.00958319;
 MB=3.00026095; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-21 16:42:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032116-0069-0000-0000-000047E4992E
Message-Id: <20190321164340.GV4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=919 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903210117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 04:49:37PM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: f836ea2ec954a20af25861e68075ad743be046f4 ("rcu: Forbid DEFINE{,_STATIC}_SRCU() from modules")
> https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2019.03.18a

This commit has been replaced by eb89abcb3073 ("rcu: Forbid
DEFINE{,_STATIC}_SRCU() from modules"), but this did locate an otherwise
mostly latent bug, the fix for which is shown below.

So thank you again.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit 6534d5b0f24accd71620873980ba5a14aa85e898
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Thu Mar 21 09:27:28 2019 -0700

    rcutorture: Fix cleanup path for invalid torture_type strings
    
    If the specified rcutorture.torture_type is not in the rcu_torture_init()
    function's torture_ops[] array, rcutorture prints some console messages
    and then invokes rcu_torture_cleanup() to set state so that a future
    torture test can run.  However, rcu_torture_cleanup() also attempts to
    end the test that didn't actually start, and in doing so relies on the
    value of cur_ops, a value that is not particularly relevant in this case.
    This can result in confusing output or even follow-on failures due to
    attempts to use facilities that have not been properly initialized.
    
    This commit therefore sets the value of cur_ops to NULL in this case
    and inserts a check near the beginning of rcu_torture_cleanup(),
    thus avoiding relying on an irrelevant cur_ops value.
    
    Reported-by: kernel test robot <rong.a.chen@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7086caa743c7..af31ddee7b36 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2101,6 +2101,10 @@ rcu_torture_cleanup(void)
 			cur_ops->cb_barrier();
 		return;
 	}
+	if (!cur_ops) {
+		torture_cleanup_end();
+		return;
+	}
 
 	rcu_torture_barrier_cleanup();
 	torture_stop_kthread(rcu_torture_fwd_prog, fwd_prog_task);
@@ -2281,6 +2285,7 @@ rcu_torture_init(void)
 		pr_cont("\n");
 		WARN_ON(!IS_MODULE(CONFIG_RCU_TORTURE_TEST));
 		firsterr = -EINVAL;
+		cur_ops = NULL;
 		goto unwind;
 	}
 	if (cur_ops->fqs == NULL && fqs_duration != 0) {

