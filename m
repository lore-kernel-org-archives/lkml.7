Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B805C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4321C20873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfDKH1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:27:33 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:48431 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKH1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:27:33 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D619C24000E;
        Thu, 11 Apr 2019 07:27:24 +0000 (UTC)
Date:   Thu, 11 Apr 2019 09:27:24 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 3/8] dt-bindings: gpu: mali-midgard: Add h6 mali gpu
 compatible
Message-ID: <20190411072724.qdhfvdhjce5sopzi@flea>
References: <20190410232543.13297-1-peron.clem@gmail.com>
 <20190410232543.13297-4-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5anxqwtd6i6f45jl"
Content-Disposition: inline
In-Reply-To: <20190410232543.13297-4-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5anxqwtd6i6f45jl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 01:25:38AM +0200, Cl=E9ment P=E9ron wrote:
> This add the H6 mali compatible in the dt-bindings to later support
> specific implementation.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  .../devicetree/bindings/gpu/arm,mali-midgard.txt          | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b=
/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> index 2e8bbce35695..9e71146b5c8a 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> @@ -15,6 +15,7 @@ Required properties:
>      + "arm,mali-t860"
>      + "arm,mali-t880"
>    * which must be preceded by one of the following vendor specifics:
> +    + "allwinner,sun50i-h6-mali"
>      + "amlogic,meson-gxm-mali"
>      + "rockchip,rk3288-mali"
>      + "rockchip,rk3399-mali"
> @@ -49,9 +50,14 @@ Vendor-specific bindings
>  ------------------------
>
>  The Mali GPU is integrated very differently from one SoC to
> -another. In order to accomodate those differences, you have the option
> +another. In order to accommodate those differences, you have the option
>  to specify one more vendor-specific compatible, among:
>
> +- "allwinner,sun50i-h6-mali"
> +  Required properties:
> +  - resets: Should contain phandle of :
> +    + GPU reset line
> +

And clocks, I assume?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5anxqwtd6i6f45jl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXK7sXAAKCRDj7w1vZxhR
xeYwAQCzRx3UueQ8fazvSM1FAuqvt8wTq70tuV9mWYF6ydSh9QEAhHPEUJx55hRj
EiS/5GgnQnvrH5Y4DI5KI3VLpZAZswY=
=vQE2
-----END PGP SIGNATURE-----

--5anxqwtd6i6f45jl--
