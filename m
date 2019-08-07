Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87EFC32754
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B747D20880
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389232AbfHGXmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 19:42:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388412AbfHGXmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:42:01 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77NadUW158861;
        Wed, 7 Aug 2019 19:41:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u87072xr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 19:41:27 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x77NdCMP164069;
        Wed, 7 Aug 2019 19:41:26 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u87072xqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 19:41:26 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x77Ne7Xr030667;
        Wed, 7 Aug 2019 23:41:25 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 2u51w7b4sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 23:41:25 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x77NfPBl44957986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Aug 2019 23:41:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B3C6B2065;
        Wed,  7 Aug 2019 23:41:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1940B205F;
        Wed,  7 Aug 2019 23:41:24 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  7 Aug 2019 23:41:24 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 08E1A16C9A4E; Wed,  7 Aug 2019 16:41:26 -0700 (PDT)
Date:   Wed, 7 Aug 2019 16:41:25 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Ethan Hansen <1ethanhansen@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/1] rcu: Remove unused variable
 rcu_perf_writer_state
Message-ID: <20190807234125.GK28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <1565220415-3070-1-git-send-email-1ethanhansen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565220415-3070-1-git-send-email-1ethanhansen@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 04:26:55PM -0700, Ethan Hansen wrote:
> The variable rcu_perf_writer_state is declared and initialized,
> but is never actually referenced. Remove it to clean code.
> 
> Signed-off-by: Ethan Hansen <1ethanhansen@gmail.com>

Good eyes, thank you!  One question below.

							Thanx, Paul

> ---
>  kernel/rcu/rcuperf.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index 5a879d0..ff02936 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -109,7 +109,6 @@
>  static unsigned long b_rcu_perf_writer_finished;
>  static DEFINE_PER_CPU(atomic_t, n_async_inflight);
>  
> -static int rcu_perf_writer_state;
>  #define RTWS_INIT		0
>  #define RTWS_ASYNC		1
>  #define RTWS_BARRIER		2

Does removing this variable also mean that the RTWS_* C preprocessor
macros are now unused?

> @@ -404,25 +403,20 @@ static void rcu_perf_async_cb(struct rcu_head *rhp)
>  			if (!rhp)
>  				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
>  			if (rhp && atomic_read(this_cpu_ptr(&n_async_inflight)) < gp_async_max) {
> -				rcu_perf_writer_state = RTWS_ASYNC;
>  				atomic_inc(this_cpu_ptr(&n_async_inflight));
>  				cur_ops->async(rhp, rcu_perf_async_cb);
>  				rhp = NULL;
>  			} else if (!kthread_should_stop()) {
> -				rcu_perf_writer_state = RTWS_BARRIER;
>  				cur_ops->gp_barrier();
>  				goto retry;
>  			} else {
>  				kfree(rhp); /* Because we are stopping. */
>  			}
>  		} else if (gp_exp) {
> -			rcu_perf_writer_state = RTWS_EXP_SYNC;
>  			cur_ops->exp_sync();
>  		} else {
> -			rcu_perf_writer_state = RTWS_SYNC;
>  			cur_ops->sync();
>  		}
> -		rcu_perf_writer_state = RTWS_IDLE;
>  		t = ktime_get_mono_fast_ns();
>  		*wdp = t - *wdp;
>  		i_max = i;
> @@ -463,10 +457,8 @@ static void rcu_perf_async_cb(struct rcu_head *rhp)
>  		rcu_perf_wait_shutdown();
>  	} while (!torture_must_stop());
>  	if (gp_async) {
> -		rcu_perf_writer_state = RTWS_BARRIER;
>  		cur_ops->gp_barrier();
>  	}
> -	rcu_perf_writer_state = RTWS_STOPPING;
>  	writer_n_durations[me] = i_max;
>  	torture_kthread_stopping("rcu_perf_writer");
>  	return 0;
> -- 
> 1.8.3.1
> 
