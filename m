Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666C8C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4729C20656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfFTUCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:02:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:47508 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfFTUCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:02:35 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8ED33536;
        Thu, 20 Jun 2019 20:02:34 +0000 (UTC)
Date:   Thu, 20 Jun 2019 14:02:33 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/6] time: hrtimer: use a bullet for the returns bullet
 list
Message-ID: <20190620140233.3d7202ee@lwn.net>
In-Reply-To: <a4cab6020e0475e7a4afc65dc5854756dd1bfbe9.1560883872.git.mchehab+samsung@kernel.org>
References: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
        <a4cab6020e0475e7a4afc65dc5854756dd1bfbe9.1560883872.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 15:51:20 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

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
> index edb230aba3d1..49f78453892f 100644
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
> + *  •  0 when the timer was not active
> + *  •  1 when the timer was active
> + *  • -1 when the timer is currently executing the callback function and
>   *    cannot be stopped

So I have taken some grief for letting non-ASCII stuff into the docs
before; I can only imagine that those who object would be even more
unhappy to see it in a C source file.  I'm all for fixing the warning, but
I think we shouldn't start introducing exotic characters at this point...

Thanks,

jon


>   */
>  int hrtimer_try_to_cancel(struct hrtimer *timer)
