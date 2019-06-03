Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54317C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3225127CEA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfFCHm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:42:59 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:50995 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfFCHm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:42:59 -0400
Received: from localhost (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 8ECBB100016;
        Mon,  3 Jun 2019 07:42:47 +0000 (UTC)
Date:   Mon, 3 Jun 2019 09:42:47 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add lradc node
Message-ID: <20190603074247.hlayod2pxq55f6ci@flea>
References: <20190518170929.24789-1-luca@z3ntu.xyz>
 <4343071.IDWclfcoxo@g550jk>
 <20190524092001.ztf3kntaj4uiswnv@flea>
 <6901794.oDhxEVzEqc@g550jk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pck2udhpnuo5jdg4"
Content-Disposition: inline
In-Reply-To: <6901794.oDhxEVzEqc@g550jk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pck2udhpnuo5jdg4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, May 31, 2019 at 12:27:55PM +0200, Luca Weiss wrote:
> On Freitag, 24. Mai 2019 11:20:01 CEST Maxime Ripard wrote:
> >
> > It would be great to drop the -keys from the compatible, and to
> > document the bindings
> >
> > Looks good otherwise
> >
> > Maxime
>
> So I should just document the "allwinner,sun50i-a64-lradc" string in
> Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt ? Don't I also
> have to add the compatible to the driver code then? Just adding the a64
> compatible to a dts wouldn't work without that.

What I meant was that you needed both, something like:

compatible = "allwinner,sun50i-a64-lradc", "allwinner,sun8i-a83t-lradc";

That way, the OS will try to match a driver for the A64 compatible if
any, and fallback to the A83's otherwise. And since we don't have any
quirk at the moment, there's no change needed to the driver.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--pck2udhpnuo5jdg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPTPdwAKCRDj7w1vZxhR
xdBQAQCizjZAoJNebpV+1K7cJAfYCjktS+jc7qUnLh5ZXhZI3AEA46RCz7UuQmCi
CFyLUjFOAPabqusD+2Y5LmXDs76vYg4=
=CmYf
-----END PGP SIGNATURE-----

--pck2udhpnuo5jdg4--
