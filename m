Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EC3C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9732088F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GN0/nFYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbfKTQmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:42:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38050 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732847AbfKTQmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:42:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id z19so323224wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 08:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DoBrdkQjnM2M/sNIIdwf16laThZkuQKlh8PPcfsQfYM=;
        b=GN0/nFYDPFzOUrHsl9BbUvlxMEQgUTa5wU0hEQG8hzQRTEesfxWZBj4Q/qj3QnsV4K
         AjN2mkwABi+vsodfnJLOTctxxyuhkQ55UuAtU8xswqrCnp7gxOrM8XDS6g1oeux1y2AZ
         q8O3Fd5bQRf9OxPkeDbthgLX0cnVMUMd6NecI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DoBrdkQjnM2M/sNIIdwf16laThZkuQKlh8PPcfsQfYM=;
        b=dM5dcET5+3/U7tYEh46VKaBKKGk7an1tHijQwG6dSVHojTUl/YOLKMQZ0A1jTHCGE6
         26eEhtjNUfm+YJxoq5aN2kpboUN/aHL8jdDeIYZD9cmuxWQrM0kQjAkkl+DzvcouDiFP
         MJp7stIJU1oqLpwvZtEGSuEh7DsGt2l5UW9aIjzjG5Kr+O1cB7+oPnB5e8HF5eVX/ojl
         MDwqhMhtAUlAp2U7bBmkH6Vaep3OF6+Pf4P9YAtnw2bMl6VBmZmqETG0C/WSCUY/eSzl
         DZuh+WbRsrbhlZzOnkj0rtA3XhmfSpUctgyqnJuW/+Z48xetS91AyiSEYOnBqwmZONGF
         qsOg==
X-Gm-Message-State: APjAAAXtnUUdwZ4+AiXfex9izGomN8fQppxI0SLbDjdC2nhGAXzuudj/
        aDklIOEfz8CIW9fjy3XEumVjpw==
X-Google-Smtp-Source: APXvYqxcp61Ouq7qqx6fMqpJbU5o8VCWsZA5gd0+Tv52/4/6QtREkNjADbOEaEE5seygIX0OYcGmYw==
X-Received: by 2002:a1c:cc01:: with SMTP id h1mr4269171wmb.172.1574268118420;
        Wed, 20 Nov 2019 08:41:58 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id j2sm32071445wrt.61.2019.11.20.08.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 08:41:57 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:41:55 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] staging: fbtft: Fix Kconfig indentation
Message-ID: <20191120164155.GR30416@phenom.ffwll.local>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20191120133911.13539-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120133911.13539-1-krzk@kernel.org>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 09:39:11PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I expect Greg will pick this up.
-Daniel

> ---
>  drivers/staging/fbtft/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/Kconfig b/drivers/staging/fbtft/Kconfig
> index d994aea84b21..19d9d88e9150 100644
> --- a/drivers/staging/fbtft/Kconfig
> +++ b/drivers/staging/fbtft/Kconfig
> @@ -95,8 +95,8 @@ config FB_TFT_PCD8544
>  	  Generic Framebuffer support for PCD8544
>  
>  config FB_TFT_RA8875
> -        tristate "FB driver for the RA8875 LCD Controller"
> -        depends on FB_TFT
> +	tristate "FB driver for the RA8875 LCD Controller"
> +	depends on FB_TFT
>  	help
>  	  Generic Framebuffer support for RA8875
>  
> @@ -132,10 +132,10 @@ config FB_TFT_SSD1289
>  	  Framebuffer support for SSD1289
>  
>  config FB_TFT_SSD1305
> -        tristate "FB driver for the SSD1305 OLED Controller"
> -        depends on FB_TFT
> -        help
> -          Framebuffer support for SSD1305
> +	tristate "FB driver for the SSD1305 OLED Controller"
> +	depends on FB_TFT
> +	help
> +	  Framebuffer support for SSD1305
>  
>  config FB_TFT_SSD1306
>  	tristate "FB driver for the SSD1306 OLED Controller"
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
