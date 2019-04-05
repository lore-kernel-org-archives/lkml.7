Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA48CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D283218C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfDEI5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:57:01 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:34029 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEI5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:57:00 -0400
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 77CA410000E;
        Fri,  5 Apr 2019 08:56:57 +0000 (UTC)
Date:   Fri, 5 Apr 2019 10:56:56 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        srinivas.kandagatla@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND 2/2] arm64: dts: sunxi: h6: Add device node for SID
Message-ID: <20190405085656.w4g7fx4ivrzeajqh@flea>
References: <20190404170146.13204-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdqwe27skqwqafhr"
Content-Disposition: inline
In-Reply-To: <20190404170146.13204-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdqwe27skqwqafhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2019 at 01:01:46PM -0400, Yangtao Li wrote:
> The device tree binding already lists compatible strings for H6
> SoC, so add a device node for it.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--sdqwe27skqwqafhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKcYWAAKCRDj7w1vZxhR
xZtSAQCpVnM6Ubdi6hwuim8LUpUUFL1AMXXD0VYe/LbAre8LswD9G0j9yM/nQlL0
WVLTQwctbyo85CGcGH7eCG74uwcwgQw=
=ot9q
-----END PGP SIGNATURE-----

--sdqwe27skqwqafhr--
