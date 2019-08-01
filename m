Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83746C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AA420838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfHAUVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 16:21:47 -0400
Received: from sauhun.de ([88.99.104.3]:56804 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHAUVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 16:21:47 -0400
Received: from localhost (p54B333D2.dip0.t-ipconnect.de [84.179.51.210])
        by pokefinder.org (Postfix) with ESMTPSA id 7D2FE2CF684;
        Thu,  1 Aug 2019 22:21:44 +0200 (CEST)
Date:   Thu, 1 Aug 2019 22:21:44 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: linux-next: Fixes tag needs some work in the i2c tree
Message-ID: <20190801202143.GA16487@ninjato>
References: <20190802000252.74ada349@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20190802000252.74ada349@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

> In commit
>=20
>   9c5718e14b81 ("i2c: at91: disable TXRDY interrupt after sending data")
>=20
> Fixes tag
>=20
>   Fixes: fac368a0404 ("i2c: at91: add new driver")
>=20
> has these problem(s):
>=20
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").

Thanks for the report, I fixed it.

Micha=C5=82, please check your gitconfig to avoid these issue in the future.
And I will check why checkpatch didn't report this flaw to me.

Kind regards,

   Wolfram


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1DSdMACgkQFA3kzBSg
KbY9kg/+IjNTKlYEX5yiyVIkYDgPl1yCKrHTw59Xu9Mt7HhAaN/0ZZo4sV0wcVn8
eCppj7OF6MdrCkuN60YH63ynLg/2wkMrXo80h9iy1H66hQLWYoN4uX8xrYfD5LlP
Vm74p9wsZebbdBFP6hSMC/VOKLL79Kahebsr8qLEammSTVxPAXsszx/MWGZBJIf2
IVbdLSywqOig2KARPDeUUvG2YTnex3B7acraZB8p5zCWNG1uwOpU+ePzoK+6u9h7
+6O1E7YUOZZ3ENyYidwTZryNCgGI6bWf8vBziDu4+cLSNzXTNYfkbVcVkuWu8nY6
2SouJ3u+omzBj7UMfbItsScCWCXpQVB+wOKmXOMJb0tlWULLQVsNOoWqAUuRcWw0
s7swGhmIrJIOz7ym9UyKcCHvpZ3hm4eXju3S+vLPNeJDFRzsz4EdEf/OXqI0EwRt
GlPeASlKGHM7Ea3yxZj5cYDvU6U+76Sa3DvyrX00aYwyUwfx6EKyOPq1df4G33in
me7DNI+Z3AO72gx1mQXzy25BIbUIKxCUdqN5ZDbhG2NMYRiBQLn8zrS5EgfISlEr
qEldomEhDk7pwmquOq9gc0RBmysK46Mk/CXzHIc2xgCN+iQzHW0o5MscSYK6fWx0
6hwqDOG36C4PqcI8qUyhrWwKJ/hhXBYp6qyu3gJDKPe8Oe5gPzM=
=CqVz
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
