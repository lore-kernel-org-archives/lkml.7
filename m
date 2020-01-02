Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2322C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B736021734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577959035;
	bh=dJtLGM90VsSnxOKZxJ1G3gomh0Mc7mH7LCEgRH3z7jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hJqzwDAnpBHU0Ql4uTR0xX5TFdq5vesYEI1uE3Zi/cPT3f8YjTJHJ0wrputnLwj5z
	 I9rujYHOwt9RzrELLGRfgvZ8DXeZ1/DJOtzp4gTClrhE2gwcQ+5s0INh2vD+uZvbjm
	 GrQhhhwyU2A3PA0PDxtgrQJo90o3s79fxabw6qmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgABJ5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:57:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbgABJ5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:57:14 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E208A21655;
        Thu,  2 Jan 2020 09:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577959034;
        bh=dJtLGM90VsSnxOKZxJ1G3gomh0Mc7mH7LCEgRH3z7jM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DijL6X3/QfA5NrtJFRhfK1Z4wSre004+UeEAVYW/kpoTbmpbkiEoQ3lPFlWivM39e
         9E4DrJlzBGhMpKEeT2wu4Qc8yVZRLiZ9zsCEQYjgXsA6D66detQgKOPhoUxQQkyoX3
         JFvsKWZFqN4HPJII98aBvkgND9TqED80H0OWVBtI=
Date:   Thu, 2 Jan 2020 10:57:11 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: R40: Add SPI controllers nodes and
 pinmuxes
Message-ID: <20200102095711.dkd2cnbyitz6mvyx@gilmour.lan>
References: <20200102012657.9278-1-andre.przywara@arm.com>
 <20200102012657.9278-4-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tls4vhda4rriy47h"
Content-Disposition: inline
In-Reply-To: <20200102012657.9278-4-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tls4vhda4rriy47h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Jan 02, 2020 at 01:26:57AM +0000, Andre Przywara wrote:
> The Allwinner R40 SoC contains four SPI controllers, using the newer
> sun6i design (but at the legacy addresses).
> The controller seems to be fully compatible to the A64 one, so no driver
> changes are necessary.
> The first three controller can be used on two sets of pins, but SPI3 is
> only routed to one set on Port A.
>
> Tested by connecting a SPI flash to a Bananapi M2 Berry on the SPI0
> PortC header pins.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 89 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index 8dcbc4465fbb..af437391dcf4 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -418,6 +418,41 @@
>  				bias-pull-up;
>  			};
>
> +			spi0_pc_pins: spi0-pc-pins {
> +				pins = "PC0", "PC1", "PC2", "PC23";
> +				function = "spi0";
> +			};
> +
> +			spi0_pi_pins: spi0-pi-pins {
> +				pins = "PI10", "PI11", "PI12", "PI13", "PI14";
> +				function = "spi0";
> +			};

This split doesn't really work though :/

The PC pins group has MOSI, MISO, CLK and CS0, while the PI pins group
has CS0, CLK, MOSI, MISO and CS1.

Meaning that if a board uses a GPIO CS pin, we can't really express
that, and any board using the PI pins for its SPI bus will try to
claim CS0 and CS1, no matter how many devices are connected on the bus
(and if there's one, there might be something else connected to PI14).

And you can't have a board using CS1 with the PC signals either.

You should split away the CS pins into separate groups, like we're
doing with the A20 for example.

And please add /omit-if-no-ref/ to those groups.

Thanks!
Maxime

--tls4vhda4rriy47h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXg2+dwAKCRDj7w1vZxhR
xdmiAP4mLy588nTiex+S45eKxWs1Wtt7WGHHrELTu/B/hebe3wD/WNmEX7EE0jy1
4wrmC/4yBIl0G9Cu7ulHU3J2nzFBeAI=
=04oW
-----END PGP SIGNATURE-----

--tls4vhda4rriy47h--
