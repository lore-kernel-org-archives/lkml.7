Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D370EC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F62820684
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559917371;
	bh=Eyu/n0ZHyMK1sy0bHcbERacQ9hcPM1ufLV2YluFIe14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=abqDDaQAF/Gfxn4HOzDaJPW2tX1s/cyWsyy5Mp9eMrexRTvFH0pDclo0A/hElpvBx
	 4fcf8v2grWhU4QMFHOWCFxd4MwIJewnb5FVJwiCgpC5vv419d0rvMw8E1kWCnJqkog
	 f669NB21iprUyhnNjnELyHrwb4vYvsyMYKAPhhMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfFGOWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbfFGOWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:22:51 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14E7A20657;
        Fri,  7 Jun 2019 14:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559917370;
        bh=Eyu/n0ZHyMK1sy0bHcbERacQ9hcPM1ufLV2YluFIe14=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cH2jmj+dw0yoGAJob2p6WymUKekGA30lyB4dB9m16PZcgQYc6L3HhvgB/rxpCScBP
         F/Iliw8zVPIJDW93ev8PoD3tNUsRJcaSAia0Mkpvu3Zd433YXdEdJGIdZ6c02Ru/3f
         53VfI41c9LGbYl5Gt12OOMAWiD7ZKa0dANFeLd8U=
Date:   Fri, 7 Jun 2019 23:22:44 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "George G. Davis" <george_davis@mentor.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>, Jann Horn <jannh@google.com>,
        Nadav Amit <namit@vmware.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] treewide: trivial: fix s/poped/popped/ typo
Message-Id: <20190607232244.bd7b152dbcd7e5e60952ec18@kernel.org>
In-Reply-To: <1559766612-12178-2-git-send-email-george_davis@mentor.com>
References: <1559766612-12178-1-git-send-email-george_davis@mentor.com>
        <1559766612-12178-2-git-send-email-george_davis@mentor.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2019 16:30:10 -0400
"George G. Davis" <george_davis@mentor.com> wrote:

> Fix a couple of s/poped/popped/ typos.
> 
> Cc: Jiri Kosina <trivial@kernel.org>
> Signed-off-by: George G. Davis <george_davis@mentor.com>

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,


> ---
>  Documentation/arm/mem_alignment | 2 +-
>  arch/x86/kernel/kprobes/core.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arm/mem_alignment b/Documentation/arm/mem_alignment
> index 6335fcacbba9..e110e2781039 100644
> --- a/Documentation/arm/mem_alignment
> +++ b/Documentation/arm/mem_alignment
> @@ -1,4 +1,4 @@
> -Too many problems poped up because of unnoticed misaligned memory access in
> +Too many problems popped up because of unnoticed misaligned memory access in
>  kernel code lately.  Therefore the alignment fixup is now unconditionally
>  configured in for SA11x0 based targets.  According to Alan Cox, this is a
>  bad idea to configure it out, but Russell King has some good reasons for
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 6afd8061dbae..d3243d93daf4 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -813,7 +813,7 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
>  			continue;
>  		/*
>  		 * Return probes must be pushed on this hash list correct
> -		 * order (same as return order) so that it can be poped
> +		 * order (same as return order) so that it can be popped
>  		 * correctly. However, if we find it is pushed it incorrect
>  		 * order, this means we find a function which should not be
>  		 * probed, because the wrong order entry is pushed on the
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
