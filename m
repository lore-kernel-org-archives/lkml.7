Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468E4C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F07F20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfDHIOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:14:18 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43607 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfDHIOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:14:08 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0064F2001C;
        Mon,  8 Apr 2019 08:14:05 +0000 (UTC)
Date:   Mon, 8 Apr 2019 10:14:04 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: sun8i: h3: bluetooth for Banana Pi M2 Zero board
Message-ID: <20190408081404.554zdbcotnidljsl@flea>
References: <20190301185212.26837-1-andreas@kemnade.info>
 <20190407222321.11ec297d@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w7mdkyzl5owisrss"
Content-Disposition: inline
In-Reply-To: <20190407222321.11ec297d@kemnade.info>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w7mdkyzl5owisrss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 07, 2019 at 10:23:21PM +0200, Andreas Kemnade wrote:
> ping
>
> On Fri,  1 Mar 2019 19:52:12 +0100
> Andreas Kemnade <andreas@kemnade.info> wrote:
>
> > The Banana Pi M2 Zero board has an AP6212 BT+Wifi combo chip
> > with broadcom internals attached to UART1 and some gpios.
> > This addition is in line with similar boards
> >
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

I never received that patch, who did you send it to?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--w7mdkyzl5owisrss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKsCzAAKCRDj7w1vZxhR
xUUqAP9y4Ujz0rOjboyTKXGQVmOGtRC3JvXkVjDOBiNEHkR2iQEAx9/ZjYxtwpIh
wW4JoKzyToTZwZ3Yrym2wuMKKRNQ2Qw=
=1pBw
-----END PGP SIGNATURE-----

--w7mdkyzl5owisrss--
