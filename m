Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DACC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4623E217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfDEPHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:07:10 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:48263 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEPHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:07:10 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 2512F1BF206;
        Fri,  5 Apr 2019 15:07:06 +0000 (UTC)
Date:   Fri, 5 Apr 2019 17:07:06 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     wens@csie.org, robh@kernel.org, johan@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v2 5/5] ARM: dts: sun8i: tbs-a711: Enable
 UART2 (for NEO-6M GPS module)
Message-ID: <20190405150706.jyeght2bbw7xgxf7@flea>
References: <20190401115616.21337-1-megous@megous.com>
 <20190401115616.21337-6-megous@megous.com>
 <20190404124322.aejij7qomgoco37u@core.my.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uwakmiup36vvgwaj"
Content-Disposition: inline
In-Reply-To: <20190404124322.aejij7qomgoco37u@core.my.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uwakmiup36vvgwaj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 02:43:22PM +0200, Ond=C5=99ej Jirman wrote:
> Hello Maxime,
>
> On Mon, Apr 01, 2019 at 01:56:16PM +0200, megous via linux-sunxi wrote:
> > From: Ondrej Jirman <megous@megous.com>
> >
> > TBS A711 tablet contains u-blox NEO-6M module connected to UART2.
> > Enable UART2 to gain access to the module from userspace.
>
> Other GPS bits are now applied (thank you, Johan), so if this last bit
> can go in too via a sunxi tree, the series will be complete.

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--uwakmiup36vvgwaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKdvGgAKCRDj7w1vZxhR
xRxXAQC03Gta5to+qN1+5WtOWtjTcudQ9DDHqL2MXyLIF7+XngEAmb8woERoUW7A
2uUvjtVRFN+dv8zaqPe/H1grGjLfPQY=
=DaMZ
-----END PGP SIGNATURE-----

--uwakmiup36vvgwaj--
