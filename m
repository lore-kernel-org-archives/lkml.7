Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D0BC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B3421D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PsAkcftL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfKGGXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 01:23:34 -0500
Received: from mout.gmx.net ([212.227.15.19]:54711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfKGGXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 01:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573107798;
        bh=rMybS4P7iltlkP4byw7w3d9o/YVha1a/UZ09FyOoiS4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PsAkcftLqIIRKKPXkqyflogW2HN8uODBSdoRTNvKwtaNMVm180rYa5RH/TX9pZ39U
         y58lEYWn2YkaUr0ADhcixqGrA6qlaMYNTHz7GS8EH12LBB70NDL30ZNZoyC9+NdOXJ
         LFjoRiq67XmQk3FMTXvxw26u2WDj/IBAOqvk7S1E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.167] ([37.4.249.112]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGW7-1iITMp1nq9-00PamQ; Thu, 07
 Nov 2019 07:23:18 +0100
Subject: Re: [PATCH v2 1/2] ARM: dts: bcm2711: force CMA into first GB of
 memory
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org
References: <20191106095945.22933-1-nsaenzjulienne@suse.de>
 <20191106095945.22933-2-nsaenzjulienne@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <09138a9d-40a5-4c5f-0cf4-1cb73579c600@gmx.net>
Date:   Thu, 7 Nov 2019 07:23:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106095945.22933-2-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:isuZZlBG5UxboGSxgwfmqyHaD9A6OpC2okXbCmRW7mOwxXPrscu
 Tm2iA8YgaKQdwROG6va+wQ0Nk3NMQp0c4CjfKSaOvHaU7rKonxWRaVD62MfNqA4QGAxu0jY
 uD9oh/fEyCJIbQTEljLyE7n3HQ3dA59DIGjFLU2PwbifysxP9D/7xuFX1AbqrVYK7QY2rIq
 0iE8ck42bewxgxafzxtxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Euer4+Yr0NQ=:nYc0yQ1rDQBHSguAAdEg6L
 J6yEEL9rjb2roz+VGOUdBd+R7ha55/wvCNxVaqADIfvNBXk9T7qh4y6Sw3iveESt4TbdrCmI5
 Ia5BcOee944TfRCBD3qQvtkdY0dAEez61vC50FmJEpZZS7/7ah74CWT7sSLhh8H9GfyIkdBjW
 gP1XG3v51mVYPpIAwYA7trbbWZaJCNrjjWHzoNpbLdu4xTHvWAPFBXsPYcUnwqXOwDtLdmjLz
 SOXkeuZKgGX5/NlicycGtteWkpC+eDiCClU76JEcKJ6ODNUglUudGBT9uW4KM0iR53WdaFCbK
 4bx4JthGKVibFxNTBBPozw42XvmX8EYHkGhy+Rk1hjlpCmKRYPXVs0Jq69i3Pu4qG7INi9ARe
 l1tOzk1eGgqZQEYWXuNl0NHPNZ23f5Ge6u10aNV1YySgSR2PNzLfqOsSHkpEHlTDYdlAz2jG5
 ljc8pfSu7KTsgLPwYqvsPxcCUjg33ImERrCQBFKnrg7KNixTANz52FLZwfla8Agm9kwjPzDdo
 9s34bEAr1grLgnsDBJG602Ad5PqOaAtOgJttCphan9INq6vrITvYyPJsjLsnyhXn6646/EuJs
 Z05DZIIrFHVCaGUj50pT+kOEcL4YnXTLrxRl6riKkoXNrLuScFwcBtYes73B2uQAxTSw6SK/C
 qmM7LihX3uay2RBTwkmi3Ab/dWFqiXm5lYXFyEs71NR/9W1XEwH65+7luDzGj/yN5FvhRIO4o
 /9Uy+ENMTXBQLF8a6APqp3XtybTrAtomnAiEMxKK1NmEMHEPD7u7mEmaNap5JN6EfPoGWuMR/
 1FYq6VlTYzssqFtsdgogwL4kBI3HxarPko4pneMXs0neOkth2QgIMC03ff3Gqts6yMISTz1Mo
 rvsjbLAu7Z8hM3TGhDmKR6biwD26B+3CG+rrrguFBOZZVzIl1oKqpQ4ZIDVELqf+MswKbMeVc
 9NO9fKsKm1kYa/V4wzl7G5dr8V0tf1XCH38dVdjnYg0f1P9jHCTg4BIQWhbk2YuDXIz2Qgbpn
 eC1+AJ8/OLlPEwE9uB6wO4YMAiNatWCbz9mfc5cwgYiF38JVKGr5RFoFtA89mQiX038K+EUOL
 iy90uKbMJDAWAaysuVoOhldg+eJYhZwbzKi8AQdB3fO/AB3vMfazzCEYCljL8zX4i3epN5qjL
 8oaZ4Yeo1rRjgYP7u9JwWTc3Cy+zxeH/cVPjL2h1XpOCzluUzv5mj9idD57aurJtMiltRGuOC
 rnoIaCETwpj0xjH6sU4dqJIR7+dwujAhO86/OTOmH8UAdgZUr5muue2VkHpg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Am 06.11.19 um 10:59 schrieb Nicolas Saenz Julienne:
> arm64 places the CMA in ZONE_DMA32, which is not good enough for the
> Raspberry Pi 4 since it contains peripherals that can only address the
> first GB of memory. Explicitly place the CMA into that area.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>
> ---
>
> Changes since v1:
>   - Move into bcm2711.dtsi
>
>  arch/arm/boot/dts/bcm2711.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.=
dtsi
> index 1f3acd3363ea..6000a01652fa 100644
> --- a/arch/arm/boot/dts/bcm2711.dtsi
> +++ b/arch/arm/boot/dts/bcm2711.dtsi
> @@ -12,6 +12,26 @@
>
>  	interrupt-parent =3D <&gicv2>;
>
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +		/*
> +		 * arm64 reserves the CMA by default somewhere in ZONE_DMA32,
> +		 * that's not good enough for the Raspberry Pi 4 as some

sorry for the nitpicking but i hope the Raspberry Pi 4 B wont be the
only user of BCM2711.

So please s/Raspberry Pi 4/BCM2711/

Beside that:

Acked-by: Stefan Wahren <wahrenst@gmx.net>

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
> +
>  	soc {
>  		/*
>  		 * Defined ranges:
