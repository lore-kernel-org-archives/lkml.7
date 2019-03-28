Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF61C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1953E2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UfrxNf01";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fsrHj7Hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfC1PCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:02:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1PCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:02:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A9178607C6; Thu, 28 Mar 2019 15:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553785320;
        bh=Iqza/yVbfqJqHRxQkyZMCJxensK7lBwhCsHgGkmd/fM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UfrxNf01pYm3NYtk8wQpzgTQUsmgCyLhiXWXgc87NsGvnyCGMh/2Ujjnt4UOQH3px
         WyzugkNtL1CHbxF0Dsrx4/G5Kq88k+HvA4ZjtuaezUfXH+n2bWYSecMLBymCYnGU67
         AVoUexHk9vlnYaHdZ9gMK7o1SCeDoFR71KIr1BX8=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3BF06087A;
        Thu, 28 Mar 2019 15:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553785316;
        bh=Iqza/yVbfqJqHRxQkyZMCJxensK7lBwhCsHgGkmd/fM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fsrHj7HxI/T6yUZ1b0slWczOx7qOEGgMDuWG8z9o2J4kG7mBHxThLCzN9wPajnHXK
         qEDwyNcV4Oke2DR6Qf3e2P+YdYar2vfQRf0SEjr1I9N8e08gzYQWvp309Are0B5lbX
         cVIYp3/Yw/a2/HBvGqw3YKD3yPTwNBXopCF5I4vQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3BF06087A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 3/3] gpio: Remove obsolete comment about
 gpiochip_free_hogs() usage
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Benoit Parrot <bparrot@ti.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190328131349.18838-1-geert+renesas@glider.be>
 <20190328131349.18838-4-geert+renesas@glider.be>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <ff6d95d6-9022-4cab-bc53-bb9ffd14ed68@codeaurora.org>
Date:   Thu, 28 Mar 2019 20:31:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328131349.18838-4-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 6:43 PM, Geert Uytterhoeven wrote:
> gpiochip_free_hogs() was always called from gpiochip_remove(), not
> of_gpiochip_remove().  It is now also called from the failure patch in
> gpiochip_add_data_with_key().
>
> Fixes: f625d4601759f1cf ("gpio: add GPIO hogging mechanism")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


Looks good to be removed.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   drivers/gpio/gpiolib.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index ed4da07effe0ac40..ec326bd84b1f1c50 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4449,8 +4449,6 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
>   /**
>    * gpiochip_free_hogs - Scan gpio-controller chip and release GPIO hog
>    * @chip:	gpio chip to act on
> - *
> - * This is only used by of_gpiochip_remove to free hogged gpios
>    */
>   static void gpiochip_free_hogs(struct gpio_chip *chip)
>   {
