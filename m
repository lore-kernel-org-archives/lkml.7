Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1E9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4DA2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553656880;
	bh=wWJZg7hFW30nvHrRJ3216p8dXbFyJgzZYr2WaKsfWww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vS10Wy7F1uIV62hcetoDWYmYbGMb3DTq2KDcW6RH4VLuYWwwpaGnAY9w4rToT8o/N
	 2U2NdS9VgWMiUVIUQiMuLYaOMayl3jefkB1Da/e67Vp5dRNBkGXQFlU45wXILuvp8h
	 MbNXzssY2sIbfpM+SYGBZLp/Yfef9Yhwla8ZFTPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbfC0DVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 23:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfC0DVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 23:21:18 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 608422087E;
        Wed, 27 Mar 2019 03:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553656877;
        bh=wWJZg7hFW30nvHrRJ3216p8dXbFyJgzZYr2WaKsfWww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H+rKWIw9ZGBwzg0IY8jynL0h37sz7beRWOAWspESzJagiFaHiWAHgUP3LsCDvb2Fd
         MhUlUk+l9qTyGG8+g1WoR4L5nUMM7DBsOffnFmipE+b8CF+qKQ27NqdyJOLkzhBacT
         ERbzzNL94IXHIqgqzovfuPQhuDHo139COOHGziA8=
Date:   Wed, 27 Mar 2019 12:21:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH tip/core/rcu 1/2] doc/kprobes: Update obsolete RCU
 update functions
Message-Id: <20190327122112.1993060d4b8500125adf9c2d@kernel.org>
In-Reply-To: <20190326230050.16840-1-paulmck@linux.ibm.com>
References: <20190326230011.GA16275@linux.ibm.com>
        <20190326230050.16840-1-paulmck@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 16:00:49 -0700
"Paul E. McKenney" <paulmck@linux.ibm.com> wrote:

> The RCU flavors have been consolidated, so this commit replaces mentions
> of the now-obsolete synchronize_sched() function with synchronize_rcu().

Thank you for updating!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: <linux-doc@vger.kernel.org>
> ---
>  Documentation/kprobes.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
> index 10f4499e677c..ee60e519438a 100644
> --- a/Documentation/kprobes.txt
> +++ b/Documentation/kprobes.txt
> @@ -243,10 +243,10 @@ Optimization
>  ^^^^^^^^^^^^
>  
>  The Kprobe-optimizer doesn't insert the jump instruction immediately;
> -rather, it calls synchronize_sched() for safety first, because it's
> +rather, it calls synchronize_rcu() for safety first, because it's
>  possible for a CPU to be interrupted in the middle of executing the
> -optimized region [3]_.  As you know, synchronize_sched() can ensure
> -that all interruptions that were active when synchronize_sched()
> +optimized region [3]_.  As you know, synchronize_rcu() can ensure
> +that all interruptions that were active when synchronize_rcu()
>  was called are done, but only if CONFIG_PREEMPT=n.  So, this version
>  of kprobe optimization supports only kernels with CONFIG_PREEMPT=n [4]_.
>  
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
