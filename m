Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FBDC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C9C216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfENTVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfENTVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:21:15 -0400
Received: from oasis.local.home (50-204-120-225-static.hfc.comcastbusiness.net [50.204.120.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D34662166E;
        Tue, 14 May 2019 19:21:13 +0000 (UTC)
Date:   Tue, 14 May 2019 15:21:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, srinivas.eeda@oracle.com
Subject: Re: [PATCH v2] doc: kernel-parameters.txt: fix documentation of
 nmi_watchdog parameter
Message-ID: <20190514152113.336e6116@oasis.local.home>
In-Reply-To: <1557632127-16717-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1557632127-16717-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2019 11:35:27 +0800
Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:

> The default behavior of hardlockup depends on the config of
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC.
> 
> Fix the description of nmi_watchdog to make it clear.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Perhaps it should have been:

 Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

As the wording is what I suggested ;-)

-- Steve

> ---
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

