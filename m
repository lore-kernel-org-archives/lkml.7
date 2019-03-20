Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52CAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DCD2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCTRBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:01:02 -0400
Received: from sauhun.de ([88.99.104.3]:54984 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfCTRBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:01:02 -0400
Received: from localhost (p5486CF7E.dip0.t-ipconnect.de [84.134.207.126])
        by pokefinder.org (Postfix) with ESMTPSA id 022484A1346;
        Wed, 20 Mar 2019 18:00:59 +0100 (CET)
Date:   Wed, 20 Mar 2019 18:00:59 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Bich HEMON <bich.hemon@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Pierre Yves MORDRET <pierre-yves.mordret@st.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: i2c-stm32f7: improve loopback in timing algorithm
Message-ID: <20190320170059.2bkw4e62wo2vugbo@ninjato>
References: <1551885142-22365-1-git-send-email-bich.hemon@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jlxgfbkaiqonc2hk"
Content-Disposition: inline
In-Reply-To: <1551885142-22365-1-git-send-email-bich.hemon@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jlxgfbkaiqonc2hk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 03:12:32PM +0000, Bich HEMON wrote:
> From: Nicolas Le Bayon <nicolas.le.bayon@st.com>
>=20
> This avoids useless loops inside the I2C timing algorithm.
> Actually, we support only one possible solution per prescaler value.
> So after finding a solution with a prescaler, the algorithm can
> switch directly to the next prescaler value.
>=20
> Signed-off-by: Nicolas Le Bayon <nicolas.le.bayon@st.com>
> Signed-off-by: Bich Hemon <bich.hemon@st.com>

Applied to for-next, thanks!

Pierre-Yves, there are two binding patches for stm32 still open, if you
have some time for it...


--jlxgfbkaiqonc2hk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlySccsACgkQFA3kzBSg
Kbb1CA//RsWBLBogKq3sIipw89QpsZf+f5oNMl9ha+Olr8DPSwDWjJrvu3HNcdyw
Zl/jht9fZZj4exyIDePoGwu+ezJXcf+JOeKLyRuCHkf2Y8BYnsimC8D6HwuDe9SU
K7qR7j+Hqww6EcJKNwxfhWYc+ie4uUEUhGRuhTOTXkcp/Qd4qXZnfKZ8jN0jYGaJ
+T6q9JAvc4BLdF9S2frIvWSPnWPmpbgWOQ9edC6YMuzn0MBDPU29DiKLcGMrWSud
iXtj+cZpAPDYuox0Q7cC0Ot9rUPyJlSyz7glZzkQBTUhKTwaFxLwmODB6Pfp8AXY
HkFr3IHhEFH4QQHDtO1GFhQTvcxMph0Fdyo0jFs/c8OfWv1OVwKqR0v3/krdpaNm
HYhhdeR4cXkldmTH+iYtQirHskcB5TAzc7W8JhVBspgO15hiUi2HYaljTo9NjseP
tpXoCNrhqtjZjzSr3cxOLKhKWAPQDclFLbXxHXAXczJxDW4T+FtDNuitCLyrGw42
U7hl4aPO4QCkA3mNZpgeJRaJsW2zoiXKq8Qx6ShzOF18iseV8Aw6SjP8v1oJdUEl
WImd+oE2RPwujAkXfagPhFaAP9rJYegSV27P5OUKggnGQ55GOQFrrpbQPuJy8Ky/
z7rvk9UEy/jXQCXUdsaGS8PSZCaKQbvDEWsGH625BrDKATq3M/M=
=+MDo
-----END PGP SIGNATURE-----

--jlxgfbkaiqonc2hk--
