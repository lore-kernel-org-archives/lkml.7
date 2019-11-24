Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7400C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 12:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3292075E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 12:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="RTmLlG47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKXM5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 07:57:45 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:55330 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKXM5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 07:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574600256; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eB/LD07EzRmsuGpIzh39d3UMiNMxk6mHLnDiEe/ssLc=;
        b=RTmLlG47A3S6kbPnIBIe7NBB8tBfySmc8DFNLpb3oBf3DRfID7C9iXEZT7Iv3pi6Z4Fqo7
        7tzP6M2RV59ImZiSVFCCpJ+3ZIDKEeCKP13KxThOdg3Gtz+ujaaTSI2L/4VyI86+Sb2x4p
        92iUAkNIHsPORo95QlVgtT+scNtBMjU=
Date:   Sun, 24 Nov 2019 13:57:26 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 8/8] MIPS: DTS: jz4780: add sgx gpu node
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-1?q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, linux-mips@vger.kernel.org,
        Paul Boddie <paul@boddie.org.uk>
Message-Id: <1574600246.3.0@crapouillou.net>
In-Reply-To: <c73e2cee4f818654f264b0b7b5458bfaa0ac6a7a.1574595627.git.hns@goldelico.com>
References: <cover.1574595627.git.hns@goldelico.com>
        <c73e2cee4f818654f264b0b7b5458bfaa0ac6a7a.1574595627.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,


Le dim., nov. 24, 2019 at 12:40, H. Nikolaus Schaller=20
<hns@goldelico.com> a =E9crit :
> and add interrupt and clocks.
>=20
> Tested to build for CI20 board and load a (non-working) driver.
>=20
> Suggested-by: Paul Boddie <paul@boddie.org.uk>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi=20
> b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> index c54bd7cfec55..21ea5f4a405b 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -46,6 +46,17 @@
>  		#clock-cells =3D <1>;
>  	};
>=20
> +	gpu: gpu@13040000 {

We try to keep the nodes ordered by address, could you move this node=20
where it belongs?

Thanks,
-Paul


> +		compatible =3D "ingenic,jz4780-sgx540-120", "img,sgx540-120",=20
> "img,sgx540", "img,sgx5";
> +		reg =3D <0x13040000 0x4000>;
> +
> +		clocks =3D <&cgu JZ4780_CLK_GPU>;
> +		clock-names =3D "gpu";
> +
> +		interrupt-parent =3D <&intc>;
> +		interrupts =3D <63>;
> +	};
> +
>  	tcu: timer@10002000 {
>  		compatible =3D "ingenic,jz4780-tcu",
>  			     "ingenic,jz4770-tcu",
> --
> 2.23.0
>=20

=

