Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD60C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 09:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372CB207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 09:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfCIJys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 04:54:48 -0500
Received: from sauhun.de ([88.99.104.3]:40092 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfCIJys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 04:54:48 -0500
Received: from localhost (p5486CD1C.dip0.t-ipconnect.de [84.134.205.28])
        by pokefinder.org (Postfix) with ESMTPSA id 7B8712E3551;
        Sat,  9 Mar 2019 10:54:46 +0100 (CET)
Date:   Sat, 9 Mar 2019 10:54:46 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Louis Taylor <louis@kragniz.eu>
Cc:     jdelvare@suse.com, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        ndesaulniers@google.com, jflat@chromium.org
Subject: Re: [PATCH] i2c: sis630: correct format strings
Message-ID: <20190309095446.GE1340@kunai>
References: <20190302141836.24638-1-louis@kragniz.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Content-Disposition: inline
In-Reply-To: <20190302141836.24638-1-louis@kragniz.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2019 at 02:18:36PM +0000, Louis Taylor wrote:
> When compiling with -Wformat, clang warns:
>=20
> drivers/i2c/busses/i2c-sis630.c:482:4: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                         smbus_base + SMB_STS,
>                         ^~~~~~~~~~~~~~~~~~~~
>=20
> drivers/i2c/busses/i2c-sis630.c:483:4: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                         smbus_base + SMB_STS + SIS630_SMB_IOREGION - 1);
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> drivers/i2c/busses/i2c-sis630.c:531:37: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                  "SMBus SIS630 adapter at %04hx", smbus_base + SMB_STS);
>                                           ~~~~~   ^~~~~~~~~~~~~~~~~~~~
>=20
> This patch fixes the format strings to use the format type for int.
>=20
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Louis Taylor <louis@kragniz.eu>

Changed Jean's SoB to Rev-by and applied to for-current, thanks!


--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyDjWUACgkQFA3kzBSg
Kba4BA//URuSLZFn9QiesoENmp23IEa9uj3gb+Ur18/pJ7muucYLqj+GGrZ9HdD8
NBbhUhqulclF1Cfwm354o/eoTl8JzMKUxwox0IMn93B5PdvIDxmTvmynleNVsSHp
2biWLGIdgk+jKm9ylNUdhGDcc9FDq1p82rK2stWjq9iI+A1nSkabxauzh5res+ZT
NWJEkhHi0GfXC0P/Xoec1D+m0EpV7ll16QrNkHeFADntZ00y7Z3wEx9Gw7zuIwGb
h0vvWp/M+Pmx5d09dOYQT/+PjR0M5q0Dq7vCVx1bqb3/G8I/jt8QX2hkjLY3IFu2
mzTMJC6hU9Wvm9zLLjXjC7osFS1QaAzx+dgGA4nTudOWlmiNsxYmGHzsr6BHCkbQ
SlfnI+5WHqgKcxbgEofqHsXioawowMOJAV17YS7v2tAlarMLYRpHif5wu/nbmZxR
i547iTLGtow8hgYJiYPmrd6LulJiYMKq+JLO4EQFV62LsPZGqXnvQwdr3dnOMmto
14sLgYYsbf+m4tHoo6OaidBD//MHVDHOJ6yvEZYrEHWfo03Zp8CVPH4aBMaJL7hq
wKdkIc+I0a+J/39NuOhgjYeRXjzt0bl3bYlyKD5ldiQ+eNML1DhXZU6eQ/TvT2vu
dGZKwJdGEYGbcweoMoT6NZjPaO7v9J+qGXZ6/qhdykGYTMteprk=
=5puZ
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--
