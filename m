Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002E6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7892084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfDCHyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:54:35 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:35619 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfDCHyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:54:33 -0400
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 0A75110000B;
        Wed,  3 Apr 2019 07:54:30 +0000 (UTC)
Date:   Wed, 3 Apr 2019 09:54:30 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] clk: sunxi-ng: h6: Allow video & vpu clocks to
 change parent rate
Message-ID: <20190403075430.4j7sw5vxqop6ptkj@flea>
References: <20190402210623.14988-1-jernej.skrabec@siol.net>
 <20190402210623.14988-4-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dlygytycrtll3jzo"
Content-Disposition: inline
In-Reply-To: <20190402210623.14988-4-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dlygytycrtll3jzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2019 at 11:06:23PM +0200, Jernej Skrabec wrote:
> Video related clocks need to set rate as close as possible to the
> requested one, so they should be able to change parent clock rate.
>
> VPU clock sometimes has to be set to higher than default parent clock
> rate. This is requ
>
> Add CLK_SET_RATE_PARENT flag to tcon-lcd0, tcon-tv0 and ve.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--dlygytycrtll3jzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKRmtgAKCRDj7w1vZxhR
xSCeAQD9azksPOOd3+hjMOogzvb2xqqluwkKgKGbum6gXp+aigEAzci8lgrm2Fb7
svocTHHy7eh9nMG7v5fG2I4RITk/5gY=
=z2li
-----END PGP SIGNATURE-----

--dlygytycrtll3jzo--
