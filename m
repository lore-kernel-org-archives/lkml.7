Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD811C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C7320409
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="ZHtoUkb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbfLKRSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:18:11 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:23573 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730318AbfLKRSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576084689;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=yJhVHA0KDyri+p92otMafuDdf1Au9L7Gf/Y4TZiQnMg=;
        b=ZHtoUkb+Ded4Q0bDg1i+/xIX0vCyYMXr4+u3UOu9SUcNtmrE+11ybl3ShRgYzpXxzS
        JnO6i+psu1w7DYSn+2io38Lm78na68PluInRJkRL0ui28DuSzJCcmZsCdbQM6wP4akTe
        imD9hbWufmvS67bs9TBX+tHi25XnvEPeSVDDE8PqpxyRpMPU22+g/TxF+foSax7F+nLX
        UdLPcJuKIpg5p2RMSoyMe7ZhN8BdS+LKX9RuDea5kB42FhIsZSS0TAh9Q493fD8gRoXl
        x3tLnhk0s/PI4/R1sdIU2YyMusvhTHeOgNZYtAKAFGd5m/L9F3CxZCxbyjUXNIkD6rzv
        ZXKQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJGV8vHxv6O"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.0.2 AUTH)
        with ESMTPSA id R01a59vBBHI9oG0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 11 Dec 2019 18:18:09 +0100 (CET)
Date:   Wed, 11 Dec 2019 18:18:08 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: ab8500: Fix ab8500-clk typo
Message-ID: <20191211171808.GB1530@gerhold.net>
References: <20191211114639.748463-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211114639.748463-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:46:39PM +0100, Linus Walleij wrote:
> Commit f4d41ad84433 ("mfd: ab8500: Example using new OF_MFD_CELL MACRO")
> has a typo error renaming "ab8500-clk" to "abx500-clk"
> with the result att ALSA SoC audio broke as the clock
> driver was not probing anymore. Fixed it up.
> 
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Fixes: f4d41ad84433 ("mfd: ab8500: Example using new OF_MFD_CELL MACRO")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

FWIW:
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  drivers/mfd/ab8500-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
> index bafc729fc434..3c6fda68e6bc 100644
> --- a/drivers/mfd/ab8500-core.c
> +++ b/drivers/mfd/ab8500-core.c
> @@ -631,8 +631,8 @@ static const struct mfd_cell ab8500_devs[] = {
>  		    NULL, NULL, 0, 0, "stericsson,ab8500-ext-regulator"),
>  	OF_MFD_CELL("ab8500-regulator",
>  		    NULL, NULL, 0, 0, "stericsson,ab8500-regulator"),
> -	OF_MFD_CELL("abx500-clk",
> -		    NULL, NULL, 0, 0, "stericsson,abx500-clk"),
> +	OF_MFD_CELL("ab8500-clk",
> +		    NULL, NULL, 0, 0, "stericsson,ab8500-clk"),
>  	OF_MFD_CELL("ab8500-gpadc",
>  		    NULL, NULL, 0, 0, "stericsson,ab8500-gpadc"),
>  	OF_MFD_CELL("ab8500-rtc",
> -- 
> 2.23.0
> 
