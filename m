Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E0FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3834B20873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfEBHhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:37:16 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56447 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfEBHhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:37:16 -0400
X-Originating-IP: 90.88.149.145
Received: from localhost (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 9EFB46000B;
        Thu,  2 May 2019 07:37:12 +0000 (UTC)
Date:   Thu, 2 May 2019 09:37:12 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Pablo Greco <pgreco@centosproject.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] ARM: dts: sun8i: r40: bananapi-m2-ultra: Add GPIO
 pin-bank regulator supplies
Message-ID: <20190502073712.3le5ohnufk7lfvl6@flea>
References: <1556040365-10913-1-git-send-email-pgreco@centosproject.org>
 <1556040365-10913-2-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zsawzropahmcetva"
Content-Disposition: inline
In-Reply-To: <1556040365-10913-2-git-send-email-pgreco@centosproject.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zsawzropahmcetva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 23, 2019 at 02:25:58PM -0300, Pablo Greco wrote:
> The bananapi-m2-ultra has the PMIC providing voltage to all the pin-bank
> supply rails from its various regulator outputs, tie them to the pio
> node.
>
> Signed-off-by: Pablo Greco <pgreco@centosproject.org>

Queued for 5.3, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zsawzropahmcetva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXMqeKAAKCRDj7w1vZxhR
xXbIAP9l29OCHCho5tR8+PsJF9tjCvjKf3ETiZzemaf9PUlAngEAmeQjqD1RSN7g
sQIPXJsIliw67+HnsVbpleKEI3OOOQ4=
=wrP/
-----END PGP SIGNATURE-----

--zsawzropahmcetva--
