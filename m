Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75109C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502562087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfCYQfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:35:11 -0400
Received: from ms.lwn.net ([45.79.88.28]:43192 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfCYQfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:35:11 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 557D69AC;
        Mon, 25 Mar 2019 16:35:10 +0000 (UTC)
Date:   Mon, 25 Mar 2019 10:35:09 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: rtc: Correct location of rtctest.c
Message-ID: <20190325103509.50f7fb29@lwn.net>
In-Reply-To: <20190325103322.2578-1-joel@jms.id.au>
References: <20190325103322.2578-1-joel@jms.id.au>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 21:03:22 +1030
Joel Stanley <joel@jms.id.au> wrote:

> The useful little rtctest program moved location a while back.
> 
> Fixes: a12ab9e125f1 ("selftests: move RTC tests to rtc subfolder")
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/rtc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/rtc.txt b/Documentation/rtc.txt
> index a129acf38537..688c95b11919 100644
> --- a/Documentation/rtc.txt
> +++ b/Documentation/rtc.txt
> @@ -136,5 +136,5 @@ a high functionality RTC is integrated into the SOC.  That system might read
>  the system clock from the discrete RTC, but use the integrated one for all
>  other tasks, because of its greater functionality.
>  
> -Check out tools/testing/selftests/timers/rtctest.c for an example usage of the
> +Check out tools/testing/selftests/rtc/rtctest.c for an example usage of the
>  ioctl interface.

Applied, thanks.

jon
