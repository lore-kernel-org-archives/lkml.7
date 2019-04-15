Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0997C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07C1206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfDOIEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:04:51 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:48007 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfDOIEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:04:51 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id A3FA1240018;
        Mon, 15 Apr 2019 08:04:44 +0000 (UTC)
Date:   Mon, 15 Apr 2019 10:04:43 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/4] dt-bindings: sound: sun4i-spdif: Add Allwinner H6
 compatible
Message-ID: <20190415080443.frubh4ln4agrdsfe@flea>
References: <20190411214422.2267-1-peron.clem@gmail.com>
 <20190411214422.2267-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="asihfkwa6t6ultx7"
Content-Disposition: inline
In-Reply-To: <20190411214422.2267-2-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--asihfkwa6t6ultx7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 11, 2019 at 11:44:19PM +0200, Cl=E9ment P=E9ron wrote:
> Allwinner H6 has a SPDIF controller with an increase of the fifo
> size and the possibility to output the master clock.
> However it's still compatible with the already existing driver for
> Allwiner H3.
>
> Add this compatible in the device-tree bindings documentation.

How was this tested?

After looking at the datasheet, it looks like it's still significantly
different. In particular:

  - The MCLK divider isn't at the same offset
  - The bits to flush the FIFO aren't at the same offset
  - The FIFO trigger levels aren't at the same offset
  - The FIFO status register layout is almost entirely different

So it doesn't really look compatible to me

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--asihfkwa6t6ultx7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLQ7GwAKCRDj7w1vZxhR
xeXDAQDHMpbzO3Xd4BiFTccIZGTf5U3cg5fsy8liJ1h36l0dkQD/eWFJGNLTdfgp
XIMHvRXdOlHga2dLvRe/m+JoPKzIYw4=
=LS+j
-----END PGP SIGNATURE-----

--asihfkwa6t6ultx7--
