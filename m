Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E054BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C0120643
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732245AbfDAIAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:00:15 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:37199 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731944AbfDAIAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:00:14 -0400
Received: from localhost (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id F2F6F240006;
        Mon,  1 Apr 2019 08:00:08 +0000 (UTC)
Date:   Mon, 1 Apr 2019 10:00:07 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     megous@megous.com
Cc:     wens@csie.org, robh@kernel.org, johan@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/7] ARM: dts: sun8i: tbs-a711: Enable bluetooth
Message-ID: <20190401080007.6vzxijc6vsktg72h@flea>
References: <20190327001843.2420-1-megous@megous.com>
 <20190327001843.2420-2-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4exob3luluxypp5j"
Content-Disposition: inline
In-Reply-To: <20190327001843.2420-2-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4exob3luluxypp5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Mar 27, 2019 at 01:18:37AM +0100, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> TBS A711 tablet has a bcm20702a1 bluetooth chip (part of AP6210 WiFi/BT
> module) connected to UART1. Add node for the blutooth chip.
>
> The driver needs brcm/BCM20702A1.hcd firmware file to run.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4exob3luluxypp5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKHFBwAKCRDj7w1vZxhR
xXyLAP9bCWtNRTIAWTermq835YSBaQ22WJyb57nv83ywICiwqAEAok5eYrU4JfaB
nDiL02nHvIGGBQRuO2NiiLkRoPaShgU=
=t0jz
-----END PGP SIGNATURE-----

--4exob3luluxypp5j--
