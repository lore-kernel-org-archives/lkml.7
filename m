Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD0C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6A82086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfHPLdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 07:33:39 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:47015 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfHPLdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 07:33:39 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 335AC1C000C;
        Fri, 16 Aug 2019 11:33:36 +0000 (UTC)
Date:   Fri, 16 Aug 2019 13:33:35 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Bhushan Shah <bshah@kde.org>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] arm64: allwinner: h6: add I2C nodes
Message-ID: <20190816113335.batwi6pzqzmhyawj@flea>
References: <20190816064710.18280-1-bshah@kde.org>
 <20190816084309.27440-1-bshah@kde.org>
 <20190816084309.27440-3-bshah@kde.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ppy6an5g7i5haodz"
Content-Disposition: inline
In-Reply-To: <20190816084309.27440-3-bshah@kde.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ppy6an5g7i5haodz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2019 at 02:13:09PM +0530, Bhushan Shah wrote:
> Add device-tree nodes for i2c0 to i2c2, and also add relevant pinctrl
> nodes.
>
> Suggested-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Bhushan Shah <bshah@kde.org>

Applied both, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ppy6an5g7i5haodz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVaUjwAKCRDj7w1vZxhR
xbvPAQCxPEDajlZRJ/kowjeSYrQ4vo1znAPorrycP3jLr4Dm1gD7BTNnwlT+7Uuv
E4j3yvIY5b0wQZD3KcD/CTUlMc/umgo=
=16mw
-----END PGP SIGNATURE-----

--ppy6an5g7i5haodz--
