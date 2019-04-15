Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4E7C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9140A2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aj1RYQfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfDOOOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:14:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:45559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfDOON7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555337626;
        bh=0xpCbVixF1sSisaDHnBrPf3wJ16s51J6Bw33EyYYq/g=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=aj1RYQfRTEJLiyXIQYOh1HoxXtn4Ohi4tuw+Rh0LunPpAoXbSrsZM9LAAlBGbVvyb
         IMrIOum9Eg1FzVQPgW6Aa51FrLmmJ9TiygTa6ZcHKZajNcqSlJJxSKsLtOhqBrCsIt
         ebtxMeXA+RWVFq5xK1jkgTqi5oqXZXVgusD8Se/k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3zT0-1gyvBg11iU-00rUTb; Mon, 15
 Apr 2019 16:13:46 +0200
Date:   Mon, 15 Apr 2019 16:13:44 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Harry Wei <harryxiyou@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs/zh_CN: fix typos in 1.Intro.rst file
Message-ID: <20190415141344.GB11536@latitude>
References: <20190415094046.242940-1-alex.shi@linux.alibaba.com>
 <20190415094046.242940-2-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <20190415094046.242940-2-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:8gmeNlfBCoUCGR6YBIljTTT+YiV9ZvnBZm2Hbox/7AXiA2Mql65
 JjGbSZ1EhNezjCNsknjQzp0X0qDgwy+LYoD2mLXiWOqdg6qfv5EfeVVmYzIXws4FUEv82zm
 T0wUEUS9cqujMUQpNCcpXXsuDJNftoFprLfujLyIpn6nlNfVIZHnnefn6wi1/7LPBcdw7hK
 HDLLdbPeQ1wbsI6wZVXiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TVv+vqHmHv8=:OUkGjQhg7D4ZhFb9u1uS4C
 PQ/sWl5Xm0mdS3D4LN/30JyRMOkGvUld9Hw3fgoua7aTOCfofOF1YxdZ6ETAoXBx722THSzxK
 fQ9ms6zOn5GGCKUYdF57M/ZN+WkdYraevAEvwOiDot/+retUTuoYuOs0eogsPXH/Ia2rwN833
 AjajgaQnAJQpBBMxlWGVhkbCd+SslArf+Q9jTLv16EQh9ho5oY60gmxfghOI+n2HpzjNucIP+
 nLF/ZG8BWLeMyc/aS+BMtY356Aqb+giys9rfdC/7n6F94FuFXeVGibCaEPESTymB/zqlYSTNH
 05Qo3c0h4An9MHO90DGIF+4C77qcVFewhNUoI7CPVXxtgQx/W+Pks5dPvV0Snmi8VuCp+RxQs
 NTaMDjWr4kEirptwIgS3K4+NdwDeFGn40tePn3WLdbqP44KAChDz3xxBJFp52K+YSPz1Llibr
 YhNsuuM0MDdN7J+3HQxtnEcJAwj+9UAAiALxjBA1TVLHJPX+izaD5gF6QOSo8IuRIy9QpPpQj
 3SZOklItyMk/tPYzxeNfdpkthKrU+RfaxA+C+e/QTmPF9FWXQ+46j8A6gWpbp2kS8AB4vRCuL
 uB9lU1ZSo6V8e0F3P0Ra9Iq2QPms1R4gK2En/eEi9sNoFVaHSIxde9f3pjAdAoVlZMq1yWUBi
 f8qnYtzgB/iGegRBZ2q3eek4A17bGlJmFO+wn8AshU52nQFDHSzkf3MmBERb18wzfz53rFnhd
 wTw1KOErDrCUIGqcBzinPemlx9a6/bL1ul4weVaxvTftvQthtFkdF15QVuDIypaZx32ZhW64C
 dAYlOD6q17b6+mz7MLpS1gPYtFmccegAtETK1ojDuynpk/iQkeCHeR2W2PSie9M7DKeQy87Kl
 4V2/dBQGtB9Y2vdHizSIN/5Ot2ZmoQZADreDtnFEm9pxeWm8DwzvwdrcSgAV6y
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 05:40:46PM +0800, Alex Shi wrote:
> Fixed a uncapital issue and a typo.
>=20
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Harry Wei <harryxiyou@gmail.com>=20
> Cc: Jonathan Corbet <corbet@lwn.net>=20
> Cc: linux-doc@vger.kernel.org=20
> Cc: linux-kernel@vger.kernel.org=20
> ---
>  Documentation/translations/zh_CN/process/1.Intro.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/translations/zh_CN/process/1.Intro.rst b/Docum=
entation/translations/zh_CN/process/1.Intro.rst
> index 03bbafc00bd2..2bff9e49822c 100644
> --- a/Documentation/translations/zh_CN/process/1.Intro.rst
> +++ b/Documentation/translations/zh_CN/process/1.Intro.rst
> @@ -79,12 +79,12 @@ Linux=E6=9C=80=E5=BC=95=E4=BA=BA=E6=B3=A8=E7=9B=AE=E7=
=9A=84=E7=89=B9=E6=80=A7=E4=B9=8B=E4=B8=80=E6=98=AF=E8=BF=99=E4=BA=9B=E5=BC=
=80=E5=8F=91=E4=BA=BA=E5=91=98=E5=8F=AF=E4=BB=A5=E8=AE=BF=E9=97=AE=E5=AE=83=
=EF=BC=9B=E4=BB=BB=E4=BD=95
>  =E8=87=B4=E8=B0=A2
>  ----
> =20
> -=E6=9C=AC=E6=96=87=E4=BB=B6=E7=94=B1jonathan corbet=E6=92=B0=E5=86=99=EF=
=BC=8Ccorbet@lwn.net=E3=80=82=E4=BB=A5=E4=B8=8B=E4=BA=BA=E5=91=98=E7=9A=84=
=E5=BB=BA=E8=AE=AE=E4=BD=BF=E4=B9=8B=E6=9B=B4=E4=B8=BA=E5=AE=8C=E5=96=84=EF=
=BC=9A
> +=E6=9C=AC=E6=96=87=E4=BB=B6=E7=94=B1Jonathan corbet=E6=92=B0=E5=86=99=EF=
=BC=8Ccorbet@lwn.net=E3=80=82=E4=BB=A5=E4=B8=8B=E4=BA=BA=E5=91=98=E7=9A=84=
=E5=BB=BA=E8=AE=AE=E4=BD=BF=E4=B9=8B=E6=9B=B4=E4=B8=BA=E5=AE=8C=E5=96=84=EF=
=BC=9A

