Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7BCC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3EF20848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfCYUc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:32:56 -0400
Received: from sauhun.de ([88.99.104.3]:48888 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729610AbfCYUc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:32:56 -0400
Received: from localhost (p54B33284.dip0.t-ipconnect.de [84.179.50.132])
        by pokefinder.org (Postfix) with ESMTPSA id 3F8BA2C0963;
        Mon, 25 Mar 2019 21:32:54 +0100 (CET)
Date:   Mon, 25 Mar 2019 21:32:53 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 2/4] regulator: da9063: convert header to SPDX
Message-ID: <20190325203253.GB7749@kunai>
References: <20190318155728.28365-1-wsa+renesas@sang-engineering.com>
 <20190318155728.28365-3-wsa+renesas@sang-engineering.com>
 <20190319125612.GB5514@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <20190319125612.GB5514@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +// SPDX-License-Identifier: GPL-2.0+
> >  /*
> >   * Regulator driver for DA9063 PMIC series
> >   *
>=20
> Please make the entire comment block C++ so this looks more intentional.

Ok.


--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyZOvUACgkQFA3kzBSg
KbbE/w/8C7f/X3oyoLlEaXjzCFFQlaq28anIQTXJmoTvnydzlfIROPXehk3CkKqR
tDiwPTMSA3LVVxd37Hy6+JxxXzuKOPRKovp9sXtHz4RnbdoIjJP8No/EuYgJFfb7
EOmgbIyaNqI0MV6mS/w5dMsvIJfSUlMIDEtiODOgiF9kx0Kksh+pwrb64OjXudKP
NDrj0ckENsegvRQESJr/rB3D4j7AFibWN/DmUhzmqu4ln8KYKJ/MNkeLtXItjXSx
ubzhxbHRgfRRa+dweEVxsdniqHRQs3fXKM/e32VIvrf24pkfKVqXGhQBgwg4SsPT
fScu7Uo1pUg13c3xJGNEmCbdOCSTVjoF0cq9qy/uScBGnoyjMk+3i91roWzqsOuI
CGRw+NvXUvPAat42KlUBNsZ5Fyowl/8ahw/QyuHiMnM9yGHW4lIREDKRyehrNg2B
TgUDB45q1K7RNmNSKyb7gfAIPHe940YUKLRGh9DYon25f8jxqCyXB1FuWwfP37H+
nCYHHNBxilpK8QVBaFXGhx5Ztvvt7MZm2QpwEJQRipucSDHzJrLs3iZh7McoIO0k
Tj4Q35p8EI4U0WCWNO6LpH/TzrNG0I2D2xzKLkcUHHTlRigAuCnX81Lno88jHPuT
1iSD9sJjvtjF/l3HqOj6gdegtxcvTbqDau7xoE6Z6rmjGBws3Ho=
=COvx
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
