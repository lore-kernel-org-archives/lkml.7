Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96901C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C742067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfD1PpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:45:20 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41714 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbfD1PpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 11:45:20 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKlzP-0007nf-U8; Sun, 28 Apr 2019 16:45:16 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKlzP-0000OJ-GV; Sun, 28 Apr 2019 16:45:15 +0100
Message-ID: <8278b336bc8e846df58bd2b8312cb2804cf75d64.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 000/202] 3.16.66-rc1 review
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        Denis Kirjanov <kda@linux-powerpc.org>
Date:   Sun, 28 Apr 2019 16:45:01 +0100
In-Reply-To: <75f5b016-011b-8183-3d55-1fb3ddedfa7d@roeck-us.net>
References: <lsq.1556377988.384060557@decadent.org.uk>
         <75f5b016-011b-8183-3d55-1fb3ddedfa7d@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-q/GqWTcwXalZcSqFcOZF"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q/GqWTcwXalZcSqFcOZF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-04-27 at 11:41 -0700, Guenter Roeck wrote:
> On 4/27/19 8:13 AM, Ben Hutchings wrote:
> > This is the start of the stable review cycle for the 3.16.66 release.
> > There are 202 patches in this series, which will be posted as responses
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Wed May 01 18:00:00 UTC 2019.
> > Anything received after that time might be too late.
> >=20
>=20
> Build results:
> 	total: 137 pass: 136 fail: 1
> Failed builds:
> 	i386:tools/perf
> Qemu test results:
> 	total: 226 pass: 226 fail: 0

Thanks for checking,

Ben.

--=20
Ben Hutchings
Power corrupts.  Absolute power is kind of neat. - John Lehman



--=-q/GqWTcwXalZcSqFcOZF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlzFyn0ACgkQ57/I7JWG
EQlAbxAAkfxxqr1o3I2hYtG9qWwRt9KOiLln/VEVsevcsyHI+Fgg5Mvwi2ZE4pd2
tgDyHQwNcjN3FMGbUdqdKF0xRifcOy6t+ZG1mykMlkMAWde6tY8zSTZrKaK0zlgN
0ixxmu2wep6lqE5lQWHcjTrfR8WagKPxG8rDq6jSrcpt4EMjID1aMEU5l4EfQayQ
1N/ITprmMr0AiRp7AUt3Of3r41W+xI8Tj744F6hYaH6lmxs8perIkEKJltJYCI4F
S/1YbvTH2CQzHW4TXEhSoGvx56GFEVVwLN8ekOP807Y5y9zt+XldZzZS/M5J+d+O
rvrwc81q4HmN8Nq4B0s/k9E9zHgjWKPn55uBHY4bjz8NHeIIbwgWUNkqv6d2yCww
FPZ6BxkJjA+1g9oyklGwhFwMC5PYvCPg45Kpn4tS615wntpjl3pC3FenIZPjM0dL
5JnvECNuD6WcUu8H+7HfJ6Y+x0CmlhB0POFARkIEUvLjDZ9kQdjN0/OwR9YroVwn
2gRQFlbDQklWc5Wo5Ohahrkfy8C2G6sW4lNL3Gk3OsALJOiM64/WdUCGuQ2yL0Ml
PQ9Cu35cB9ngPJGeKEygsKrcpoGP+0h1YRb2hcxhbMyb0vyUJYiNzlh1l8HdtSfT
q+UD5mtVGMs+HuPaMHxqjOvhOQfI1IuVsOxbfUMJYsoBwiRkNyo=
=qJR9
-----END PGP SIGNATURE-----

--=-q/GqWTcwXalZcSqFcOZF--
