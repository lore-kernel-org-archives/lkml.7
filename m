Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F636C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C1C20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbfCZTEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:04:20 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:47139 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731973AbfCZTET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:04:19 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 1B8FD40008;
        Tue, 26 Mar 2019 19:04:14 +0000 (UTC)
Date:   Tue, 26 Mar 2019 20:04:14 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Werner =?utf-8?B?QsO2bGxtYW5u?= <Werner.Boellmann@fh-dortmund.de>
Subject: Re: [PATCH] ARM: dts: sun7i: fix typos in uart pin mux
Message-ID: <20190326190414.3wpu37mhwgb4yqqd@flea>
References: <20190326112902.30080-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3zyf22ldyzrxmiqu"
Content-Disposition: inline
In-Reply-To: <20190326112902.30080-1-mans@mansr.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3zyf22ldyzrxmiqu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2019 at 11:29:02AM +0000, Mans Rullgard wrote:
> The recently added uart mux options had a few typos.  Fix them.
>
> Fixes: 43d0fe112585 ("ARM: dts: sun7i: add pinctrl for missing uart mux o=
ptions")
> Reported-by: Werner B=F6llmann <Werner.Boellmann@fh-dortmund.de>
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3zyf22ldyzrxmiqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJp3rgAKCRDj7w1vZxhR
xY1dAQDkyaP+lKiPAnxWYflN+o+niW0yDTlsHqXqYND4USUcwAD/aoZ0xUVNC6hy
oVyNyCuxs/15uQoMul6FtnvuZwJv3As=
=pzTO
-----END PGP SIGNATURE-----

--3zyf22ldyzrxmiqu--
