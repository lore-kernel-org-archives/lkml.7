Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463CFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E645206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDCJ1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:27:03 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:38081 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfDCJ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:27:03 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 9E59824001B;
        Wed,  3 Apr 2019 09:26:55 +0000 (UTC)
Date:   Wed, 3 Apr 2019 11:26:55 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v4 3/5] media: sunxi: Add A10 CSI driver
Message-ID: <20190403092655.engthyfinpxvndh4@flea>
References: <cover.2aba8cbd95630d87f927465cc2beb881936c83d9.1553010938.git-series.maxime.ripard@bootlin.com>
 <bf348ec10d4444dd80eab0caddc4e2d3ce3131d4.1553010938.git-series.maxime.ripard@bootlin.com>
 <20190403091221.qd5ivgcoviazccv7@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zchbulmqh2lleyeb"
Content-Disposition: inline
In-Reply-To: <20190403091221.qd5ivgcoviazccv7@paasikivi.fi.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zchbulmqh2lleyeb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sakari,

On Wed, Apr 03, 2019 at 12:12:21PM +0300, Sakari Ailus wrote:
> Thanks for the update and my apologies for the late review.
>
> On Tue, Mar 19, 2019 at 04:55:46PM +0100, Maxime Ripard wrote:
> > The older CSI drivers have camera capture interface different from the one
> > in the newer ones.
> >
> > This IP is pretty simple. Some variants (one controller out of two
> > instances on some SoCs) have an ISP embedded, but there's no code that make
> > use of it, so we ignored that part for now.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Could you add a sub-device for the CSI-2 receiver, please?
>
> See e.g. drivers/media/pci/intel/ipu3/ipu3-cio2.c for an example.

It's confusing, I know, but this isn't a MIPI-CSI receiver. The IP is
called CSI, but it's only capable of handling parallel and BT656.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zchbulmqh2lleyeb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKR8XwAKCRDj7w1vZxhR
xWzTAQCO6onvJvAyxQ/6zEc/t+3ODQNIh2Kd0llgRcS0+j8TzgEA+9nsA6jNG3Rt
7u3CgLYRL2TexYqGU4lz12/2fB7ndAA=
=riar
-----END PGP SIGNATURE-----

--zchbulmqh2lleyeb--
