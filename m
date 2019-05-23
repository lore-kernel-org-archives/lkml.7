Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57704C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381E22075B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfEWShH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731383AbfEWShG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:37:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B42342177E;
        Thu, 23 May 2019 18:37:04 +0000 (UTC)
Date:   Thu, 23 May 2019 14:37:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, tglx@linutronix.de, mingo@kernel.org,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        srinivas.eeda@oracle.com
Subject: Re: [PATCH v3] doc: kernel-parameters.txt: fix documentation of
 nmi_watchdog parameter
Message-ID: <20190523143703.2fb71f71@gandalf.local.home>
In-Reply-To: <1558405928-29449-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1558405928-29449-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 10:32:08 +0800
Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:

> The default behavior of hardlockup depends on the config of
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC.
> 

Jon,

You want to take this in your tree?

-- Steve

> Fix the description of nmi_watchdog to make it clear.
> 
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> ---
>  v3: add Suggested-by and Acked-by
>  v2: fix description using words suggested by Steven Rostedt
> 
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 08df588..b9d4358 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2805,8 +2805,9 @@
>  			0 - turn hardlockup detector in nmi_watchdog off
>  			1 - turn hardlockup detector in nmi_watchdog on
>  			When panic is specified, panic when an NMI watchdog
> -			timeout occurs (or 'nopanic' to override the opposite
> -			default). To disable both hard and soft lockup detectors,
> +			timeout occurs (or 'nopanic' to not panic on an NMI
> +			watchdog, if CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is set)
> +			To disable both hard and soft lockup detectors,
>  			please see 'nowatchdog'.
>  			This is useful when you use a panic=... timeout and
>  			need the box quickly up again.

