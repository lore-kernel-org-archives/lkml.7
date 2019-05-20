Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F5EC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C738520815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfETHlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:41:51 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42667 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfETHlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:41:50 -0400
X-Originating-IP: 90.88.22.185
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7F61A1C0011;
        Mon, 20 May 2019 07:41:40 +0000 (UTC)
Date:   Mon, 20 May 2019 09:41:40 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: allwinner: Enable AXP803's USB power supply
Message-ID: <20190520074140.7kln73ws3fkt63gm@flea>
References: <20190418161804.17723-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5pummrpkyefqzedl"
Content-Disposition: inline
In-Reply-To: <20190418161804.17723-1-wens@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5pummrpkyefqzedl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 19, 2019 at 12:18:01AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> Hi everyone,
>
> This series follows up on the A83T USB OTG series. The USB power supply
> portion of the AXP803, the PMIC used with the A64, is identical to the
> part in the AXP813/AXP818, used with the A83T.
>
> This series enables the USB power supply in the AXP803 using the AXP813's
> compatible string as a fallback. The per-model compatible string is still
> added as a contigency.
>
> Patch 1 adds an mfd cell for the USB power supply, to the AXP803.
>
> Patch 2 adds a device node for the USB power supply.
>
> Patch 3 enables the USB power supply on the Bananapi M64.
>
> Unfortunately the original Pine64 does not wire up the USB power supply,
> and I don't have any other A64 boards.
>
> The mfd patch can go in through the mfd tree. There are no compile-time
> dependencies. We, sunxi, can take the DT patches.

Applied 2 and 3, thanks!

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5pummrpkyefqzedl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOJaNAAKCRDj7w1vZxhR
xT8YAQCrhNoaCeDiNfKD0yyLnByQlt1Fhq3zrDMR7EoKAmRKSwD47VSRP1Bqcw2Q
ljwc/WnLZXRKEMlsgmjlH+EMmQ0vAg==
=A9Ui
-----END PGP SIGNATURE-----

--5pummrpkyefqzedl--
