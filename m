Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5890AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F7D213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554107160;
	bh=+7pxoFwzBbeVpHVFDjmTbM/6TSTDNdHpQuJR18EOffI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wb3H05wVjjlpqd7rcNLnPeo8pajSWr1E1LTM8lL5Kgz9+MGFGPNRvua9Gs18talMM
	 Uqd0tiBaPesnmjpYahpE0P2tZZy0rEF8XS6/PbsDuwu2nhPTSHW+ZllY/WBf0PVjtw
	 G4IrnsRwzya4Ls9wfnCsmeNFBVbebK+0+1ruPuRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbfDAIZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:25:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44094 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDAIZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:25:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id i21so6510912oib.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 01:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCUvj5v9YN/JLegBKdD1Gm2XVmH+w+GlG9TOQ8vBg8I=;
        b=PTrY0Mz67/8kLf0+sGBucu6iTmS/+P6CM+DcK47O0drzALiR2K1/xSAX5mlwspLybe
         4sV8lzd9+fiL+rwiHCDSCjTtlh0u5QcY37Z95N94ThPTMwEwM2xlpRH3Z60xrRy1ikk7
         jjvXSOTRkooTdQNYEo2mfPg9YIppK1/2aafcIclvEEN7HqVkzsX//UZb8Km+h0Qoa29D
         gcTrUBR29Qs8Jq3E/NI63LvN6zzmtgOf3ZFVTfc/io62u5a45tageTejJ+USeK6B8SJb
         NXYGfkvxVRy2feycz4tSLjVRx7HmtM7Lw+ujczPud/GUqqxX+cLXoBG0VkVSe1DHR8x1
         HtfA==
X-Gm-Message-State: APjAAAU6ljP73BTPqJSwcYS1J8jVjTgPPjd1/0MAaP9eM6Z2wm7+x9Rq
        E3k33yhEy5PKU06xIgVrWyD9rRhSLXW1A4/qxgw=
X-Google-Smtp-Source: APXvYqzcjqzXYhNlAg0DbIElRw5S+CexpPjeof22cBslfpKj63oZzsRinvg1cs99+MRFNwH4nVH37rgtBHgdIchQE/o=
X-Received: by 2002:aca:5c55:: with SMTP id q82mr12109734oib.95.1554107157167;
 Mon, 01 Apr 2019 01:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190401081635.18673-1-brgl@bgdev.pl>
In-Reply-To: <20190401081635.18673-1-brgl@bgdev.pl>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Apr 2019 10:25:46 +0200
Message-ID: <CAJZ5v0gV_4ha=34_LJ=E93jZoHWXa-HKwghWVv2s-=T94e0tEA@mail.gmail.com>
Subject: Re: [PATCH] drivers: fix a typo in the kernel doc for devm_platform_ioremap_resource()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 10:16 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> It should have been 'management' not 'managemend'.
>
> Fixes: 7945f929f1a7 ("drivers: provide devm_platform_ioremap_resource()")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index dab0a5abc391..09c00d91094c 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -84,7 +84,7 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
>   *                                 device
>   *
>   * @pdev: platform device to use both for memory resource lookup as well as
> - *        resource managemend
> + *        resource management
>   * @index: resource index
>   */
>  #ifdef CONFIG_HAS_IOMEM
> --
> 2.21.0
>
