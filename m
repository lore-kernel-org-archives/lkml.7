Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1265C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C828020700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbfDEHXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:23:23 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51467 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbfDEHXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:23:23 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 95F8F20019;
        Fri,  5 Apr 2019 07:23:20 +0000 (UTC)
Date:   Fri, 5 Apr 2019 09:23:20 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        srinivas.kandagatla@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND 1/2] nvmem: sunxi_sid: Support SID on H6
Message-ID: <20190405072320.zsc47vm63vuqqfvs@flea>
References: <20190404165726.13149-1-tiny.windzz@gmail.com>
 <20190404165726.13149-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aq5wvmbs24fucis4"
Content-Disposition: inline
In-Reply-To: <20190404165726.13149-2-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aq5wvmbs24fucis4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2019 at 12:57:25PM -0400, Yangtao Li wrote:
> Add support for H6's SID controller. It supports 4K-bit
> EFUSE, bigger than before.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--aq5wvmbs24fucis4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKcCYgAKCRDj7w1vZxhR
xTEpAP9jAs8q5adn+cpvO9WEQltaIPj5zWvr9qEoC8emmFE3vwEA0zKMnVuElJba
tUUEh7tu5L+TpJut68CspAG274F+Kwc=
=0od3
-----END PGP SIGNATURE-----

--aq5wvmbs24fucis4--
