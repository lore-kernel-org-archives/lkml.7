Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA2DC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F67217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575026918;
	bh=Sp1rQo4vS2cL79PohOTZ96rX79Fc80nM1x1JRQjcAzM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bxZ3+M74/Z2s6zH1/4x87EMvaw5Omtgub8isLVO8RY3cNIJBdwqtqu5zL/wTCMIue
	 26iBZkwQCDByaeENTyfA0OmZiaLwB7HxRHCZgnQkDd9LB7oCGhJ2puMxYr5M4o6dQG
	 2O0mWmSDd+Fb//hEhka2oZD7P9zeZ72dQCh5ZR4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfK2L2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 06:28:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfK2L2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:28:36 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1240C217BA;
        Fri, 29 Nov 2019 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575026916;
        bh=Sp1rQo4vS2cL79PohOTZ96rX79Fc80nM1x1JRQjcAzM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ObV7GKN9VDo4J+ly3oBDxVKh1HeJ47luUeavGnNTQCH6EL5DnNfnn5pBvhUkSNJcs
         Qwxlqlku6vynRW5iEXXLCae1FRqlrM+J09crqAgPCIuLfDpCb8WGKt9qYW+5xQEdrf
         ynMdPcKrBKrY1EF/tKlloUGVpZGWuIPBksdSQdMI=
Received: by mail-wr1-f43.google.com with SMTP id y11so31607577wrt.6;
        Fri, 29 Nov 2019 03:28:36 -0800 (PST)
X-Gm-Message-State: APjAAAVYAJfUIOeO09j9VOc9wLD1khUns6o2ppsb50zKDKS52ZY8oYeW
        E8/oTr8ur1caDtNUTwlv/MIIp1Ttf0/4xoGUmHU=
X-Google-Smtp-Source: APXvYqzT48oRhMPn2aR+ywlkaFS6xk7qiRLBWSEbe8ICvFF0Ctujo3UnyLtsvchCnROTYjVeE1DlAET98nArgjnpLhc=
X-Received: by 2002:adf:ba4f:: with SMTP id t15mr50391275wrg.24.1575026914574;
 Fri, 29 Nov 2019 03:28:34 -0800 (PST)
MIME-Version: 1.0
References: <87922baa-223a-345d-38ac-be5a94d15b34@infradead.org>
In-Reply-To: <87922baa-223a-345d-38ac-be5a94d15b34@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 29 Nov 2019 19:28:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTKTpSuOW+BP6Dz7SiJrgJ8MVeRi1Oxa08vzPy=RGPb9w@mail.gmail.com>
Message-ID: <CAJF2gTTKTpSuOW+BP6Dz7SiJrgJ8MVeRi1Oxa08vzPy=RGPb9w@mail.gmail.com>
Subject: Re: [PATCH] clocksource: minor Kconfig help text fixes
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx

Acked-by: Guo Ren <guoren@kernel.org>

On Fri, Nov 29, 2019 at 6:40 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Minor cleanups in Kconfig help text:
>
> - End a sentence with a period.
> - Fix verb grammar.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> ---
>  drivers/clocksource/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- lnx-54.orig/drivers/clocksource/Kconfig
> +++ lnx-54/drivers/clocksource/Kconfig
> @@ -312,7 +312,7 @@ config ARC_TIMERS_64BIT
>         depends on ARC_TIMERS
>         select TIMER_OF
>         help
> -         This enables 2 different 64-bit timers: RTC (for UP) and GFRC (for SMP)
> +         This enables 2 different 64-bit timers: RTC (for UP) and GFRC (for SMP).
>           RTC is implemented inside the core, while GFRC sits outside the core in
>           ARConnect IP block. Driver automatically picks one of them for clocksource
>           as appropriate.
> @@ -666,7 +666,7 @@ config CSKY_MP_TIMER
>           Say yes here to enable C-SKY SMP timer driver used for C-SKY SMP
>           system.
>           csky,mptimer is not only used in SMP system, it also could be used
> -         single core system. It's not a mmio reg and it use mtcr/mfcr instruction.
> +         single core system. It's not a mmio reg and it uses mtcr/mfcr instruction.
>
>  config GX6605S_TIMER
>         bool "Gx6605s SOC system timer driver" if COMPILE_TEST
>
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
