Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B27C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B252073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfDPGD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:03:57 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:32954 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfDPGD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:03:57 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44jvvC5JZbz1rK4G;
        Tue, 16 Apr 2019 08:03:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44jvvC4CJGz1rVwL;
        Tue, 16 Apr 2019 08:03:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id JHL0kH-_a42y; Tue, 16 Apr 2019 08:03:49 +0200 (CEST)
X-Auth-Info: /FVBNWmgyxmqtXsnYZmWT9j8d/z4a6s6ZmAfMoDILR0=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 16 Apr 2019 08:03:49 +0200 (CEST)
Date:   Tue, 16 Apr 2019 08:03:39 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: ep93xx: move private headers out of mach/*
Message-ID: <20190416080339.5360befd@jawa>
In-Reply-To: <20190415193231.936070-1-arnd@arndb.de>
References: <20190415192734.935387-1-arnd@arndb.de>
        <20190415193231.936070-1-arnd@arndb.de>
Organization: denx.de
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2+fZ2yzH1wC4rEYfmZTC2NA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2+fZ2yzH1wC4rEYfmZTC2NA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Apr 2019 21:31:50 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> gpio-ep93xx.h, hardware.h, and platform.h are only used in
> arch/arm/mach-ep93xx, so we can move them one there and no
> longer expose them to device drivers.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-ep93xx/adssphere.c                      | 2 +-
>  arch/arm/mach-ep93xx/clock.c                          | 2 +-
>  arch/arm/mach-ep93xx/core.c                           | 6 +++---
>  arch/arm/mach-ep93xx/dma.c                            | 2 +-
>  arch/arm/mach-ep93xx/edb93xx.c                        | 4 ++--
>  arch/arm/mach-ep93xx/gesbc9312.c                      | 2 +-
>  arch/arm/mach-ep93xx/{include/mach =3D> }/gpio-ep93xx.h | 0
>  arch/arm/mach-ep93xx/{include/mach =3D> }/hardware.h    | 2 +-
>  arch/arm/mach-ep93xx/micro9.c                         | 2 +-
>  arch/arm/mach-ep93xx/{include/mach =3D> }/platform.h    | 0
>  arch/arm/mach-ep93xx/simone.c                         | 4 ++--
>  arch/arm/mach-ep93xx/snappercl15.c                    | 4 ++--
>  arch/arm/mach-ep93xx/ts72xx.c                         | 4 ++--
>  arch/arm/mach-ep93xx/vision_ep9307.c                  | 4 ++--
>  14 files changed, 19 insertions(+), 19 deletions(-)
>  rename arch/arm/mach-ep93xx/{include/mach =3D> }/gpio-ep93xx.h (100%)
>  rename arch/arm/mach-ep93xx/{include/mach =3D> }/hardware.h (96%)
>  rename arch/arm/mach-ep93xx/{include/mach =3D> }/platform.h (100%)
>=20

Reviewed-by: Lukasz Majewski <lukma@denx.de>

> diff --git a/arch/arm/mach-ep93xx/adssphere.c
> b/arch/arm/mach-ep93xx/adssphere.c index bda6c3a5c923..5d3a3e302012
> 100644 --- a/arch/arm/mach-ep93xx/adssphere.c
> +++ b/arch/arm/mach-ep93xx/adssphere.c
> @@ -15,7 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/sizes.h>
> =20
> -#include <mach/hardware.h>
> +#include "hardware.h"
> =20
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-ep93xx/clock.c
> b/arch/arm/mach-ep93xx/clock.c index 9f43362eb62d..b9f523d9dc8c 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -22,7 +22,7 @@
>  #include <linux/clkdev.h>
>  #include <linux/soc/cirrus/ep93xx.h>
> =20
> -#include <mach/hardware.h>
> +#include "hardware.h"
> =20
>  #include <asm/div64.h>
> =20
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 3d245668846d..cc1382f879af 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -39,13 +39,13 @@
>  #include <linux/usb/ohci_pdriver.h>
>  #include <linux/random.h>
> =20
> -#include <mach/hardware.h>
> +#include "hardware.h"
>  #include <linux/platform_data/video-ep93xx.h>
>  #include <linux/platform_data/keypad-ep93xx.h>
>  #include <linux/platform_data/spi-ep93xx.h>
>  #include <linux/soc/cirrus/ep93xx.h>
> =20
> -#include <mach/gpio-ep93xx.h>
> +#include "gpio-ep93xx.h"
> =20
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> @@ -125,7 +125,7 @@ void ep93xx_devcfg_set_clear(unsigned int
> set_bits, unsigned int clear_bits) /**
>   * ep93xx_chip_revision() - returns the EP93xx chip revision
>   *
> - * See <mach/platform.h> for more information.
> + * See "platform.h" for more information.
>   */
>  unsigned int ep93xx_chip_revision(void)
>  {
> diff --git a/arch/arm/mach-ep93xx/dma.c b/arch/arm/mach-ep93xx/dma.c
> index 88a4c9b089a5..821427107b11 100644
> --- a/arch/arm/mach-ep93xx/dma.c
> +++ b/arch/arm/mach-ep93xx/dma.c
> @@ -26,7 +26,7 @@
>  #include <linux/platform_device.h>
> =20
>  #include <linux/platform_data/dma-ep93xx.h>
> -#include <mach/hardware.h>
> +#include "hardware.h"
> =20
>  #include "soc.h"
> =20
> diff --git a/arch/arm/mach-ep93xx/edb93xx.c
> b/arch/arm/mach-ep93xx/edb93xx.c index 8e89ec8b6f0f..d96dd014dd23
> 100644 --- a/arch/arm/mach-ep93xx/edb93xx.c
> +++ b/arch/arm/mach-ep93xx/edb93xx.c
> @@ -32,10 +32,10 @@
> =20
>  #include <sound/cs4271.h>
> =20
> -#include <mach/hardware.h>
> +#include "hardware.h"
>  #include <linux/platform_data/video-ep93xx.h>
>  #include <linux/platform_data/spi-ep93xx.h>
> -#include <mach/gpio-ep93xx.h>
> +#include "gpio-ep93xx.h"
> =20
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-ep93xx/gesbc9312.c
> b/arch/arm/mach-ep93xx/gesbc9312.c index 0cca5b183309..ac48e3476587
> 100644 --- a/arch/arm/mach-ep93xx/gesbc9312.c
> +++ b/arch/arm/mach-ep93xx/gesbc9312.c
> @@ -15,7 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/sizes.h>
> =20
> -#include <mach/hardware.h>
> +#include "hardware.h"
> =20
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h
> b/arch/arm/mach-ep93xx/gpio-ep93xx.h similarity index 100%
> rename from arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h
> rename to arch/arm/mach-ep93xx/gpio-ep93xx.h
> diff --git a/arch/arm/mach-ep93xx/include/mach/hardware.h
> b/arch/arm/mach-ep93xx/hardware.h similarity index 96%
> rename from arch/arm/mach-ep93xx/include/mach/hardware.h
> rename to arch/arm/mach-ep93xx/hardware.h
> index 8938906e780a..e7d850e04782 100644
> --- a/arch/arm/mach-ep93xx/include/mach/hardware.h
> +++ b/arch/arm/mach-ep93xx/hardware.h
> @@ -6,7 +6,7 @@
>  #ifndef __ASM_ARCH_HARDWARE_H
>  #define __ASM_ARCH_HARDWARE_H
> =20
> -#include <mach/platform.h>
> +#include "platform.h"
> =20
>  /*
>   * The EP93xx has two external crystal oscillators.  To generate the
> diff --git a/arch/arm/mach-ep93xx/micro9.c
> b/arch/arm/mach-ep93xx/micro9.c index 373583c29825..c7f64e4ff6c7
> 100644 --- a/arch/arm/mach-ep93xx/micro9.c
> +++ b/arch/arm/mach-ep93xx/micro9.c
> @@ -16,7 +16,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> =20
> -#include <mach/hardware.h>
> +#include "hardware.h"
> =20
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h
> b/arch/arm/mach-ep93xx/platform.h similarity index 100%
> rename from arch/arm/mach-ep93xx/include/mach/platform.h
> rename to arch/arm/mach-ep93xx/platform.h
> diff --git a/arch/arm/mach-ep93xx/simone.c
> b/arch/arm/mach-ep93xx/simone.c index 80ccb984d521..adc17289cc23
> 100644 --- a/arch/arm/mach-ep93xx/simone.c
> +++ b/arch/arm/mach-ep93xx/simone.c
> @@ -27,8 +27,8 @@
>  #include <linux/gpio.h>
>  #include <linux/gpio/machine.h>
> =20
> -#include <mach/hardware.h>
> -#include <mach/gpio-ep93xx.h>
> +#include "hardware.h"
> +#include "gpio-ep93xx.h"
> =20
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-ep93xx/snappercl15.c
> b/arch/arm/mach-ep93xx/snappercl15.c index cf0cb58b3454..f8f89551dbed
> 100644 --- a/arch/arm/mach-ep93xx/snappercl15.c
> +++ b/arch/arm/mach-ep93xx/snappercl15.c
> @@ -25,9 +25,9 @@
> =20
>  #include <linux/mtd/platnand.h>
> =20
> -#include <mach/hardware.h>
> +#include "hardware.h"
>  #include <linux/platform_data/video-ep93xx.h>
> -#include <mach/gpio-ep93xx.h>
> +#include "gpio-ep93xx.h"
> =20
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-ep93xx/ts72xx.c
> b/arch/arm/mach-ep93xx/ts72xx.c index 85b74ac943f0..bba6aa5d7106
> 100644 --- a/arch/arm/mach-ep93xx/ts72xx.c
> +++ b/arch/arm/mach-ep93xx/ts72xx.c
> @@ -23,8 +23,8 @@
>  #include <linux/mmc/host.h>
>  #include <linux/platform_data/spi-ep93xx.h>
> =20
> -#include <mach/gpio-ep93xx.h>
> -#include <mach/hardware.h>
> +#include "gpio-ep93xx.h"
> +#include "hardware.h"
>  #include <mach/irqs.h>
> =20
>  #include <asm/mach-types.h>
> diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c
> b/arch/arm/mach-ep93xx/vision_ep9307.c index
> 767ee64628dc..66e2b34aa779 100644 ---
> a/arch/arm/mach-ep93xx/vision_ep9307.c +++
> b/arch/arm/mach-ep93xx/vision_ep9307.c @@ -31,10 +31,10 @@
> =20
>  #include <sound/cs4271.h>
> =20
> -#include <mach/hardware.h>
> +#include "hardware.h"
>  #include <linux/platform_data/video-ep93xx.h>
>  #include <linux/platform_data/spi-ep93xx.h>
> -#include <mach/gpio-ep93xx.h>
> +#include "gpio-ep93xx.h"
> =20
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/2+fZ2yzH1wC4rEYfmZTC2NA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAly1cDsACgkQAR8vZIA0
zr1h5wf/TVNGxggOkqNutSR8OEZ3D+ASURYBFO4Kb9VDFPJ/El9iIHLy3YYol5sH
8bcDFugmU4t7xPdzXMv6IGs2eMc0qn7aYP2hCy6foiFrZ9LVRSEufvBw3wRVJ4+V
52l1k7oOIjWjK8heGskII6t+S263AKOQT1zveshZitnpYbsAIZMaFANAoCnXZ1Aj
WdJRvspqNcSLWpvraYJK5kolBxOC5zZXwl1boC74ODRv8vu5RH7holHEcBPF6Y/Z
6KA91poJVeNLO+A4zBbq8CZvKGx5UBiqFR2oZCxORVDpvKeQFgf/1eR7ihiq58+M
GFpupmFttekI62lrNdQdPFLyweqMpQ==
=jsjH
-----END PGP SIGNATURE-----

--Sig_/2+fZ2yzH1wC4rEYfmZTC2NA--
