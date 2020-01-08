Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93FAC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910E4206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgAHWCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 17:02:39 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44967 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgAHWCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:02:38 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so4075337oia.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 14:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O9YsXaP1lcVI3YB10D/1yLJh0lm8KzUFBjhvxrtn8yA=;
        b=L6dk+778guOePV7/2zJ4RGGUa5S9nkAHUKCY/COdaOLyPGGuGUoiD/pxMSaBLf79/M
         CEPgbE67bIeRoratpgXukcAafJyXoY6CSi+BOZzAS9Y11kY9q4Mi+DbOmEwcpI0SOn7Q
         F256WN8/3OeIuNNy3mNuhXOY4JLHNX1ecP43sioQxgdWKMG9AAyjz3qMu2yyr4oLBKia
         X1zRNFPLwsD+Pc0dumQ/1tOv4vYBpfGbQGSJue86r+0N9HYb+wNXlMliFc1Lddn6Hr6R
         D2nNacuWwZofehOaYbyqQFZ5N0nfjw6AG5/AYmWioHDEILYNmRGpgdQIaq4vrA8rxiPx
         W4AQ==
X-Gm-Message-State: APjAAAUZ/w/YaJdM9ywcdbYjPsnkBq6Tb8CHeh3su2+E/5688vTMPZkq
        x4ul7mFMWdB/yHLvAofZHR1q7mHx
X-Google-Smtp-Source: APXvYqz00Was+5QajFWaCMxi6DX4FhH5y61k8E69UlFx0gC1QaobyTz/EemvRd6d1bYmgbYkNK+vPQ==
X-Received: by 2002:aca:f305:: with SMTP id r5mr672553oih.174.1578520956985;
        Wed, 08 Jan 2020 14:02:36 -0800 (PST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id l17sm1629420ota.27.2020.01.08.14.02.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 14:02:36 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id d62so4075286oia.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 14:02:36 -0800 (PST)
X-Received: by 2002:aca:d887:: with SMTP id p129mr615231oig.51.1578520956285;
 Wed, 08 Jan 2020 14:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20200108130926.45808-1-yuehaibing@huawei.com>
In-Reply-To: <20200108130926.45808-1-yuehaibing@huawei.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 8 Jan 2020 16:02:25 -0600
X-Gmail-Original-Message-ID: <CADRPPNQp7KxENbr+nZ8AAZkuBW-=6sjeXd8LU2LJJZqjCvY==g@mail.gmail.com>
Message-ID: <CADRPPNQp7KxENbr+nZ8AAZkuBW-=6sjeXd8LU2LJJZqjCvY==g@mail.gmail.com>
Subject: Re: [PATCH -next] soc: fsl: qe: remove set but not used variable 'mm_gc'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Zhao Qiang <qiang.zhao@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 7:12 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> drivers/soc/fsl/qe/gpio.c: In function qe_pin_request:
> drivers/soc/fsl/qe/gpio.c:163:26: warning: variable mm_gc set but not used [-Wunused-but-set-variable]
>
> commit 1e714e54b5ca ("powerpc: qe_lib-gpio: use gpiochip data pointer")
> left behind this unused variable.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied for next.  Thanks.

Btw, I find another patch from Chen Zhou fixing the same problem sent
earlier.  I will add his signed-off-by to the commit for credit too.

Regards,
Leo

> ---
>  drivers/soc/fsl/qe/gpio.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/soc/fsl/qe/gpio.c b/drivers/soc/fsl/qe/gpio.c
> index 12bdfd9..ed75198 100644
> --- a/drivers/soc/fsl/qe/gpio.c
> +++ b/drivers/soc/fsl/qe/gpio.c
> @@ -160,7 +160,6 @@ struct qe_pin *qe_pin_request(struct device_node *np, int index)
>  {
>         struct qe_pin *qe_pin;
>         struct gpio_chip *gc;
> -       struct of_mm_gpio_chip *mm_gc;
>         struct qe_gpio_chip *qe_gc;
>         int err;
>         unsigned long flags;
> @@ -186,7 +185,6 @@ struct qe_pin *qe_pin_request(struct device_node *np, int index)
>                 goto err0;
>         }
>
> -       mm_gc = to_of_mm_gpio_chip(gc);
>         qe_gc = gpiochip_get_data(gc);
>
>         spin_lock_irqsave(&qe_gc->lock, flags);
> --
> 2.7.4
>
>
