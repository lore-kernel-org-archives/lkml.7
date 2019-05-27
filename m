Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40E9C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFD121734
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfE0J6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:58:55 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:59307 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfE0J6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:58:54 -0400
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id BC7B2200013;
        Mon, 27 May 2019 09:58:49 +0000 (UTC)
Date:   Mon, 27 May 2019 11:58:49 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yegor Timoshenko <yegortimoshenko@riseup.net>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: bananapi-m64: enable UART2
Message-ID: <20190527095849.uvsivexbb6tfjccw@flea>
References: <20190526094715.12289-1-yegortimoshenko@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ktylujpg3yzbdylg"
Content-Disposition: inline
In-Reply-To: <20190526094715.12289-1-yegortimoshenko@riseup.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ktylujpg3yzbdylg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, May 26, 2019 at 12:47:15PM +0300, Yegor Timoshenko wrote:
> BananaPi M64 exposes UART2 interface that is supposed to be enabled
> by default (see "Default Function" in the pin definition table from
> the manufacturer [1]).
>
> [1]: https://bananapi.gitbooks.io/bpi-m64/en/bpi-m64gpiopindefine.html
>
> Signed-off-by: Yegor Timoshenko <yegortimoshenko@riseup.net>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> index 094cfed13df9..100d1a8fd292 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> @@ -54,6 +54,7 @@
>  		ethernet0 = &emac;
>  		serial0 = &uart0;
>  		serial1 = &uart1;
> +		serial2 = &uart2;
>  	};
>
>  	chosen {
> @@ -312,6 +313,12 @@
>  	status = "okay";
>  };
>
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2_pins>;
> +	status = "okay";
> +};
> +

Unfortunately, this can still be used for something else. Our policy
so far has been that we would fill the muxing but keep the nodes
disabled so that it's easier for people that want to enable it, but it
seems like it's already using the default muxing as well.

Maxime


--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ktylujpg3yzbdylg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOu02QAKCRDj7w1vZxhR
xUciAP4y8fZNwh7eAtCPtUgJ3FdM3Qacd6yxUNimUc62YkREFQD6Az4IJj3Bx6Iv
LnR7PXw+or0ouBFSx4ziaPuhdOMsPQg=
=VGIR
-----END PGP SIGNATURE-----

--ktylujpg3yzbdylg--
