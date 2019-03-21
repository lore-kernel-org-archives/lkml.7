Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADD5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DED218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mxFCtm3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfCUB7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:59:23 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:25766 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfCUB7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:59:22 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x2L1wvh1007736
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:58:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2L1wvh1007736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553133538;
        bh=q6xxiJaLA6RIJqo1ZxOt+K04UNxuMynzKCPZN8ep1fI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mxFCtm3HnKFUlt5DPMLpHgQpgMloXNckJgPYtdli1Ch+GC2vzSo+K72WRUQGwqZsz
         5qrLy8FkfjLGDWN5dnxzAMe1jz42PdprAiirxm9K3NSlyUPcAsA7gEgLg1XHDjaiXb
         D1Lwt9KiUyI3WA1EHeIN4YVdnKT+0fpmm4OfhIpkKGQrLIIaGGXseY9GZqpaUWsnwc
         7R0OeW7QkLyNOGLByPBjlTe563lM45hcgqgs3JvupJPnbfCREfYBq8bvqlOvJcfhTk
         n8h6wefzv4AdfNbn2PbxWtXGUThHE2HPXSlaMG+lWf5ut2OtZh8o6tade6SuDPMzbO
         4Qgtlo0CagGsQ==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id g127so2795440vsd.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:58:57 -0700 (PDT)
X-Gm-Message-State: APjAAAXWtYsDhaD8PpC/bUFOgoFJ5edmWPyLytHwWpLFGfEipps1M73S
        JrlF/pJ6AVPDeFEEqgQwxr+r6oMJ1PoDLL+u1rQ=
X-Google-Smtp-Source: APXvYqyTCLbkrpvOR5u8RdbVUPbbG1aDgG4qtAFKffyty9iNVJzVKGfhquehHMdMNjk14nc/3s2wOxyI7tgZboiI9TA=
X-Received: by 2002:a67:7a43:: with SMTP id v64mr529590vsc.54.1553133536536;
 Wed, 20 Mar 2019 18:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <1552310346-7629-1-git-send-email-info@metux.net> <1552310346-7629-80-git-send-email-info@metux.net>
In-Reply-To: <1552310346-7629-80-git-send-email-info@metux.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 21 Mar 2019 10:58:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNASho5hboMEjnigfR+4gRKTL1EAs4r4_atfWEezbnXJiOw@mail.gmail.com>
Message-ID: <CAK7LNASho5hboMEjnigfR+4gRKTL1EAs4r4_atfWEezbnXJiOw@mail.gmail.com>
Subject: Re: [PATCH 079/114] drivers: char: Kconfig: pedantic formatting
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:23 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Formatting of Kconfig files doesn't look so pretty, so let the
> Great White Handkerchief come around and clean it up.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/char/Kconfig           | 24 +++++-----


While you are touching this file,
why don't you fix checkpatch.pl warnings?


WARNING: prefer 'help' over '---help---' for new help texts
#54: FILE: drivers/char/Kconfig:54:
+config TTY_PRINTK

WARNING: prefer 'help' over '---help---' for new help texts
#77: FILE: drivers/char/Kconfig:77:
+config PRINTER

WARNING: prefer 'help' over '---help---' for new help texts
#120: FILE: drivers/char/Kconfig:120:
+config PPDEV

WARNING: prefer 'help' over '---help---' for new help texts
#245: FILE: drivers/char/Kconfig:245:
+config NVRAM

WARNING: prefer 'help' over '---help---' for new help texts
#274: FILE: drivers/char/Kconfig:274:
+config RTC

WARNING: prefer 'help' over '---help---' for new help texts
#300: FILE: drivers/char/Kconfig:300:
+config JS_RTC



