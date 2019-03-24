Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CE0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5087120880
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfCXVoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 17:44:12 -0400
Received: from sauhun.de ([88.99.104.3]:40860 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbfCXVoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 17:44:12 -0400
Received: from localhost (p54B33218.dip0.t-ipconnect.de [84.179.50.24])
        by pokefinder.org (Postfix) with ESMTPSA id A4F5A2C0114;
        Sun, 24 Mar 2019 22:44:09 +0100 (CET)
Date:   Sun, 24 Mar 2019 22:44:09 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        me@jue.yt, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v5 0/3] i2c: at91: slave mode support
Message-ID: <20190324214409.GA6934@kunai>
References: <20190222092522.4913-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20190222092522.4913-1-ludovic.desroches@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 10:25:19AM +0100, Ludovic Desroches wrote:
> [Ludovic Desroches: see Changes section]
>=20
> Based on the discussion we had on the i2c-linux list [1], I wrote a patch=
 for
> AT91 hardware and tried to fulfill the Linux I2C slave interface descript=
ion
> [2] as good as possible. This enables aforementioned hardware to act as a=
n I2C
> slave that can be accessed by a remote I2C master.

After this was successfully checked by buildbot in a seperate branch:

Applied to for-next, thanks!


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyX+iQACgkQFA3kzBSg
Kbabrg/8CbHndAD7O6/74B5m4f+lShCnhoWG2L0gbgaqTWd0tbgS/0CisLsSyv2/
N/BDaNdGGE+gBx8G55e2e0NfsohRUpMvdDOvrI/juCJW5T9xJreLC9OviYaI2rhY
S7HhrLaoDebK7gnRAi7prQFnA7edAwyQcy0Cc/3etuTnp6dI/d0TNqBDo91QlBHQ
ABhJtg1BvX7zZngUSm8vyn0cwGNE5HDoaJVBkUxe1PXuzM4EBeB7f5ODiiFFlmBy
N7cNwMEa3qfUD8KY31LFHBdE2Ds5uS/KTKAbH5c+HnVzIXztbwwtX5WCiyygywFn
d2peA67zb706tGe0QcGLiE6QQGUhkUZ6rlkujd/5Oi3NnbfXkQnmPQh18bgECZfU
7fd3AZnqIl4IC0Qem99sIieWKEn2e621TXig/0xgyloJ0QD/h/PmE7Fze4tULWsY
lt1ZJKVcsVUdLHRnB05drY2m1FjfkjsVKkoe0kJcSO9AOmaj08jjQm9koD5BRnqj
1RcckO9IAyq1m41bhaGulLLxhUkD9GSErDQd5L7nVhDhN39WC6jr5RgFIwIAOoM6
nNB5YDe14KkP239zhbBgoNq1fDsqeMexNh8seHheqKIIaC7FC7VauP5o+o0glrhR
fXcBxXwekk4jnvHXXvWZHR59ygonuKy1uKqb5HiLkLEaDevdWL8=
=N1yE
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
