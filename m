Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6095BC31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4636F2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436905AbfFLITc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:19:32 -0400
Received: from sauhun.de ([88.99.104.3]:57206 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405119AbfFLITc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:19:32 -0400
Received: from localhost (p5486CACA.dip0.t-ipconnect.de [84.134.202.202])
        by pokefinder.org (Postfix) with ESMTPSA id 3E7592C54BC;
        Wed, 12 Jun 2019 10:19:30 +0200 (CEST)
Date:   Wed, 12 Jun 2019 10:19:29 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ruslan Babayev <ruslan@babayev.com>,
        Andrew de Quincey <adq_dvb@lidskialf.net>,
        Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: linux-next: build warning after merge of the i2c tree
Message-ID: <20190612081929.GA1687@kunai>
References: <20190611102528.44ad5783@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20190611102528.44ad5783@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2019 at 10:25:28AM +1000, Stephen Rothwell wrote:
> Hi Wolfram,
>=20
> After merging the i2c tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
>=20
> drivers/media/dvb-frontends/tua6100.c: In function 'tua6100_set_params':
> drivers/media/dvb-frontends/tua6100.c:71: warning: "_P" redefined
>  #define _P 32
> =20
> In file included from include/acpi/platform/aclinux.h:54,
>                  from include/acpi/platform/acenv.h:152,
>                  from include/acpi/acpi.h:22,
>                  from include/linux/acpi.h:21,
>                  from include/linux/i2c.h:17,
>                  from drivers/media/dvb-frontends/tua6100.h:22,
>                  from drivers/media/dvb-frontends/tua6100.c:24:
> include/linux/ctype.h:14: note: this is the location of the previous defi=
nition
>  #define _P 0x10 /* punct */
>=20
> Exposed by commit
>=20
>   5213d7efc8ec ("i2c: acpi: export i2c_acpi_find_adapter_by_handle")
>=20
> Since that included <linux/acpi.h> from <linux/i2c.h>
>=20
> Originally introduced by commit
>=20
>   00be2e7c6415 ("V4L/DVB (4606): Add driver for TUA6100")
>=20
> The _P in <linux/ctype.h> has existed since before git.

I suggest to fix the driver by adding a TUA6100_ prefix to the defines.
I can cook up a patch for that.


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0AtY0ACgkQFA3kzBSg
KbZXRQ/8CFxPBUekWlz/8Hn+f4kLBoT6KgVQeQ1yTyDEgh9UOnw0CeeKGXm9FjpQ
9/r7ZcfB9RgtgKpvGggN4/KayjS6xICzMAO6TOviodCKiFzwzV2FUxPb0kiOwoHE
XMGdx09Z1zZTfSUxC/xz69Fe400iqjROIkr0D2HlQS9EZzJuYBgz1fOs/+Vq0Qym
j/f5JbHgb6SD/Rr1oQkmARur71pk7cA552qr7qlabGyLAuJ/PobwGpt4zSvcFk+R
KXyhf4IbE1qkCohVo9FTCPrOVPCZrjm0c1PrCAZM84Oj3h/zN2Y8DppjhkIhZTyf
qUj1W/UWk2UwjwSaAxI3K1ceN8WKR3zg537ZrcRFSgZWotpjb6ZLBDLgtCY0l3bz
Q1IpaHtBlV+6jPm3CGd+eizl/ateQFrKTF/9LdbK8HSUbGNXipIFDTufPfctw3qA
EwTQASlqby/JJN6yC8LsGLwYB07izHL9NoEyitxM4WjhLBLs98uU8mlxb7/WaneO
ThIG37oV6/vV/x6VUWrmQjkz2uV9FAGIDmWI4iCJzZnYHctYEG2o1pAoR7XPB9Xi
IZf5OLSk5D494cGl/mewcTsNNkmGnOO3yJEnJ+Hp9fGvqS9QTNHsJ0Z6WpmZ1Qd6
lBHttZTbUT1lAse2jZTkwbFkrSCTq7E383Md1rkc2heySCzciiQ=
=Ns/s
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