>  drivers/char/agp/Kconfig       | 13 +++---
>  drivers/char/hw_random/Kconfig | 24 +++++-----
>  drivers/char/ipmi/Kconfig      | 99 +++++++++++++++++++++---------------------
>  4 files changed, 80 insertions(+), 80 deletions(-)
>
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 72866a0..ab33583 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -35,18 +35,18 @@ config SGI_SNSC
>           say Y.  Otherwise, say N.
>
>  config SGI_TIOCX
> -       bool "SGI TIO CX driver support"
> -       depends on (IA64_SGI_SN2 || IA64_GENERIC)
> -       help
> -         If you have an SGI Altix and you have fpga devices attached
> -         to your TIO, say Y here, otherwise say N.
> +       bool "SGI TIO CX driver support"
> +       depends on (IA64_SGI_SN2 || IA64_GENERIC)
> +       help
> +         If you have an SGI Altix and you have fpga devices attached
> +         to your TIO, say Y here, otherwise say N.
>
>  config SGI_MBCS
> -       tristate "SGI FPGA Core Services driver support"
> -       depends on SGI_TIOCX
> -       help
> -         If you have an SGI Altix with an attached SABrick
> -         say Y or M here, otherwise say N.
> +       tristate "SGI FPGA Core Services driver support"
> +       depends on SGI_TIOCX
> +       help
> +         If you have an SGI Altix with an attached SABrick
> +         say Y or M here, otherwise say N.
>
>  source "drivers/tty/serial/Kconfig"
>  source "drivers/tty/serdev/Kconfig"
> @@ -461,8 +461,8 @@ config RAW_DRIVER
>           Once bound, I/O against /dev/raw/rawN uses efficient zero-copy I/O.
>           See the raw(8) manpage for more details.
>
> -          Applications should preferably open the device (eg /dev/hda1)
> -          with the O_DIRECT flag.
> +         Applications should preferably open the device (eg /dev/hda1)
> +         with the O_DIRECT flag.
>
>  config MAX_RAW_DEVS
>         int "Maximum number of RAW devices to support (1-65536)"
> diff --git a/drivers/char/agp/Kconfig b/drivers/char/agp/Kconfig
> index 6231714..6da28d5 100644
> --- a/drivers/char/agp/Kconfig
> +++ b/drivers/char/agp/Kconfig
> @@ -63,7 +63,7 @@ config AGP_AMD64
>           This option gives you AGP support for the GLX component of
>           X using the on-CPU northbridge of the AMD Athlon64/Opteron CPUs.
>           You still need an external AGP bridge like the AMD 8151, VIA
> -          K8T400M, SiS755. It may also support other AGP bridges when loaded
> +         K8T400M, SiS755. It may also support other AGP bridges when loaded
>           with agp_try_unsupported=1.
>
>  config AGP_INTEL
> @@ -151,13 +151,12 @@ config AGP_EFFICEON
>           series processors with integrated northbridges.
>
>  config AGP_SGI_TIOCA
> -        tristate "SGI TIO chipset AGP support"
> -        depends on AGP && (IA64_SGI_SN2 || IA64_GENERIC)
> -        help
> -          This option gives you AGP GART support for the SGI TIO chipset
> -          for IA64 processors.
> +       tristate "SGI TIO chipset AGP support"
> +       depends on AGP && (IA64_SGI_SN2 || IA64_GENERIC)
> +       help
> +         This option gives you AGP GART support for the SGI TIO chipset
> +         for IA64 processors.
>
>  config INTEL_GTT
>         tristate
>         depends on X86 && PCI
> -
> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index 25a7d8f..6265931 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -156,15 +156,15 @@ config HW_RANDOM_OMAP
>         tristate "OMAP Random Number Generator support"
>         depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS || ARCH_MVEBU
>         default HW_RANDOM
> -       ---help---
> -         This driver provides kernel-side support for the Random Number
> +       ---help---
> +         This driver provides kernel-side support for the Random Number
>           Generator hardware found on OMAP16xx, OMAP2/3/4/5, AM33xx/AM43xx
>           multimedia processors, and Marvell Armada 7k/8k SoCs.
>
>           To compile this driver as a module, choose M here: the
>           module will be called omap-rng.
>
> -         If unsure, say Y.
> +         If unsure, say Y.
>
>  config HW_RANDOM_OMAP3_ROM
>         tristate "OMAP3 ROM Random Number Generator support"
> @@ -372,17 +372,17 @@ config HW_RANDOM_MESON
>           If unsure, say Y.
>
>  config HW_RANDOM_CAVIUM
> -       tristate "Cavium ThunderX Random Number Generator support"
> -       depends on HW_RANDOM && PCI && (ARM64 || (COMPILE_TEST && 64BIT))
> -       default HW_RANDOM
> -       ---help---
> -         This driver provides kernel-side support for the Random Number
> -         Generator hardware found on Cavium SoCs.
> +       tristate "Cavium ThunderX Random Number Generator support"
> +       depends on HW_RANDOM && PCI && (ARM64 || (COMPILE_TEST && 64BIT))
> +       default HW_RANDOM
> +       ---help---
> +         This driver provides kernel-side support for the Random Number
> +         Generator hardware found on Cavium SoCs.
>
> -         To compile this driver as a module, choose M here: the
> -         module will be called cavium_rng.
> +         To compile this driver as a module, choose M here: the
> +         module will be called cavium_rng.
>
> -         If unsure, say Y.
> +         If unsure, say Y.
>
>  config HW_RANDOM_MTK
>         tristate "Mediatek Random Number Generator support"
> diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
> index 94719fc..b6219c3 100644
> --- a/drivers/char/ipmi/Kconfig
> +++ b/drivers/char/ipmi/Kconfig
> @@ -1,40 +1,41 @@
> +
>  #
>  # IPMI device configuration
>  #
>
>  menuconfig IPMI_HANDLER
> -       tristate 'IPMI top-level message handler'
> -       depends on HAS_IOMEM
> -       select IPMI_DMI_DECODE if DMI
> -       help
> -         This enables the central IPMI message handler, required for IPMI
> -        to work.
> +       tristate 'IPMI top-level message handler'
> +       depends on HAS_IOMEM
> +       select IPMI_DMI_DECODE if DMI
> +       help
> +         This enables the central IPMI message handler, required for IPMI
> +         to work.
>
> -         IPMI is a standard for managing sensors (temperature,
> -         voltage, etc.) in a system.
> +         IPMI is a standard for managing sensors (temperature,
> +         voltage, etc.) in a system.
>
> -         See <file:Documentation/IPMI.txt> for more details on the driver.
> +         See <file:Documentation/IPMI.txt> for more details on the driver.
>
> -        If unsure, say N.
> +         If unsure, say N.
>
>  config IPMI_DMI_DECODE
> -       select IPMI_PLAT_DATA
> -       bool
> +       select IPMI_PLAT_DATA
> +       bool
>
>  config IPMI_PLAT_DATA
> -       bool
> +       bool
>
>  if IPMI_HANDLER
>
>  config IPMI_PANIC_EVENT
> -       bool 'Generate a panic event to all BMCs on a panic'
> -       help
> -        When a panic occurs, this will cause the IPMI message handler to,
> -        by default, generate an IPMI event describing the panic to each
> -        interface registered with the message handler.  This is always
> -        available, the module parameter for ipmi_msghandler named
> -        panic_op can be set to "event" to chose this value, this config
> -        simply causes the default value to be set to "event".
> +       bool 'Generate a panic event to all BMCs on a panic'
> +       help
> +         When a panic occurs, this will cause the IPMI message handler to,
> +         by default, generate an IPMI event describing the panic to each
> +         interface registered with the message handler.  This is always
> +         available, the module parameter for ipmi_msghandler named
> +         panic_op can be set to "event" to chose this value, this config
> +         simply causes the default value to be set to "event".
>
>  config IPMI_PANIC_STRING
>         bool 'Generate OEM events containing the panic string'
> @@ -53,43 +54,43 @@ config IPMI_PANIC_STRING
>           causes the default value to be set to "string".
>
>  config IPMI_DEVICE_INTERFACE
> -       tristate 'Device interface for IPMI'
> -       help
> -         This provides an IOCTL interface to the IPMI message handler so
> -        userland processes may use IPMI.  It supports poll() and select().
> +       tristate 'Device interface for IPMI'
> +       help
> +         This provides an IOCTL interface to the IPMI message handler so
> +         userland processes may use IPMI.  It supports poll() and select().
>
>  config IPMI_SI
> -       tristate 'IPMI System Interface handler'
> -       select IPMI_PLAT_DATA
> -       help
> -         Provides a driver for System Interfaces (KCS, SMIC, BT).
> -        Currently, only KCS and SMIC are supported.  If
> -        you are using IPMI, you should probably say "y" here.
> +       tristate 'IPMI System Interface handler'
> +       select IPMI_PLAT_DATA
> +       help
> +         Provides a driver for System Interfaces (KCS, SMIC, BT).
> +         Currently, only KCS and SMIC are supported.  If
> +         you are using IPMI, you should probably say "y" here.
>
>  config IPMI_SSIF
> -       tristate 'IPMI SMBus handler (SSIF)'
> -       select I2C
> -       help
> -         Provides a driver for a SMBus interface to a BMC, meaning that you
> -        have a driver that must be accessed over an I2C bus instead of a
> -        standard interface.  This module requires I2C support.
> +       tristate 'IPMI SMBus handler (SSIF)'
> +       select I2C
> +       help
> +         Provides a driver for a SMBus interface to a BMC, meaning that you
> +         have a driver that must be accessed over an I2C bus instead of a
> +         standard interface.  This module requires I2C support.
>
>  config IPMI_POWERNV
> -       depends on PPC_POWERNV
> -       tristate 'POWERNV (OPAL firmware) IPMI interface'
> -       help
> -         Provides a driver for OPAL firmware-based IPMI interfaces.
> +       depends on PPC_POWERNV
> +       tristate 'POWERNV (OPAL firmware) IPMI interface'
> +       help
> +         Provides a driver for OPAL firmware-based IPMI interfaces.
>
>  config IPMI_WATCHDOG
> -       tristate 'IPMI Watchdog Timer'
> -       help
> -         This enables the IPMI watchdog timer.
> +       tristate 'IPMI Watchdog Timer'
> +       help
> +         This enables the IPMI watchdog timer.
>
>  config IPMI_POWEROFF
> -       tristate 'IPMI Poweroff'
> -       help
> -         This enables a function to power off the system with IPMI if
> -        the IPMI management controller is capable of this.
> +       tristate 'IPMI Poweroff'
> +       help
> +         This enables a function to power off the system with IPMI if
> +         the IPMI management controller is capable of this.
>
>  endif # IPMI_HANDLER
>
> @@ -125,7 +126,7 @@ config NPCM7XX_KCS_IPMI_BMC
>
>  config ASPEED_BT_IPMI_BMC
>         depends on ARCH_ASPEED || COMPILE_TEST
> -       depends on REGMAP && REGMAP_MMIO && MFD_SYSCON
> +       depends on REGMAP && REGMAP_MMIO && MFD_SYSCON
>         tristate "BT IPMI bmc driver"
>         help
>           Provides a driver for the BT (Block Transfer) IPMI interface
> --
> 1.9.1
>


-- 
Best Regards
Masahiro Yamada
