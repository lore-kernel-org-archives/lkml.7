Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_RHS_DOB,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A555C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C837121479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389542AbfDRPt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:49:26 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:51245 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRPt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:49:26 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A3FEB200009;
        Thu, 18 Apr 2019 15:49:22 +0000 (UTC)
Date:   Thu, 18 Apr 2019 17:49:22 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Chen-Yu Tsai <wens@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 0/7] ARM: sun8i: a83t: Enable USB OTG
Message-ID: <20190418154922.rvvxpiznjiv7kpee@flea>
References: <20190416064024.20414-1-wens@kernel.org>
 <20190417212703.7qq3nzjdvnceaim2@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4s2awzwutf52hbae"
Content-Disposition: inline
In-Reply-To: <20190417212703.7qq3nzjdvnceaim2@earth.universe>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4s2awzwutf52hbae
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2019 at 11:27:03PM +0200, Sebastian Reichel wrote:
> Hi,
>
> On Tue, Apr 16, 2019 at 02:40:17PM +0800, Chen-Yu Tsai wrote:
> > This is v4 of my A83T USB power supply / OTG series. Hopefully this is
> > the last revision even though it's kind of late in the -rc cycle for
> > the patches to make the next release. Fingers crossed.
>
> Patches 1-5 (i.e. all except DTS) queued to power-supply subsystem.

Applied 6 and 7, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4s2awzwutf52hbae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLicggAKCRDj7w1vZxhR
xcjmAPsExx+ObhmzFPzNakWk+3jIHQv5lf/NKwHkfKZlj+44+gD+MAClY05iAllo
tQybyFGM7nvD7QeOLO5vixGfmIh2cQU=
=S8Za
-----END PGP SIGNATURE-----

--4s2awzwutf52hbae--
