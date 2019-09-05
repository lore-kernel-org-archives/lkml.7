Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8BBC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8F12070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbfIEIqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:46:43 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43626 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730939AbfIEIqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:46:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id l22so1818944qtp.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 01:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oU23zAL/N+Ma8FZV6NAbDVEqiCsbZP7Og2jqHKI2JsY=;
        b=exOdZpW34elSNLazLc5hy6ml6rNwwe8fQ+FkfR+u0zpb/3RIszlfzk3fH2LfMCm+Eb
         xwrMlAkdqOCSWfvAPhQNKTiQ/7xXL/F2Md/fqfKe7z8SM0sTw2pqMnRNkMp5MU3MkqvC
         9VjFOoZ8xf29MHIqzrOgFb2LNAkhdKfrb5ICdOqvvEAReeidFzv3ph45sy9M8H0mmxIN
         KqzaKKb2BM6qKMuK9Tw9Y7eNPf1iEsKxTO0E094Lf0Qz6YQLmX/WEQmvsE4AxhocJELz
         giDuKAFWltFfSxNoxZwhTsnE/Xr6SubM9UDsT7XbIUT4w0TZncTzkBEYn/XX6utvmf/H
         JP2w==
X-Gm-Message-State: APjAAAVDtr84T5lVmfrpwuUxQWeE8DX4w/TmdeehPJktWXylA0/0bmI9
        Rj8cRxjxV9ssIJsbF3ilzhB1FIHeCl5sEuDfbkM=
X-Google-Smtp-Source: APXvYqwHZt8+VmciZMOYqsyHGZy8by/RDPCCDgJEQ03Y6xz58WGJThkLJ6UzGa9tlxugPttAU94K323ixEwAjDZ4TDs=
X-Received: by 2002:ac8:6b1a:: with SMTP id w26mr2277080qts.304.1567673201828;
 Thu, 05 Sep 2019 01:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190905081140.1428-1-james.tai@realtek.com>
In-Reply-To: <20190905081140.1428-1-james.tai@realtek.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Sep 2019 10:46:25 +0200
Message-ID: <CAK8P3a2j2m0mUPLDe5G19Xzu2t+xbO4QWvg=PdQWnGoqTkDpsg@mail.gmail.com>
Subject: Re: [PATCH] ARM: config: Add Realtek RTD16XX defconfig
To:     jamestai.sky@gmail.com
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        CY_Huang <cy.huang@realtek.com>,
        "james.tai" <james.tai@realtek.com>,
        Russell King <linux@armlinux.org.uk>,
        Phinex Hung <phinex@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 10:14 AM <jamestai.sky@gmail.com> wrote:
>
> From: "james.tai" <james.tai@realtek.com>
>
> Add a defconfig for Realtek RTD16XX platform.
>
> Signed-off-by: james.tai <james.tai@realtek.com>
> ---
>  arch/arm/configs/rtd16xx_defconfig | 427 +++++++++++++++++++++++++++++

We usually try to have one defconfig per vendor. Expecting that
there will be other Realtek SoCs in the future that we may add
here, I would name this 'rtd_defconfig' or 'realtek_defconfig'.

Please also add the set of options you want to multi_v7_defconfig
so you are able to boot with that.

>  1 file changed, 427 insertions(+)
>  create mode 100644 arch/arm/configs/rtd16xx_defconfig
>
> diff --git a/arch/arm/configs/rtd16xx_defconfig b/arch/arm/configs/rtd16xx_defconfig
> new file mode 100644
> index 000000000000..49bcbe6c6af8
> --- /dev/null
> +++ b/arch/arm/configs/rtd16xx_defconfig
> @@ -0,0 +1,427 @@
> +CONFIG_SYSVIPC=y
> +CONFIG_NO_HZ=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_CGROUPS=y
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_EMBEDDED=y

I normally would not turn on CONFIG_EMBEDDED, this is only
needed to change some rare options.

> +CONFIG_PERF_EVENTS=y
> +CONFIG_ARCH_REALTEK=y
> +CONFIG_ARCH_RTD16XX=y
> +CONFIG_ARM_THUMBEE=y

