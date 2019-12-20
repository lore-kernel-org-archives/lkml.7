Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB96C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39D121655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLTCEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 21:04:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:59994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfLTCEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 21:04:53 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 957DA206D8;
        Fri, 20 Dec 2019 02:04:52 +0000 (UTC)
Date:   Thu, 19 Dec 2019 21:04:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] vsprintf: spread "const char *"
Message-ID: <20191219210451.6c96e6e5@rorschach.local.home>
In-Reply-To: <20191219173458.GA4246@avx2>
References: <20191219173458.GA4246@avx2>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019 20:34:58 +0300
Alexey Dobriyan <adobriyan@gmail.com> wrote:

What does 'spread "const char*"' mean?

And you need to have a change log. Did this cause a warning? If so,
please show it in the change log.

-- Steve


> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  lib/vsprintf.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1550,7 +1550,7 @@ static noinline_for_stack
>  char *ip_addr_string(char *buf, char *end, const void *ptr,
>  		     struct printf_spec spec, const char *fmt)
>  {
> -	char *err_fmt_msg;
> +	const char *err_fmt_msg;
>  
>  	if (check_pointer(&buf, end, ptr, spec))
>  		return buf;