=E2=80=A6 or perhaps "Jonathan Corbet" (with two capital letters)?

>  Johannes Berg, James Berry, Alex Chiang, Roland Dreier, Randy Dunlap,
>  Jake Edge, Jiri Kosina, Matt Mackall, Arthur Marsh, Amanda McPherson,
>  Andrew Morton, Andrew Price, Tsugikazu Shibata, =E5=92=8C Jochen Vo=C3=
=9F.


Jonathan Neusch=C3=A4fer

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAly0kZAACgkQCDBEmo7z
X9uprA/9GLTNzeZc2l5hhoqBS0LpYj7ZM5L2FPPDZNad4LcF/Kry/ofj0x8snpyk
ZOwhr/kKLnK1DV7u1Xng89wdAa7ZkB5nHFmZDQ0WcB0ayNwGA8MRdNeF1iiVAQMq
nHJaYxLB477b7citNFc7xwdI6kSIV/lIRv9om6sniDPnBXMZiBzdDh7IFDXEIRe9
YlZTI2wr36aMYxCSMs4t7qsy/Z2Q6/4KB+uDiM4rEKGQxge2BOQhtE7nlesdpaoV
i6AVLV5ryLpT3QDGuZp0WYW3R3CV9iyH02C3qFZtw5k81t60Mge69TKMuAVtOI7E
Q1VYwlR1GBHquKWsXBNGBDd15cn+eBj8hjMddcap2L8gkfgrnXUxGcYgdyj9Yf60
v/qPCrEg/xLk6rIJJtXMqV3nitrhGyiW8grCRJtrjtdwIKZLqTtJdIPUTxDt0Y2e
dprPG8g8Ffjb3lB3NBga370qTZZgDOtewV+Rr9q+9n0dBN5+hVT514y47yO5r3qe
ab1UCj6gQZPHUqBLGzDvHJhyCx8k0qYeh5OOKlSSrqbruRwdWJv1fqueaEt/pCba
inm4bzX82pJK/aQKGPt8CbAjl30tEFTyw8KFX+Jm9jio+4gSWcp5F/ivY9S/LvxL
dSXrHvHt8z+vWcWJ2YSEYS8LpCELsjJE90eImesjsSP466fPk1I=
=NiXt
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
