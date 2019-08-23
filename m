Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E37C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F044422CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394061AbfHWO4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:56:25 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:43927 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfHWO4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:56:24 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id C5C4F100004;
        Fri, 23 Aug 2019 14:56:21 +0000 (UTC)
Date:   Fri, 23 Aug 2019 16:56:21 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 05/10] ARM: dts: sunxi: a80: Add msgbox node
Message-ID: <20190823145621.pxl4jrux7izflzmg@flea>
References: <20190820032311.6506-1-samuel@sholland.org>
 <20190820032311.6506-6-samuel@sholland.org>
 <20190820081528.7g2lo4njkut5lanu@flea>
 <f3e3420e-450a-7d41-edf8-776c0cd5a320@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c4vbgluuko4stj5s"
Content-Disposition: inline
In-Reply-To: <f3e3420e-450a-7d41-edf8-776c0cd5a320@sholland.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c4vbgluuko4stj5s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Aug 20, 2019 at 08:17:49AM -0500, Samuel Holland wrote:
> On 8/20/19 3:15 AM, Maxime Ripard wrote:
> > On Mon, Aug 19, 2019 at 10:23:06PM -0500, Samuel Holland wrote:
> >> The A80 SoC contains a message box that can be used to send messages and
> >> interrupts back and forth between the ARM application CPUs and the ARISC
> >> coprocessor. Add a device tree node for it.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >
> > I think you mentionned that crust has been tested only on the A64 and
> > the H3/H5, did you test the mailbox on those other SoCs as well?
>
> No, I only have A64/H3/H5, and recently H6, hardware to test. I've looked
> through the manuals to verify that the registers are all the same, but I haven't
> run the driver on earlier SoCs.

I'd rather not merge them until they've been properly tested. We've
had some surprises with the documentation in the past :/

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--c4vbgluuko4stj5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXV/+lQAKCRDj7w1vZxhR
xXWQAPwKyvkn2KiTnIGYIVua45lADkdWOtD9xl/wV7233OeEOQEAr2kwv01eXmx9
SIGag0d/CuVhDIijFXIJeE/tUUHnJQ8=
=7n7e
-----END PGP SIGNATURE-----

--c4vbgluuko4stj5s--
