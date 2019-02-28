Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC219C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825E42184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733199AbfB1Qva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:51:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727861AbfB1Qv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:51:29 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SGorpe096602
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 11:51:27 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qxk4e92yt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 11:51:27 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 28 Feb 2019 16:51:26 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Feb 2019 16:51:22 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1SGpLdY23920872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 16:51:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9754B2064;
        Thu, 28 Feb 2019 16:51:21 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BADABB205F;
        Thu, 28 Feb 2019 16:51:21 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 28 Feb 2019 16:51:21 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A6E5A16C4295; Thu, 28 Feb 2019 08:51:22 -0800 (PST)
Date:   Thu, 28 Feb 2019 08:51:22 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/locking/lockdep: Drop last two chars of
 sample states
Reply-To: paulmck@linux.ibm.com
References: <20190228105731.1092-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228105731.1092-1-geert+renesas@glider.be>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19022816-0068-0000-0000-0000039BC920
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010680; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01167658; UDB=6.00610029; IPR=6.00948272;
 MB=3.00025782; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-28 16:51:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022816-0069-0000-0000-000047A8C9B6
Message-Id: <20190228165122.GT4072@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:57:31AM +0100, Geert Uytterhoeven wrote:
> Since the removal of FS_RECLAIM annotations, lockdep states contain six
> characters, not four.

Does the above want to instead say "four characters, not six"?

							Thanx, Paul

> Fixes: e5684bbfc3f03480 ("Documentation/locking/lockdep: Update info about states")
> Fixes: d92a8cfcb37ecd13 ("locking/lockdep: Rework FS_RECLAIM annotation")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/RCU/lockdep-splat.txt      | 6 +++---
>  Documentation/locking/lockdep-design.txt | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/RCU/lockdep-splat.txt b/Documentation/RCU/lockdep-splat.txt
> index 238e9f61352f6187..9423b633526d14df 100644
> --- a/Documentation/RCU/lockdep-splat.txt
> +++ b/Documentation/RCU/lockdep-splat.txt
> @@ -24,11 +24,11 @@ other info that might help us debug this:
>  
>  rcu_scheduler_active = 1, debug_locks = 0
>  3 locks held by scsi_scan_6/1552:
> - #0:  (&shost->scan_mutex){+.+.+.}, at: [<ffffffff8145efca>]
> + #0:  (&shost->scan_mutex){+.+.}, at: [<ffffffff8145efca>]
>  scsi_scan_host_selected+0x5a/0x150
> - #1:  (&eq->sysfs_lock){+.+...}, at: [<ffffffff812a5032>]
> + #1:  (&eq->sysfs_lock){+.+.}, at: [<ffffffff812a5032>]
>  elevator_exit+0x22/0x60
> - #2:  (&(&q->__queue_lock)->rlock){-.-...}, at: [<ffffffff812b6233>]
> + #2:  (&(&q->__queue_lock)->rlock){-.-.}, at: [<ffffffff812b6233>]
>  cfq_exit_queue+0x43/0x190
>  
>  stack backtrace:
> diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
> index 49f58a07ee7b19c8..39fae143c9cbf5ff 100644
> --- a/Documentation/locking/lockdep-design.txt
> +++ b/Documentation/locking/lockdep-design.txt
> @@ -45,10 +45,10 @@ When locking rules are violated, these state bits are presented in the
>  locking error messages, inside curlies. A contrived example:
>  
>     modprobe/2287 is trying to acquire lock:
> -    (&sio_locks[i].lock){-.-...}, at: [<c02867fd>] mutex_lock+0x21/0x24
> +    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
>  
>     but task is already holding lock:
> -    (&sio_locks[i].lock){-.-...}, at: [<c02867fd>] mutex_lock+0x21/0x24
> +    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
>  
>  
>  The bit position indicates STATE, STATE-read, for each of the states listed
> -- 
> 2.17.1
> 

