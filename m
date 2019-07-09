Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0888C73C56
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0317214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfGISJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:09:54 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:47080 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728659AbfGISJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:09:53 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkuYp-0006OU-O7; Tue, 09 Jul 2019 19:09:51 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkuYp-0002t6-6c; Tue, 09 Jul 2019 19:09:51 +0100
Message-ID: <a799791de346cdb6c19984e88ffe2fa57283476a.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 000/129] 3.16.70-rc1 review
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        Denis Kirjanov <kda@linux-powerpc.org>
Date:   Tue, 09 Jul 2019 19:09:50 +0100
In-Reply-To: <20190709180714.GA635@roeck-us.net>
References: <lsq.1562518456.876074874@decadent.org.uk>
         <20190709180714.GA635@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-rHITFnvIzEzDmVRalmbx"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rHITFnvIzEzDmVRalmbx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-07-09 at 11:07 -0700, Guenter Roeck wrote:
> On Sun, Jul 07, 2019 at 05:54:16PM +0100, Ben Hutchings wrote:
> > This is the start of the stable review cycle for the 3.16.70 release.
> > There are 129 patches in this series, which will be posted as responses
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Tue Jul 09 20:00:00 UTC 2019.
> > Anything received after that time might be too late.
> >=20
>=20
> For 3.16.69-129-g91dfb9bc310a:
>=20
> Build results:
> 	total: 136 pass: 136 fail: 0
> Qemu test results:
> 	total: 231 pass: 231 fail: 0

Great, thanks for checking again.

Ben.

--=20
Ben Hutchings
The Peter principle: In a hierarchy, every employee tends to rise to
their level of incompetence.



--=-rHITFnvIzEzDmVRalmbx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl0k2G4ACgkQ57/I7JWG
EQm9jBAAstP+bAJdl9wPrLSaLxhmtGDOTwYReHiebVEiGNhBY/tHQg0RA/bYpKz8
9ZZTS0bF+Bfzi3fedKnAVzzF5R65zo70rsHFOvk+eyUXLDGyH9VhapGp9tlP3sCX
qNnqm+DnsCfhfR/lMMwdKNGHILM1fHLGTxwdL6NRF1VoQjJN4BN+1iwBVXJTHur5
LN0O0OzmnyF0MhVK8QNJrBve5MYEgVx8wH9W9RXcUGJ87Nau8Xb/2fBng8cbdghj
kvdw9xo+XUhOTMSyizRpyWGjJ4FzTlvzUZopKJ5vYTnYVz70C0dLj2+KHKbbglTk
FqwDqcdlM1NKPlBOEQsmGAhzpdV4f7AONfKRQvxrGfcxaKF5usj8x/Z24Fkmmn8l
m6V+v2V2HDlWVYBrxjAUM1J3u3Juzar7eSjDevW5OSNmADVq6DbDdlHxFLpHGeiv
pkkpL6DleRCCI9wggsUMUyDZDmC5MWWVLpcmt9QwBqjGumtIopIOQOkgAGGxMXeu
hfF4F/v42ipxZGQsSid31xZCr8OuYWbqiY1Jss+eRkUoHa/3fTOjjAZDLyBFtdti
c8NQLAIyOG1gsHRoNpLN/buoQDbKpweZPQBy/IrXdSf1V7fclxdIUrkRqmgCsG5m
FJ1tBTHvK5UV0SWmi4sZmk8aMN6JwgcLCO+OOiF0x1NQ/S5PLXw=
=XeM5
-----END PGP SIGNATURE-----

--=-rHITFnvIzEzDmVRalmbx--
