Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F61BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EF120850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZeEomQld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCRKw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:52:27 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41891 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfCRKw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:52:27 -0400
Received: by mail-vs1-f65.google.com with SMTP id z25so7834461vsk.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBTfIZ6un7jxulZIQesvAljvLL7ZVElbdSpBztSchT8=;
        b=ZeEomQld34vgmOjtjzRwfszuliFAnTLWrYVA0pruO5vJfys1R6uxcYvOO2Sw/flYFK
         33UkougaQeOjiImfa7ALAk8rSZ0SHbQKgiO5k9+3QT5sUU/LCbL1uFrT1SOu6tkdziq/
         P6P0MqlCwxt/SMSwZ26hLTVuslCNf5n/nfu2QPLH1jwgE2ZsayfhIFWqvbjEqFTLidMg
         jiXang6gaNFFv8HliKPZYHDh4b40FChaGPgvjmL2s0qvJn4uOB/HRnebt2E3L91X1egP
         mQVViwhG6EraUBOOSzPi6QLO9ClqmlwEjBfLAb31fOSGMjwAR6VA8dlKE7sAPMJZwqEA
         LnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBTfIZ6un7jxulZIQesvAljvLL7ZVElbdSpBztSchT8=;
        b=QrAlp0d5TfbBeZVl74DGzfxE1qU1513/IM+oJgNllhzLKEgIh961eOWYPTsaEGcPlq
         Jlgw+fsSw2UalVJz0xVCWyeBucyIgRkGojvk/SYI8YULdtioRNQWfEVg4Cq/kVDWOIRX
         K6iFz/4cRIHk0wdy7Qx0TaAmJCaK3vKw1T8eOjL4+VfJCD00987Ho2HVT2RffGK6WJqD
         kPchkkoRKlCtcWakntNTi6hjJMorajP8reOFVl9xzmSdrxONePfuI2XuTynwS0DPeOnB
         5agfu8C2h9qWxhHWx7ZWWF4v1PsPhww/+C87e3tdH+cRuABuWqKCqut6nvMViR3cRMp2
         zd+Q==
X-Gm-Message-State: APjAAAWaWuI9X+cySgAlH1XHlumMmUMTantp8L1Ae7xlACeElJb7p8Lp
        DQUEHWzB5pNkqLJuIUCViKUaL3OChSY+K+URFiIsLQ==
X-Google-Smtp-Source: APXvYqzmJBgTbxNgRSMtJMoNmue1glXuCUfW5BhnocFERmG1X9HcnkLdMATxNIz63AE3f6SklyP6/vGdlXW006PidI8=
X-Received: by 2002:a67:7b52:: with SMTP id w79mr5238600vsc.200.1552906345919;
 Mon, 18 Mar 2019 03:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <1551896871-30654-1-git-send-email-info@metux.net>
In-Reply-To: <1551896871-30654-1-git-send-email-info@metux.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Mar 2019 11:51:50 +0100
Message-ID: <CAPDyKFqheGy3hsqurabG0m7fmURkUThJDw2p4JhBQzi9yUMUWQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: mmc: Kconfig: pedantic cleanups
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2019 at 19:27, Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 43 ++++++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 28fcd8f..de7a38d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -437,7 +437,7 @@ config MMC_WBSD
>         depends on ISA_DMA_API
>         help
>           This selects the Winbond(R) W83L51xD Secure digital and
> -          Multimedia card Interface.
> +         Multimedia card Interface.
>           If you have a machine with a integrated W83L518D or W83L519D
>           SD/MMC card reader, say Y or M here.
>
> @@ -515,7 +515,7 @@ config MMC_TIFM_SD
>           'Misc devices: TI Flash Media PCI74xx/PCI76xx host adapter support
>           (TIFM_7XX1)'.
>
> -          To compile this driver as a module, choose M here: the
> +         To compile this driver as a module, choose M here: the
>           module will be called tifm_sd.
>
>  config MMC_MVSDIO
> @@ -531,12 +531,12 @@ config MMC_MVSDIO
>           module will be called mvsdio.
>
>  config MMC_DAVINCI
> -        tristate "TI DAVINCI Multimedia Card Interface support"
> -        depends on ARCH_DAVINCI
> -        help
> -          This selects the TI DAVINCI Multimedia card Interface.
> -          If you have an DAVINCI board with a Multimedia Card slot,
> -          say Y or M here.  If unsure, say N.
> +       tristate "TI DAVINCI Multimedia Card Interface support"
> +       depends on ARCH_DAVINCI
> +       help
> +         This selects the TI DAVINCI Multimedia card Interface.
> +         If you have an DAVINCI board with a Multimedia Card slot,
> +         say Y or M here.  If unsure, say N.
>
>  config MMC_GOLDFISH
>         tristate "goldfish qemu Multimedia Card Interface support"
> @@ -565,18 +565,18 @@ config MMC_S3C
>         depends on S3C24XX_DMAC
>         help
>           This selects a driver for the MCI interface found in
> -          Samsung's S3C2410, S3C2412, S3C2440, S3C2442 CPUs.
> +         Samsung's S3C2410, S3C2412, S3C2440, S3C2442 CPUs.
>           If you have a board based on one of those and a MMC/SD
>           slot, say Y or M here.
>
>           If unsure, say N.
>
>  config MMC_S3C_HW_SDIO_IRQ
> -       bool "Hardware support for SDIO IRQ"
> -       depends on MMC_S3C
> -       help
> -         Enable the hardware support for SDIO interrupts instead of using
> -        the generic polling code.
> +       bool "Hardware support for SDIO IRQ"
> +       depends on MMC_S3C
> +       help
> +         Enable the hardware support for SDIO interrupts instead of using
> +         the generic polling code.
>
>  choice
>         prompt "Samsung S3C SD/MMC transfer code"
> @@ -948,15 +948,16 @@ config MMC_MTK
>           If unsure, say N.
>
>  config MMC_SDHCI_MICROCHIP_PIC32
> -        tristate "Microchip PIC32MZDA SDHCI support"
> -        depends on MMC_SDHCI && PIC32MZDA && MMC_SDHCI_PLTFM
> -        help
> -          This selects the Secure Digital Host Controller Interface (SDHCI)
> -          for PIC32MZDA platform.
> +       tristate "Microchip PIC32MZDA SDHCI support"
> +       depends on MMC_SDHCI && PIC32MZDA && MMC_SDHCI_PLTFM
> +       help
> +         This selects the Secure Digital Host Controller Interface (SDHCI)
> +         for PIC32MZDA platform.
> +
> +         If you have a controller with this interface, say Y or M here.
>
> -          If you have a controller with this interface, say Y or M here.
> +         If unsure, say N.
>
> -          If unsure, say N.
>  config MMC_SDHCI_BRCMSTB
>         tristate "Broadcom SDIO/SD/MMC support"
>         depends on ARCH_BRCMSTB || BMIPS_GENERIC
> --
> 1.9.1
>
