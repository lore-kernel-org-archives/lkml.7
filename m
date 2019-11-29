Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F4EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB63C217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575026843;
	bh=Iilf3hrD/jR1KBNLxX222L75uOcdkhT4b+H3i+gDWmI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ySaSeAYB9IYKJT01kjjmH1mxMLDGaJdK24LWfaSo0wfi31SGwwSMdc1c8G0Q6FiPx
	 dFQwvtcMTJ7T6UFSgbGeOf4kNENoa0lt6St6yG9CKrBpbFmr6HQvf4ODKub6Rn9bDW
	 URwjLEDNFzFg1EApeGH3O7v3lcz1zTSCGuPKaqcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfK2L1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 06:27:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfK2L1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:27:22 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91616217D7;
        Fri, 29 Nov 2019 11:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575026841;
        bh=Iilf3hrD/jR1KBNLxX222L75uOcdkhT4b+H3i+gDWmI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BHZjnUihMjmpd/O6zuY8XAdXYHWcLtxhVxNGaBN683jZGJJogCT0HvbqO6In/lAVR
         0xS6qejuFnXOORQtowqSOflyOvVzL7AUrUJ0hPz0LmyNKbe6TLApX39GZS7K7gddj0
         ZHQHB+9JgYY9YfRtVkG0f2xVvZzxncO2zqKygt3E=
Received: by mail-wm1-f46.google.com with SMTP id p17so8756583wma.1;
        Fri, 29 Nov 2019 03:27:21 -0800 (PST)
X-Gm-Message-State: APjAAAXfg22pxf7lmmcQaAxtiE3h82TGGVJmIZNluPxp04i6HdEVh56Y
        lRqiOubWXtZgoa2iB6nUVEgDfI8uS/5SCdLfMYw=
X-Google-Smtp-Source: APXvYqwS2mwgtsYX3Aw7PUZdbOQ5JmtZQ7Uc7XV3zHaMU8QX6wE0dUgWkooDMeqLXldNns133Yz+eBYsCwzRTYPJUgo=
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr13621996wmj.137.1575026840076;
 Fri, 29 Nov 2019 03:27:20 -0800 (PST)
MIME-Version: 1.0
References: <ca14f757-f191-62a0-b896-6b3ba0f9d168@infradead.org>
In-Reply-To: <ca14f757-f191-62a0-b896-6b3ba0f9d168@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 29 Nov 2019 19:27:08 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ52at-NUhA4dTqopHJbYA25wPdGB_fjvmwdiW1CzgkSA@mail.gmail.com>
Message-ID: <CAJF2gTQ52at-NUhA4dTqopHJbYA25wPdGB_fjvmwdiW1CzgkSA@mail.gmail.com>
Subject: Re: [PATCH] irqchip: cleanup Kconfig help text
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx

Acked-by: Guo Ren <guoren@kernel.org>

On Fri, Nov 29, 2019 at 6:42 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fixes to Kconfig help text:
>
> - spell out "hardware"
> - fix verb usage
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> ---
>  drivers/irqchip/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- lnx-54.orig/drivers/irqchip/Kconfig
> +++ lnx-54/drivers/irqchip/Kconfig
> @@ -434,7 +434,7 @@ config CSKY_MPINTC
>         help
>           Say yes here to enable C-SKY SMP interrupt controller driver used
>           for C-SKY SMP system.
> -         In fact it's not mmio map in hw and it use ld/st to visit the
> +         In fact it's not mmio map in hardware and it uses ld/st to visit the
>           controller's register inside CPU.
>
>  config CSKY_APB_INTC
> @@ -442,7 +442,7 @@ config CSKY_APB_INTC
>         depends on CSKY
>         help
>           Say yes here to enable C-SKY APB interrupt controller driver used
> -         by C-SKY single core SOC system. It use mmio map apb-bus to visit
> +         by C-SKY single core SOC system. It uses mmio map apb-bus to visit
>           the controller's register.
>
>  config IMX_IRQSTEER
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
