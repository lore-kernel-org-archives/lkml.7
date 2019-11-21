Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3053AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA89206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfKUXev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:34:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:44508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfKUXeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:34:50 -0500
Received: from oasis.local.home (unknown [66.170.99.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E82120674;
        Thu, 21 Nov 2019 23:34:50 +0000 (UTC)
Date:   Thu, 21 Nov 2019 18:34:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kusanagi Kouichi <slash@ac.auone-net.jp>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Remove unnecessary DEBUG_FS dependency
Message-ID: <20191121183448.208df222@oasis.local.home>
In-Reply-To: <20191120104350753.EWCT.12796.ppp.dion.ne.jp@dmta0009.auone-net.jp>
References: <20191120104350753.EWCT.12796.ppp.dion.ne.jp@dmta0009.auone-net.jp>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 19:43:50 +0900
Kusanagi Kouichi <slash@ac.auone-net.jp> wrote:

> Tracing replaced debugfs with tracefs.

Ah, I missed that. Thanks, I added this to my queue.

-- Steve

> 
> Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
> ---
>  kernel/trace/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index e08527f50d2a..382628b9b759 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -106,7 +106,6 @@ config PREEMPTIRQ_TRACEPOINTS
>  
>  config TRACING
>  	bool
> -	select DEBUG_FS
>  	select RING_BUFFER
>  	select STACKTRACE if STACKTRACE_SUPPORT
>  	select TRACEPOINTS