ThumbEE is deprecated in ARMv8, and one usually should not
rely on it. If you don't actually need it, just turn it off.

(note: this is unrelated to regular thumb execution, which
is enabled by default)

> +# CONFIG_CACHE_L2X0 is not set
> +# CONFIG_ARM_ERRATA_643719 is not set
> +CONFIG_ARM_ERRATA_814220=y
> +CONFIG_SMP=y
> +CONFIG_SCHED_MC=y
> +CONFIG_SCHED_SMT=y

If you don't have SMT in the CPU, there is no need ot enable this.

> +CONFIG_HAVE_ARM_ARCH_TIMER=y
> +CONFIG_MCPM=y
> +CONFIG_NR_CPUS=6
> +CONFIG_HZ_250=y
> +CONFIG_OABI_COMPAT=y

It seems unlikely you want OABI_COMPAT

> +CONFIG_HIGHMEM=y
> +CONFIG_FORCE_MAX_ZONEORDER=12
> +CONFIG_SECCOMP=y
> +CONFIG_ARM_APPENDED_DTB=y
> +CONFIG_ARM_ATAG_DTB_COMPAT=y
> +CONFIG_KEXEC=y
> +CONFIG_EFI=y

What method do you actually use for booting? New platforms
should generally not require CONFIG_ARM_APPENDED_DTB
or CONFIG_ARM_ATAG_DTB_COMPAT, and I suspect you
don't use EFI.

> +CONFIG_CPUFREQ_DT=y
> +CONFIG_QORIQ_CPUFREQ=y

QORIQ_CPUFREQ is a platform specific option that you
won't need.

> +CONFIG_NET_DSA=m
> +CONFIG_CAN=y
> +CONFIG_CAN_FLEXCAN=m
> +CONFIG_CAN_RCAR=m
> +CONFIG_BT=m
> +CONFIG_BT_HCIUART=m
> +CONFIG_BT_HCIUART_BCM=y
> +CONFIG_BT_MRVL=m
> +CONFIG_BT_MRVL_SDIO=m

Many more hardware specific drivers here that you should turn off

> +CONFIG_MTD=y
> +CONFIG_MTD_CMDLINE_PARTS=y
> +CONFIG_MTD_BLOCK=y
> +CONFIG_MTD_CFI=y
> +CONFIG_MTD_PHYSMAP=y
> +CONFIG_MTD_PHYSMAP_OF=y
> +CONFIG_MTD_RAW_NAND=y
> +CONFIG_MTD_NAND_DENALI_DT=y
> +CONFIG_MTD_NAND_BRCMNAND=y

and here.

> +CONFIG_BLK_DEV_LOOP=y
> +CONFIG_BLK_DEV_RAM=y
> +CONFIG_BLK_DEV_RAM_SIZE=65536

Do you require BLK_DEV_RAM for initrd? Normally one uses
initramfs instead or tmpfs instead.

> +# CONFIG_NET_VENDOR_3COM is not set
> +# CONFIG_NET_VENDOR_ADAPTEC is not set
> +# CONFIG_NET_VENDOR_AGERE is not set
> +# CONFIG_NET_VENDOR_ALACRITECH is not set
> +# CONFIG_NET_VENDOR_ALTEON is not set

I would trim the list here, just leave all network device vendors
enabled, they don't hurt.

> +CONFIG_USB_PEGASUS=y
> +CONFIG_USB_RTL8152=m
> +CONFIG_USB_LAN78XX=m
> +CONFIG_USB_USBNET=y
> +CONFIG_USB_NET_SMSC75XX=y
> +CONFIG_USB_NET_SMSC95XX=y
> +CONFIG_BRCMFMAC=m
> +CONFIG_MWIFIEX=m
> +CONFIG_MWIFIEX_SDIO=m
> +CONFIG_RT2X00=m
> +CONFIG_RT2800USB=m

Do you need all of the above? It's no problem to enable
them if you do, it just seems unusual.

        Arnd
