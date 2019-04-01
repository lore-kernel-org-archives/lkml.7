Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FE8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6D82070D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfDAMxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:53:53 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:49451 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAMxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:53:53 -0400
Received: from localhost (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 8756C240010;
        Mon,  1 Apr 2019 12:53:47 +0000 (UTC)
Date:   Mon, 1 Apr 2019 14:53:47 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     megous@megous.com
Cc:     wens@csie.org, robh@kernel.org, johan@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 2/5] ARM: dts: sun8i: a83t: Add UART2 PB pins
Message-ID: <20190401125347.re6xxxmdyebeedio@flea>
References: <20190401115616.21337-1-megous@megous.com>
 <20190401115616.21337-3-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="guvnq22durxm67ch"
Content-Disposition: inline
In-Reply-To: <20190401115616.21337-3-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--guvnq22durxm67ch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 01, 2019 at 01:56:13PM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> Add pin definitions for UART2 PB pins. These are used on TBS-A711
> tablet.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--guvnq22durxm67ch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKIJ2wAKCRDj7w1vZxhR
xdLiAQDLAzxl56r1mUYu3amooQiT1X48AIWC8ofhNDXE94ODZgEA3gKF6lZtyiCO
fMVIPNKnXsohaRXY5KcZUJ0bZCgGjwQ=
=NLwK
-----END PGP SIGNATURE-----

--guvnq22durxm67ch--
