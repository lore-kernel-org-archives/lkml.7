Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E20C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB38204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfEGJsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:48:38 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:59839 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfEGJsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:48:38 -0400
Received: from localhost (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id A650D100005;
        Tue,  7 May 2019 09:48:34 +0000 (UTC)
Date:   Tue, 7 May 2019 11:48:34 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: allwinner: h6: Enable HDMI output on
 orangepi 3
Message-ID: <20190507094834.i6cj3ht37bqovn6c@flea>
References: <20190420145240.27400-1-tiny.windzz@gmail.com>
 <20190502073401.3l3fl4alicyzpud7@flea>
 <20190507093535.uapqhxduwtbdgbtq@core.my.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kbuqvbgavmodme4h"
Content-Disposition: inline
In-Reply-To: <20190507093535.uapqhxduwtbdgbtq@core.my.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kbuqvbgavmodme4h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 11:35:35AM +0200, Ond=C5=99ej Jirman wrote:
> Hi Maxime,
>
> On Thu, May 02, 2019 at 09:34:01AM +0200, Maxime Ripard wrote:
> > On Sat, Apr 20, 2019 at 10:52:40AM -0400, Yangtao Li wrote:
> > > Orangepi 3 has HDMI type A connector.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> >
> > Queued for 5.3, thanks!
> > Maxime
>
> This patch is not enough. HDMI support on Orange Pi 3 also needs to
> enable DDC IO. While the SoC will feed some default output singal
> into the display, without DDC enabled it will not work reliably.
>
> That support is part of my Orange Pi 3 series, and will be reworked
> for v5 of that series.
>
> While I can rebase on top of this, it would be easier if you dropped
> this patch until the propper support is ready. I don't see any reason
> why this should be rushed with half-working solution.

ACK, consider it dropped.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--kbuqvbgavmodme4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXNFUcQAKCRDj7w1vZxhR
xRC6AQCarXhXeoier2SFZd5W+nAp7LskYqHAVzQJWKXlWvdsAAEA5ewi2CIOkpfW
D2p0TKo40WynsYAFuFD/Ug75A2IFbQ4=
=Qui5
-----END PGP SIGNATURE-----

--kbuqvbgavmodme4h--
