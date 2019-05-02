Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1F2C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FC520873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfEBHnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:43:07 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:53267 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfEBHnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:43:07 -0400
X-Originating-IP: 90.88.149.145
Received: from localhost (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B41D020011;
        Thu,  2 May 2019 07:43:04 +0000 (UTC)
Date:   Thu, 2 May 2019 09:43:03 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: h6: add PIO VCC bank supplies for
 Pine H64
Message-ID: <20190502074303.g3px63n4v4o7xade@flea>
References: <20190424062543.61852-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f3jn7gc357berrvh"
Content-Disposition: inline
In-Reply-To: <20190424062543.61852-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f3jn7gc357berrvh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Apr 24, 2019 at 02:25:43PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC features tweakable VCC for PC, PD, PG, PL and PM
> banks.
>
> This patch adds supplies for PC and PD banks on Pine H64 board. PG and
> PM banks are used for Wi-Fi and should be added when Wi-Fi is added

Not really. The regulator is still there, whether we use it or not. If
it's not used, then it will be left disabled so it doesn't really
change anything.

> PL bank is where PMIC is attached, and currently if a PMIC regulator
> is added for it a dependency loop will happen.

I guess we should fix that somehow

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--f3jn7gc357berrvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXMqfhwAKCRDj7w1vZxhR
xWucAQClyRc5w0vqs/DJtid7PAu+23gMPpEUsQQSF8S+8ic9HAEAgLsd09rNNQMB
pW4cdag9Xgoxi+5JqmFgud0nZzfNMgA=
=5qv5
-----END PGP SIGNATURE-----

--f3jn7gc357berrvh--
