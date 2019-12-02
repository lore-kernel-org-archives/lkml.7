Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF052C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 00:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC3420881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 00:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KlHLiuVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfLBATf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 19:19:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:40179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbfLBATf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 19:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575245969;
        bh=tV2kfJnJSdTdIr7Ps2AnmtxR9DGkfzjZII/HdaPqu2M=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KlHLiuVaOBd4mKI4BCQUSvNRCPl8ARefOB49YMaP2wTobrmhAGLqTu7yodbtqoo3u
         WrUErq7tEgkuEQGV2RP8jTSk9ooft29JgurYDcGa7vWzAX2Bu+hufuLoTwAWmxewCt
         qHdq0IIDhWpSxDQsNoU6r3sg5VpGBqB4O42szENc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.102]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMofc-1iIo8D30ku-00IpQs; Mon, 02
 Dec 2019 01:19:29 +0100
Date:   Mon, 2 Dec 2019 01:19:28 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PULL] Documentation for 5.5
Message-ID: <20191202001928.GA4146@latitude>
References: <20191126093002.06ece6dd@lwn.net>
 <CAHk-=whH-wrF7dx_+NgpYi8pK0vovE2mEFE3sgEYXAQZcPwBjA@mail.gmail.com>
 <20191130171428.6c09f892@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20191130171428.6c09f892@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:4gNqU4/I/EbdcWnb41uvU/DGVpdpSEFnA27YIf93++D6TcXhoOP
 eiborndJQqHECFBbeAeRxVInTGLHqs8KxwrXFpj0c2f5lzMVFRX0PW9+We7GAvzeuLZDr/d
 GkEBuYPvdeWfE5VF3D4eFHHYk1W//k4z/RKIoYAa0EQ9savxvkKl8GQbJrcrflm02h5N5Yk
 ZQ8JpBTTS/CHuFLpBV6hA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wbdz4rfoDNo=:O02Xc1mHEfHOYVvObo7Zld
 3bE0/TZBOgKqRhdD8PL8iaSlk8+ePaqPhB/JlF8cDAI0X+nBa1Mw7/O/jjmiyM7tu/PYTeL4R
 gcXp1NKQwiY41AgD9kam1rufSG+PeiIS+qAv0r10CLGLoATAwUV8Elt7bwlrYae92SLuEjKMB
 tA2Hc7zl6NhGQdQ1XewQQ5ZTaP1mT0nGfvta2UW0jchHAE41EwV2y2/UT6dic8H78AttYxBrU
 Dj/ggEO0UtDN2cr2h25GLXtPs4vx5/x9CGAIYJDP7Y7yRJsm2xaf3G/aBUN+GNouacbsVuxRl
 lsQ5cedUTM4cL864NCBY4JQqRi8ajp5ecPSpOQOpjnzNcDrB3e0CuhxafxENY0fIPTDzXHtZH
 /FWTDDqs2PrPRF3EHn1KSXYLbDwKn1apie2T+UueqQOVpmP4QZScaKC03lxaMnc27Ri0E3qXd
 ALmkXgK+AV5p2mbc6oVhryfbCjZMvqnNYPnXCKZwIWtNP1ZZ2d3xgXVE7NKTCrHXdY0dGocxw
 4/Gsp2Bt5BjeqQBXuxbdKylxRNN9sca/ppWLFQm4rwH+uyuL3OfXslNme36US7Wp0drVmz5cY
 T0DzWbzGPWeC390iPRQh33TE96Oy6Sxr3NNCqf+krfqDoO66xotmUOZtVSM4jN9atGAaeJFPb
 DxCy8zfbj6d8DhN42StZqkZLPv0iX95RNfdBTB+x0+QrydxbefY3T1CPDwF6zvZCA8Q4ADGEx
 Azl1YuVgA9TbZJRz2qHHh0LTeBAE4S30c3wWrexXe0XCUEjyF8f8Yd2Fpa3uz/6GDU+CAW8ac
 fnUYAvV/+QiK93xioGkn2qmOJtuckUxmwaB3YswerhOnk+5E6Qj3nwsMGfzsFtasDJUZNTjFL
 GqkpwI/5GDUWdPBBv/1kzSOJYOSLJP8QpgvdE0NaLGtsUI8qqoLq0bg5nkfClulXrST6mqDjA
 3KilgwuFBucnhbbUs4fcCbwCgHHOJJvX+XM0wQRuzE6N/b6ZaWN36p+GxWMIYkvHnpv3/3/jO
 QzcGSjfpsVzJ6A2qG+NfzugUcPce0oXxnUgsyu9mvADHJlQ0mGhGrn7t9z4ZL/59j4y5Us1yK
 cwg0C8tmIUXxVQ+yBzza1M0YZ+g1DpwmOmDu14CCiUhzY3Q5YkonbIxngEeBjZ3luLczmwKQ/
 EipZrLUes/LkbeCEg4y9mxT7proRpi8pZlBjGL2zUfQSQYBdgtlVhYMO/lzt7ATmrZpor1OVs
 5b8HsYV2QuIIaJQS6KK8NlmL6kvTUUrkM5T2ONchgyDfOHDPYKfSmqrBHgpg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2019 at 05:14:28PM -0700, Jonathan Corbet wrote:
[...]
> All of the afflicted files arrived in that state as the result of a pair
> of patches from Jonathan (copied); I have verified that the original
> patches also had the DOS line endings.

Not sure why, or where in the mails' path this happened, but the base64
with CR/LF inside is also present in the copies that went directly to
me, rather than via the mailing lists.

> Anyway, if I revert the two offending patches and resend the pull, is that
> good enough, or do you want this mess out of the history entirely?

On a somewhat related note: "Documentation: networking: device drivers:
Remove stray asterisks" was also picked up via the networking tree.
Perhaps I should have mentioned that when I became aware(?)

> Sorry for the trouble,

Well, same here :/


Jonathan Neusch=C3=A4fer

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl3kWIkACgkQCDBEmo7z
X9sZlBAArNmrtwOupByvamJkONeJ8iiJAy1xT4EtPY0j22FfM5sJ9lDJVuo+y/+Q
zt+KzQi6vH020+oX3NmTBLLL2pLqkTURb+Nha2zqoyA15GOz/iM+a3Hz5j9agUQc
zIiI4MTSsYsHbiZMyMDpDNuNqul3wNWHpHmm3VRc6jEOmsG43vqJ9t1LICk2g0X0
Kn5nJ/q0UqSTO2Rvawol746XVb/Rw72zxu9SG2Vex9cWDjwaTK2qAGYPSUWmtbCd
SSkX1515wPVc5oTpQ9/7XvsdNWwhhsk+mUPihI4QIf/lwPq5sEVhZbMSFjg7+4RK
NAMcMbkbnmYzAdPaU2Mwz94BQ1sGWSIcKWcYfOZG7DWi0LBtyd2GiY/BzTjk49/q
GhpovKBT1Qr3XVIv1yD/u8vGPIkRgwcOkVn9vFjj8XGXMh72zTC2DlbKnz2PrwYA
PsDQnY/qvcntWyfeIlL09v7RpkTWjs+Gp2SoxH4OOfRRRRG/H1AC1xakTDAXO06R
yg4CeOGmQesBa3ttYUuhMMmU4zrjYWK40m1FyZ+xtP3XCck0jPL1cMcaiGeHNw+n
vC0wMs9IyydsnSZPq/hYxeq/I9I8OOeufaDhjGctU25y5OQdYYapXgMRvZDoqAnm
jHzWv+2MW5nDhLhCkC4tTtwLDL1GQdH8uWiZdVd3jItla8BcDIM=
=MTIV
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
