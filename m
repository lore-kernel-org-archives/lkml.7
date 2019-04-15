Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16430C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08A0206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfDOIFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:05:39 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47511 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOIFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:05:39 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 6F0181BF214;
        Mon, 15 Apr 2019 08:05:36 +0000 (UTC)
Date:   Mon, 15 Apr 2019 10:05:35 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3] ARM: sun8i: h3: bluetooth for Banana Pi M2 Zero board
Message-ID: <20190415080535.o6crd2nrcwgoj456@flea>
References: <20190412045832.5109-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pualiwtqtftt3t5p"
Content-Disposition: inline
In-Reply-To: <20190412045832.5109-1-andreas@kemnade.info>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pualiwtqtftt3t5p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2019 at 06:58:32AM +0200, Andreas Kemnade wrote:
> The Banana Pi M2 Zero board has an AP6212 BT+Wifi combo chip
> with Broadcom internals attached to UART1 and some gpios.
> This addition is in line with similar boards.
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--pualiwtqtftt3t5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLQ7TwAKCRDj7w1vZxhR
xZdJAPiHblBbVt1h/raCZOy68/tiqax8uwfDI1De/hLc9w5WAQCR+XEJ5IJiPNbu
VHPDEEkUSBQrMGEZJaPNsC5TL9QxAg==
=ZIu1
-----END PGP SIGNATURE-----

--pualiwtqtftt3t5p--
