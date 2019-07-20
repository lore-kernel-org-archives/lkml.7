Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2DFC76196
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 08:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB0421873
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 08:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfGTI0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 04:26:15 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60491 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfGTI0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 04:26:14 -0400
X-Originating-IP: 91.163.65.175
Received: from localhost (91-163-65-175.subs.proxad.net [91.163.65.175])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A2B7860002;
        Sat, 20 Jul 2019 08:26:11 +0000 (UTC)
Date:   Sat, 20 Jul 2019 10:26:11 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jan Kotas <jank@cadence.com>
Cc:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] media: Add lane checks for Cadence CSI2TX
Message-ID: <20190720082611.qpsbrlwti3wydigk@flea>
References: <20190718111509.29924-1-jank@cadence.com>
 <20190718111509.29924-3-jank@cadence.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jgvxedzjy43xc5rm"
Content-Disposition: inline
In-Reply-To: <20190718111509.29924-3-jank@cadence.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jgvxedzjy43xc5rm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

65;5603;1c
On Thu, Jul 18, 2019 at 12:15:08PM +0100, Jan Kotas wrote:
> This patch adds line checks for CSI2TX, to prevent
> clock lane being used as a data lane.
>
> Signed-off-by: Jan Kotas <jank@cadence.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jgvxedzjy43xc5rm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXTLQIwAKCRDj7w1vZxhR
xatxAP0ZArJB75RtUGlL1iE13NnSYhngB3+XOjCzp1A1y09bgwEA6QhuXaYc0hxB
NdiD2xowXQPWP10goaY8YOoWs1DZQAs=
=Je75
-----END PGP SIGNATURE-----

--jgvxedzjy43xc5rm--
