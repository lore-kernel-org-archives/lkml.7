Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3686C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDED2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfCYKEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:04:35 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56623 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbfCYKEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:04:34 -0400
X-Originating-IP: 90.88.33.153
Received: from localhost (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7391760005;
        Mon, 25 Mar 2019 10:04:32 +0000 (UTC)
Date:   Mon, 25 Mar 2019 11:04:31 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: sun8i: a23/a33: Add R_I2C Controller
Message-ID: <20190325100431.zpkeljbf6vl35oa3@flea>
References: <20190318125613.25268-1-maxime.ripard@bootlin.com>
 <CAGb2v64HPVMyn8v5Fo9rBzsVE1CTTUv-YKpvbhUZLgWHxEyKLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nwk3dq2rjyksz5ik"
Content-Disposition: inline
In-Reply-To: <CAGb2v64HPVMyn8v5Fo9rBzsVE1CTTUv-YKpvbhUZLgWHxEyKLA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nwk3dq2rjyksz5ik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 22, 2019 at 04:55:29PM +0800, Chen-Yu Tsai wrote:
> On Mon, Mar 18, 2019 at 8:56 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > The A23 and A33 both have an I2C controller in the ARISC domain, that share
> > the same pins with the RSB bus.
> >
> > Even if it's an unusual configuration, that device can be used to drive the
> > PMIC, so let's use it.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nwk3dq2rjyksz5ik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJinrwAKCRDj7w1vZxhR
xSXJAQDtO79EwvtET/BBPZ8wIEi7Im6bcscAZwBRnVFVA30MHQD9ENysBNqdSGc2
/YMyqa47PWQ+NMb27kGIcRpfkgWe5gw=
=+xi3
-----END PGP SIGNATURE-----

--nwk3dq2rjyksz5ik--
