Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C4FC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71667214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfE0TjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 15:39:25 -0400
Received: from sauhun.de ([88.99.104.3]:36340 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbfE0TjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 15:39:24 -0400
Received: from localhost (p5486CF59.dip0.t-ipconnect.de [84.134.207.89])
        by pokefinder.org (Postfix) with ESMTPSA id 231832C04C2;
        Mon, 27 May 2019 21:39:23 +0200 (CEST)
Date:   Mon, 27 May 2019 21:39:22 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: jz4780: Drop dependency on MACH_JZ4780
Message-ID: <20190527193922.GJ8808@kunai>
References: <20190522170516.15086-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kr14OxHsRwZHHqxS"
Content-Disposition: inline
In-Reply-To: <20190522170516.15086-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kr14OxHsRwZHHqxS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2019 at 07:05:16PM +0200, Paul Cercueil wrote:
> Depending on MACH_JZ4780 prevent us from creating a generic kernel that
> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied to for-next, thanks!


--kr14OxHsRwZHHqxS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlzsPOoACgkQFA3kzBSg
KbY7Nw//c4+JJyfBfaiAxWqQVmZ2jb25asyRJSNcP/Ln7IScKam6hOMX/IMwEvTg
3t0n+baRVBq6WuQrXaZViEfyGld20WYF/Lh1NREq9nC+1Oe84K56gvDFPrBuNXrV
AGBrbB7NxTfiAmGu4nsMgvnOIOsGMreMS6vf4hRZEh6l5ZxoBgVGTHo0zYUfSiAY
HB12SU8KgTzZuS2l2CGj9hZBplwU5a/fhjnXdUgdSorvs5vfCqJSJSOSUddQq32A
HQxdVqbcjKQyMgMFZNZ/cZEdMX4wFaYH8212V/LXNEEzO9ZPVzAgnXDSqZ/Kb7rL
HmOEupgR614Eg1q6fXzMXUFb3bT4HSnx+gWdl/KllZ/Sy5iTlwafhp1YklboaZE3
6KGBbmpYWIzuvBVUjSxE2C01NfrYZQ8AijACUx8PRDcu/yrc0HNbTaVeAZH1tgyo
zvqOe4YUd0XcShVDY6cWe3Qt4YLsBKBoMA0ysnjf1bKwMZtxTzzOXffXFcPF/7AN
Qr7Z+6qSGXeUoF/Cz1oitk3zdhv1YSXhF+EdBjhwyz1ekEGqNKJiVQIyDuGnxy/z
HyfQHwi2hWCc2ssUSbqki3sZ9B2/F3Rw2FABw2lxxwCYbAyIYwDlvuv7UOSHjs7W
3AXluDU6VPVOAnqjQhDl9cSS1hQJCL+0yGwBADxjkbcCWEndTI8=
=mF0b
-----END PGP SIGNATURE-----

--kr14OxHsRwZHHqxS--
