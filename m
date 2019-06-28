Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC32C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC39F20644
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfF1Mja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:39:30 -0400
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:57514 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726675AbfF1Mj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:39:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4C9CD180AA4E7;
        Fri, 28 Jun 2019 12:39:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: heart62_527ff926a3836
X-Filterd-Recvd-Size: 2281
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Jun 2019 12:39:26 +0000 (UTC)
Message-ID: <951e47de7dd6d86516c25ceb855c4b64f13fb65d.camel@perches.com>
Subject: Re: [PATCH 1/9] hrtimer: Use a bullet for the returns bullet list
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Fri, 28 Jun 2019 05:39:25 -0700
In-Reply-To: <8176c9089f66796de6f62e74499eb3d3015f785d.1561723736.git.mchehab+samsung@kernel.org>
References: <cover.1561723736.git.mchehab+samsung@kernel.org>
         <8176c9089f66796de6f62e74499eb3d3015f785d.1561723736.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-28 at 09:12 -0300, Mauro Carvalho Chehab wrote:
> That gets rid of this warning:
> 
> 	./kernel/time/hrtimer.c:1119: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> and displays nicely both at the source code and at the produced
> documentation.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  kernel/time/hrtimer.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index edb230aba3d1..5ee77f1a8a92 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1114,9 +1114,10 @@ EXPORT_SYMBOL_GPL(hrtimer_start_range_ns);
>   * @timer:	hrtimer to stop
>   *
>   * Returns:
> - *  0 when the timer was not active
> - *  1 when the timer was active
> - * -1 when the timer is currently executing the callback function and
> + *
> + *  *  0 when the timer was not active
> + *  *  1 when the timer was active
> + *  * -1 when the timer is currently executing the callback function and
>   *    cannot be stopped

I think this last line should be indented 3 more spaces too


