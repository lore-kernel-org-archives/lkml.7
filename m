Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F712C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F57C2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbfDQIcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:32:18 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39277 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbfDQIcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:32:17 -0400
X-Originating-IP: 90.88.160.238
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A7C2AE000E;
        Wed, 17 Apr 2019 08:32:12 +0000 (UTC)
Date:   Wed, 17 Apr 2019 10:32:12 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        rjw@rjwysocki.net, davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Message-ID: <20190417083212.mng5p276kyot3nvw@flea>
References: <20190416155209.24216-1-tiny.windzz@gmail.com>
 <20190416155209.24216-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="psruohnblxprxqcd"
Content-Disposition: inline
In-Reply-To: <20190416155209.24216-2-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--psruohnblxprxqcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 16, 2019 at 11:52:08AM -0400, Yangtao Li wrote:
> For some SoCs, the CPU frequency subset and voltage value of each OPP
> varies based on the silicon variant in use. The sun50i-cpufreq-nvmem
> driver reads the efuse value from the SoC to provide the OPP framework
> with required information.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--psruohnblxprxqcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLbkjAAKCRDj7w1vZxhR
xbzdAQDVXEZNf6LbdNqHjBzS2ujcjdlY6nI4E2lZas2cnk9DJwEA3E3en227I2pT
ZdgykUAdmZ0iSc8o2PioP61AY2DvqA0=
=+DVI
-----END PGP SIGNATURE-----

--psruohnblxprxqcd--
