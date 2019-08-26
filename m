Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A139EC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC61217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbfHZQU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:20:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:18412 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731931AbfHZQU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:20:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 09:20:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="181423289"
Received: from mgross-mobl.amr.corp.intel.com (HELO localhost) ([10.7.198.58])
  by fmsmga007.fm.intel.com with ESMTP; 26 Aug 2019 09:20:25 -0700
Date:   Mon, 26 Aug 2019 09:20:24 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 02/16] sched: Fix kerneldoc comment for
 ia64_set_curr_task
Message-ID: <20190826162024.GC2680@u1904>
Reply-To: mgross@linux.intel.com
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <fde3a65ea3091ec6b84dac3c19639f85f452c5d1.1559129225.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde3a65ea3091ec6b84dac3c19639f85f452c5d1.1559129225.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 08:36:38PM +0000, Vineeth Remanan Pillai wrote:
> From: Peter Zijlstra <peterz@infradead.org>

NULL commit comment.

--mark

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 4778c48a7fda..416ea613eda8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6287,7 +6287,7 @@ struct task_struct *curr_task(int cpu)
>  
>  #ifdef CONFIG_IA64
>  /**
> - * set_curr_task - set the current task for a given CPU.
> + * ia64_set_curr_task - set the current task for a given CPU.
>   * @cpu: the processor in question.
>   * @p: the task pointer to set.
>   *
> -- 
> 2.17.1
> 
