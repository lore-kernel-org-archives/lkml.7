Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54906C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C22820643
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbfDAIAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:00:35 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:57959 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731944AbfDAIAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:00:35 -0400
X-Originating-IP: 90.88.32.136
Received: from localhost (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 93B26FF806;
        Mon,  1 Apr 2019 08:00:31 +0000 (UTC)
Date:   Mon, 1 Apr 2019 10:00:31 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     megous@megous.com
Cc:     wens@csie.org, robh@kernel.org, johan@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 3/7] ARM: dts: sun8i: a83t: Add nodes for UART2-UART4
Message-ID: <20190401080031.4yb2dlfw5rv42pyu@flea>
References: <20190327001843.2420-1-megous@megous.com>
 <20190327001843.2420-4-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ipqf2kip3uz4jx2u"
Content-Disposition: inline
In-Reply-To: <20190327001843.2420-4-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ipqf2kip3uz4jx2u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2019 at 01:18:39AM +0100, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> A83T has 5 UART interfaces, but only the first two have their nodes
> defined in sun8i-a83t.dtsi. Add nodes for the missing interfaces.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ipqf2kip3uz4jx2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKHFHgAKCRDj7w1vZxhR
xby9AP46HhjIUl+lpxGIlaMwtUJcIXOB+KAMzVPKTuj8/9swxwD/bZYnyEwfxhBE
tE3w+ZNvLj4EtfAXDFHf+//qXUaE9Q4=
=k6ia
-----END PGP SIGNATURE-----

--ipqf2kip3uz4jx2u--
