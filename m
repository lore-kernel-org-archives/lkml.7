Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C329CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B99206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbfHAXWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:22:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732215AbfHAXWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:22:46 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71NMDpC111200;
        Thu, 1 Aug 2019 19:22:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48mgsw0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:22:25 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71NMPAI111664;
        Thu, 1 Aug 2019 19:22:25 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48mgsvyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:22:25 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71NKh8r011657;
        Thu, 1 Aug 2019 23:22:23 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03wdc.us.ibm.com with ESMTP id 2u0e85w6vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 23:22:23 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71NMNdr52166980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 23:22:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50127B2065;
        Thu,  1 Aug 2019 23:22:23 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33272B205F;
        Thu,  1 Aug 2019 23:22:23 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 23:22:23 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 929DD16C9A39; Thu,  1 Aug 2019 16:22:24 -0700 (PDT)
Date:   Thu, 1 Aug 2019 16:22:24 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Ethan Hansen <1ethanhansen@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/1] rcu: Remove unused function
 rcutorture_record_progress
Message-ID: <20190801232224.GT5913@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <1564693240-13363-1-git-send-email-1ethanhansen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564693240-13363-1-git-send-email-1ethanhansen@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010247
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 02:00:40PM -0700, Ethan Hansen wrote:
> The function rcutorture_record_progress is declared in rcu.h,
> but is never used. Remove rcutorture_record_progress to clean code.
> 
> Signed-off-by: Ethan Hansen <1ethanhansen@gmail.com>

Good eyes!  Queued, likely for v5.5, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcu.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 8fd4f82..aeec70f 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -455,7 +455,6 @@ enum rcutorture_type {
>  #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
>  void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
>  			    unsigned long *gp_seq);
> -void rcutorture_record_progress(unsigned long vernum);
>  void do_trace_rcu_torture_read(const char *rcutorturename,
>  			       struct rcu_head *rhp,
>  			       unsigned long secs,
> @@ -468,7 +467,6 @@ static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
>  	*flags = 0;
>  	*gp_seq = 0;
>  }
> -static inline void rcutorture_record_progress(unsigned long vernum) { }
>  #ifdef CONFIG_RCU_TRACE
>  void do_trace_rcu_torture_read(const char *rcutorturename,
>  			       struct rcu_head *rhp,
> -- 
> 1.8.3.1
> 
