Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BF8C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4992187F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wbeo0/Gj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfFSP0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:26:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:32936 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSPZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d8aXCguNgTqbV5pDoBNS5CU4aqTfyHwDbRs3q64aIs8=; b=Wbeo0/Gj1oFmKjRwH3XeTL0k2w
        0conPB9aFVcwreHV2qEcFQ9WQ0hhkdN2T9ckKLHZ4TIjUIlaC3pJ2H/egy59vfQEr3S+oZne7xQ9I
        i3vVp1GBO6ZZ6PyWV0EeEvwlNUL8iHqaKZlfZEcFQ5+Aguu8uxMZcGtT4VMcrsOEEXC6tBmHJ7tO6
        yzlvt8pM8mfzFpifsfLhG0gVfh/m1J8Jnd4/uI/twTHUZQH3Qj163g88YxUHlVsXmXsPzr06/O1s/
        6nXt0VFsVr1t+obJ5E0lqDRD0Scg28WYkem8GOodJVOOHx7KNUFr07q3Wlk6xoJjHG3ZTVTM4lyAP
        dsGgqWgg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdcTA-0001sj-S6; Wed, 19 Jun 2019 15:25:54 +0000
Subject: Re: [PATCH] docs: fb: Add TER16x32 to the available font names
To:     Takashi Iwai <tiwai@suse.de>, Jonathan Corbet <corbet@lwn.net>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190619053943.6320-1-tiwai@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0bfb2789-158c-5e78-1621-2aaefea08d80@infradead.org>
Date:   Wed, 19 Jun 2019 08:25:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619053943.6320-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/19 10:39 PM, Takashi Iwai wrote:
> The new font is available since recently.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/fb/fbcon.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
> index cfb9f7c38f18..1da65b9000de 100644
> --- a/Documentation/fb/fbcon.rst
> +++ b/Documentation/fb/fbcon.rst
> @@ -82,7 +82,7 @@ C. Boot options
>  
>  	Select the initial font to use. The value 'name' can be any of the
>  	compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
> -	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, VGA8x16, VGA8x8.
> +	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, TER16x32, VGA8x16, VGA8x8.
>  
>  	Note, not all drivers can handle font with widths not divisible by 8,
>  	such as vga16fb.
> 


-- 
~Randy
