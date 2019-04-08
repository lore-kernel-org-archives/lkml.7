Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451D5C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E6E20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfDHHOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:14:08 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:56179 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHHOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:14:08 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 22DE11BF211;
        Mon,  8 Apr 2019 07:14:04 +0000 (UTC)
Date:   Mon, 8 Apr 2019 09:14:04 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 2/5] dt-bindings: phy: add binding for Allwinner USB3
 PHY
Message-ID: <20190408071404.v3qjtivfqc2uz5le@flea>
References: <20190405205736.55177-1-icenowy@aosc.io>
 <20190405205736.55177-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="prlrlu4r6usqt5ir"
Content-Disposition: inline
In-Reply-To: <20190405205736.55177-3-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--prlrlu4r6usqt5ir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, Apr 06, 2019 at 04:57:33AM +0800, Icenowy Zheng wrote:
> The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
> external USB3 pins of the SoC.
>
> Add a device tree binding for the PHY.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

I know that this isn't the first iteration, and sorry if this comes
out a bit late, but could you make a YAML schemas for this instead?

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--prlrlu4r6usqt5ir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKr0oAAKCRDj7w1vZxhR
xXMqAP0YgCT45m6gg7ngQ8H92dTuBt1r4hgWyOWbsXVG2gE34AD9EYrkS4FqPFYu
PDMGPQgNpDDQ1x+lQ/A0AT5COK2iTA8=
=Wx7G
-----END PGP SIGNATURE-----

--prlrlu4r6usqt5ir--
