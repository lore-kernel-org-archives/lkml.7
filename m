Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5591C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C688217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfDWWRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:17:35 -0400
Received: from sauhun.de ([88.99.104.3]:56972 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfDWWRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:17:35 -0400
Received: from localhost (p5486CDD9.dip0.t-ipconnect.de [84.134.205.217])
        by pokefinder.org (Postfix) with ESMTPSA id A69342C7BF4;
        Wed, 24 Apr 2019 00:17:33 +0200 (CEST)
Date:   Wed, 24 Apr 2019 00:17:33 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>
Subject: Re: linux-next: Fixes tag needs some work in the i2c tree
Message-ID: <20190423221733.GG5659@kunai>
References: <20190424075535.7cdd5a73@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O8XZ+2Hy8Kj8wLPZ"
Content-Disposition: inline
In-Reply-To: <20190424075535.7cdd5a73@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O8XZ+2Hy8Kj8wLPZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> has these problem(s):
>=20
>   - missing space between the SHA1 and the subject

Thanks, I missed that. Pushed out a new for-next with it fixed.



--O8XZ+2Hy8Kj8wLPZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly/jvkACgkQFA3kzBSg
KbZnww//WlSZGKmE/Sypvtn7WUQl15QBQw6orXh9gPB4uSG6b9SnMLSxeKXdSCNT
asnJ2ZSLdChDh4KKzTeNgzninagjcLbEb9RLV9yojOzxzUssxpR1RwVf5ld3p53H
kVokrQvyL4JZf3zA/KBaWrJHjqWg63xuQVnEWjEbjWEl2HurntB7d0QFS1NuJvVn
te1XAcp1OMURsTsaMQnEN0fmFCD0lOhlIVbsQN5f2iT/Rh9xUmXHE1B4xWt1Ur22
EcMK6f/K3Qv1O7QDKYZBajakfU8CDEnOafYAfZagd3bLLHyflg8JwhkcbZ3qlqJo
gbv1AqP3n8bhNunFvAER0gG3XEXQibpFCC4Y0LCjSBwJI3uktA3ZcBHMgpt9trLU
MaD4XTrp555BWngl+AAiCT6SPAhfDNpJJgUIPQsBmYJkPdm8Qhk+JmUkK2aXkcqf
z1UVCnldkOOpN8Di2NeJl41z75fBUVWlC523T6VT2XHn18oJKISqUHOiM/aBn4/v
YMfOlmnWFYcJ/D2AqA2/0STl7Dsl1UE3tW4citbajuAURs1VJq9G1XvsR4vb/CZp
0XZ0HkSLf7qmQy/eKW6f86DDN6FhRRmxpIQ8zfu2YnXu7HXgm1hzLWkr1lulucvj
n4gGuvGK7b7jwXtQFc9nm5YAz3eLLnb/0W4MGJT8Cvf9tzCgXEc=
=Xa0u
-----END PGP SIGNATURE-----

--O8XZ+2Hy8Kj8wLPZ--
