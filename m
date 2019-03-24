Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41E7C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E1321019
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfCXXZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 19:25:14 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40676 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727275AbfCXXZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 19:25:14 -0400
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1h8CUJ-0005Pa-NF; Sun, 24 Mar 2019 23:25:11 +0000
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1h8CUJ-0002Ng-A2; Sun, 24 Mar 2019 23:25:11 +0000
Message-ID: <ab2388b2898f4aa21de9f76e0407bbc4f0224f95.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 00/16] 3.16.64-rc1 review
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        Denis Kirjanov <kda@linux-powerpc.org>
Date:   Sun, 24 Mar 2019 23:25:10 +0000
In-Reply-To: <1152dd86-bb63-dd64-9a96-36588de82889@roeck-us.net>
References: <lsq.1553232017.771830163@decadent.org.uk>
         <917fab4a-f8b1-760c-2e7d-22156f580276@roeck-us.net>
         <1152dd86-bb63-dd64-9a96-36588de82889@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-sWKNI4J2YJsNa1z/sssw"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sWKNI4J2YJsNa1z/sssw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-03-22 at 21:43 -0700, Guenter Roeck wrote:
> On 3/22/19 6:44 AM, Guenter Roeck wrote:
> > On 3/21/19 10:20 PM, Ben Hutchings wrote:
> > > This is the start of the stable review cycle for the 3.16.64 release.
> > > There are 16 patches in this series, which will be posted as response=
s
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >=20
> > > Responses should be made by Mon Mar 25 18:00:00 UTC 2019.
> > > Anything received after that time might be too late.
> > >=20
> >=20
> > Build results:
> >      total: 137 pass: 136 fail: 1
> > Failed builds:
> >      i386:tools/perf
> > Qemu test results:
> >      total: 222 pass: 221 fail: 1
> > Failed tests:
> >      arm:midway:multi_v7_defconfig:mem2G:ecx-2000:initrd
> >=20
> > The failed qemu test simply hangs. The test passes with v3.16.63.
> > I started a bisect.
> >=20
>=20
> False positive.
>=20
> Sorry for the noise.

Thanks a lot for testing.

Ben.

--=20
Ben Hutchings
Larkinson's Law: All laws are basically false.



--=-sWKNI4J2YJsNa1z/sssw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlyYEdcACgkQ57/I7JWG
EQlWYw/+P4xi8ilbRtAya5aGKZxf4u3kRPKQ2x76kK3nKe1/R107AJF/DFZ2kL0z
ef5NkPCpmiKCVGwFJy77F5zOd9pncafSdDpeesrzwXgir85cLb3r3Xua6hB1aXad
Ef1e4prImJ2bCojksqeJSLACIxUgxdHZmYd/m5ph8bQHLOkN9FGOD0MsNRZZgomR
u+wUBH73J9QqFYD3/bjn/N6WhjgHPKsn/nw/TtcSPLXAwB5ub8BV1oAPbD+eKSAE
8pUXY0u1GgLtivdtkmOf/BHliBaCe7olahisdH2puOpeDQfRlI898rskHo8cBGKV
DcfGC8pr9UdCdj1tY2kdEb8OlfGyeGgi5cfIZoMYQdmZaQLWJrEHF+ISWDsFVUzH
m5yzzv15eqPjJpsyBweM49e2Yri3SsUTLvo5+kWm1nmuxSzXoREwMWGHRMlSNNHS
O0bD+wIq9/8z/qlp6ELX6Fve12N2PsyfSEOXM6tGKx1Gg2p+r539o6vebIibXwP5
GrmFHQlSZjS4dyZvZAcwdfzbeKvqP977L3qlRQSopmrBvWJ2EthnvlZbLlC9PN1X
UEYYheh4isHWKrzS/Bvgr3uejB8bb/WyfN3W2YWOzNWMiM+nMNH/W5YrbmrR1Ghj
/8wH4mPVkPRYPcwbIhQE3NNpCjErSYaKPDIeXGD6syHRs5CRP24=
=NU5w
-----END PGP SIGNATURE-----

--=-sWKNI4J2YJsNa1z/sssw--
