Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346B5C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 09:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC6820838
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 09:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577354028;
	bh=dGwRFsRQln5B894HkC1AQaBbrX1OHeeRML8iSWjpZgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UKosMMoqmu7DR34Spd1GWVED48pzmNAOcyaYmLpR8Kxn9uc5WDxMC3Cg0fXVmBP2Q
	 vOlfeMpTgbYQ+3SgSSotk//CB8RwCJikKEWqtUXbZmnwZeH+w7hQLY1bmiomD/Tvcd
	 EqNtVNwbEj6QJw6/UeeYgl6Uom4AwDCrAbTXawJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfLZJxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 04:53:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfLZJxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 04:53:46 -0500
Received: from localhost (lfbn-lyo-1-633-204.w90-119.abo.wanadoo.fr [90.119.206.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DD252080D;
        Thu, 26 Dec 2019 09:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577354026;
        bh=dGwRFsRQln5B894HkC1AQaBbrX1OHeeRML8iSWjpZgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dgn/DuDz+L/BUxnVLvQlzq2ES7WPkunjwb+MU50mPr9kHx/cQ5bm4vXbrRoiSR2mg
         enWr6QOIn1W/J+HOPP7oQWFtVLVgF26bgngE+q4/zfrSD5sVSTkuQpoGAKCWFYAzpO
         5cKA0Hxrb2SEob+emBTjwVQNxaUIrYWwBnKrzJWc=
Date:   Thu, 26 Dec 2019 10:55:07 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sunxi: Add Libre Computer ALL-H3-IT H5 board
Message-ID: <20191226095507.olorn47y7xmddgin@hendrix.home>
References: <20191224061555.18358-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lweqfbwsvdz4r4jl"
Content-Disposition: inline
In-Reply-To: <20191224061555.18358-1-wens@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lweqfbwsvdz4r4jl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 24, 2019 at 02:15:55PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> The Libre Computer ALL-H3-IT board is a small single board computer that
> is roughly the same size as the Raspberry Pi Zero, or around 20% smaller
> than a credit card.
>
> The board features:
>
>   - H2, H3, or H5 SoC from Allwinner
>   - 2 DDR3 DRAM chips
>   - Realtek RTL8821CU based WiFi module
>   - 128 Mbit SPI-NOR flash
>   - micro-SD card slot
>   - micro HDMI video output
>   - FPC connector for camera sensor module
>   - generic Raspberri-Pi style 40 pin GPIO header
>   - additional pin headers for extra USB host ports, ananlog audio and
>     IR receiver
>
> Only H5 variant test samples were made available, but the vendor does
> have plans to include at least an H3 variant. Thus the device tree is
> split much like the ALL-H3-CC, with a common dtsi file for the board
> design, and separate dts files including the common board file and the
> SoC dtsi file. The other variants will be added as they are made
> available.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--lweqfbwsvdz4r4jl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXgSDewAKCRDj7w1vZxhR
xdlUAP4/EcPmWRKjD8xeYE9H+HSdokqIYjvzND2KP2yG9ujTsgEAkKWq6a5Igzyn
/wXdS4/5tQyqvruVUJaIsmeNwKAxTAY=
=RYso
-----END PGP SIGNATURE-----

--lweqfbwsvdz4r4jl--
