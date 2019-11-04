Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9425ECA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1832080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="U0XZKqti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfKDRJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:09:58 -0500
Received: from mout.gmx.net ([212.227.17.21]:34997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbfKDRJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572887381;
        bh=Xw/Eqili2ZJJLIqrlq0Jd7xa4tm2K2gAhNFHp6fip9o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=U0XZKqtiv7v+Mu6yV1DFfP8K+sJwt97ZUnA75Z0pAGlhMvtZsMCsr2P+DVRoNPvZ2
         oYFF6ja1kFdc/Tb1oonTDYMSIecjtUTAP8u5RkijXjmp4bvczuyl0lU8rfk1SPPkN+
         K9Jg6YB27YiX7qGCkVTMuKJVc24JG4MgSwLPkRN4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.164] ([37.4.249.112]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf078-1hzjh90FMA-00gaTN; Mon, 04
 Nov 2019 18:09:41 +0100
Subject: Re: [PATCH 1/2] ARM: dts: bcm2711: force CMA into first GB of memory
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>
Cc:     linux-kernel@vger.kernel.org
References: <20191104135412.32118-1-nsaenzjulienne@suse.de>
 <20191104135412.32118-2-nsaenzjulienne@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <588d05b4-e66c-4aa0-436e-12d244a6efd8@gmx.net>
Date:   Mon, 4 Nov 2019 18:09:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104135412.32118-2-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:HUCChti8pYqeZ0jxOW5Kmz2kyPjLn97dBAj9Og47A75h/r17rVL
 8noEfKIPcCLhbr31Pmgru/D9r/FfgQCKP/n1auxhCJflW1WIxlD2QAlVtZtKiYmkjo9HOHD
 38nltXoEvu3flP9mlV6tJ6b0+9rKvOl9Q/8qNexhVxpQ6zsbgsswa7S+grNJhGul4BJBBBt
 MBdo/U9qUFlTxY5pjuAiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MmF7hCF6RgI=:fAH0j5PwkaBViB+yDfOEgb
 Pbz0an8tBAk/Hy4e+T665KOJ3bAeqCXqjWXG+VMtk9Dc8GzWVbE8tATq4d5hRDXae9cpb0WbO
 mBbmXCLHNNHXCx3OMYRTNpQi0cg8bQYPFvqidDAK0zTKdt0aucpFk4Pd9MF4VU9jiixVDpg0o
 0Sz6EQhPHuwBkYcpNqXd4MrfcqVz4EYgo5lyOv1TQ5o5tZmk3ldKGjnCwWqgt0Sv2ZIdMj7D0
 UX8BILlLWWY5H/uls06cWUDlh40TYguxHYc9ty6L0bASy5IldBi3q1354ccUZwYdmFelpIz01
 gOj/AFED7/QESBTpXghGelhw/EyymwsABQlOaL0wp3H8xfdJNhcfArDn6RJ+91fP4hwz4pCCs
 vO6qDnl87UKjiz8GyPjCv9ee0BMCe5SCaXVsnkC6XnQgIJf/dNTMswbwG0LYCKOUGfjLIUVn+
 1k0RvWM4K44ZxBa+Ws32c5GNAPVWUm1cfZjJ+WdyvbJ9Fga8WcJa6L0ITiN4BolPdUL7zocD2
 Y3qs3uYtukOme77dp4/OcUz6mDMLnobO2MaNEWza6Au4q0KMurHOAyM0cj7PKdCYWlVf8OHMs
 P7wo5iVbyZbdwuHX/b1Zix+VmkuLtoyoXabctzkuYyaGBAn3iHJnerbOejgCHYBQoR8fbc1v5
 0qSKEEeFBo0k/mhGGyy2W4jEK+BVAAomZDFX5xYJLatkrBQkCmoCValghsfc5cMm6hqzldSnB
 rns7MkIOazdWp71sYZ9YhKguP3MJzSpkgYBFxVzQPzUpuG32PcNiPX3BdEMgLe7RPxh0am4Fb
 B7imTVyMlb83T//YJIIrgMHcq5u1uCRvyWCABNgYGj9Jxpuhg9VncLKY9WchaARtrgI2G20Q9
 WTqvTQ5mJgBc9iG/FAJgo//nr5oFvpbJClrLWg+i0AT3/rp/M+a7msExDLcZrT9HGozXx0zcK
 5MG09uUIOAi2Gg8o8W/DOsq+a97IPESgdwhqQciCh/S/Ym23xhBcBUebOs/uAelc4p5X9Cu1m
 h8oJ8XBacBf9rv9ECaflaQs3MgdnWIsWYfqu3undBBxQsq7jiXqYq4Af9RnFE6EDvgXFWe9fg
 xQ+C6lDOUbzzCihQDjx/10Z5WzI9D9t9a3eAGDrF08zeeZBgfKn1Zoip6uCNOaiT9ADZZzT+r
 SaKsAkQctI0nqxwGkWmt8aXbCyCA1xRFqO/orwCOQ6eqJpmmOQ21Z7ZFnlVSVQb7NU4YFxofP
 2eQlLTQRBk5eDLGwsXsasGE28LV6q6YhHkyykJKABa5v5mAr84tmTefERtCU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Am 04.11.19 um 14:54 schrieb Nicolas Saenz Julienne:
> arm64 places the CMA in ZONE_DMA32, which is not good enough for the
> Raspberry Pi 4 since it contains peripherals that can only address the
> first GB of memory. Explicitly place the CMA into that area.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

do you want this in Linux 5.5 via devicetree/fixes? In this case please
add an fixes tag.

Otherwise this will be queued for Linux 5.6.

> ---
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/b=
cm2711-rpi-4-b.dts
> index cccc1ccd19be..3c7833e9005a 100644
> --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> @@ -19,6 +19,25 @@
>  		reg =3D <0 0 0>;
>  	};
>
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +		/*
> +		 * arm64 reserves the CMA by default somewhere in ZONE_DMA32,
> +		 * that's not good enough for the Raspberry Pi 4 as some
> +		 * devices can only address the lower 1G of memory (ZONE_DMA).
> +		 */
> +		linux,cma {
> +			compatible =3D "shared-dma-pool";
> +			size =3D <0x2000000>; /* 32MB */
> +			alloc-ranges =3D <0x0 0x00000000 0x40000000>;
> +			reusable;
> +			linux,cma-default;
> +		};
> +	};
> +

i think this is a SoC-specific issue not a board specifc one. Please
move this to bcm2711.dtsi

Thanks
Stefan

>  	leds {
>  		act {
>  			gpios =3D <&gpio 42 GPIO_ACTIVE_HIGH>;
