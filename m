Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CE9C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 03:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4613D2053B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 03:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rcQmVEai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfEHDrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 23:47:32 -0400
Received: from ozlabs.org ([203.11.71.1]:34711 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfEHDrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 23:47:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zMqh2nGWz9s4V;
        Wed,  8 May 2019 13:47:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557287248;
        bh=R1RqJ1ImOmpys8/DGBYwmYPTH8oCYtZjVOwBbuB7jEg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rcQmVEaiSda2Xu6lLzFzzHBWm6Ly4ljbqFB9dSb34KN7oZCP4G4cInaXdIkaecogB
         Ec35BSUvBnsBEnx59nCKjtaz4bVOYFxfbKQ4ZDXOGKqlX/RgiV58nfqTqphvckmyir
         MfYuZtVsAwJMYJpAPy8DAUZia/Xxyjx5HARPiD0cVejOWBKPRit7V5UFDDssu5JpzH
         pt+dr9vfpOMrqaRs8CT/17yqmoBYJVp6KDuElRuMrjokxP9SjtgXEkCEenrA1mq76W
         w+s55lXw+BxS205Uv2mgZyjlKxFehkQ0O40iAtmwBxw55WGFadFnlVta2Wqhjat1ra
         lcmuau1aiFlHQ==
Date:   Wed, 8 May 2019 13:47:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Greg KH <greg@kroah.com>, Shawn Guo <shawn.guo@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Yang <decatf@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan =?UTF-8?B?TmV1c2Now6Rm?= =?UTF-8?B?ZXI=?= 
        <j.neuschaefer@gmx.net>
Subject: Re: linux-next: manual merge of the staging tree with the imx-mxs
 tree
Message-ID: <20190508134727.7ca1e390@canb.auug.org.au>
In-Reply-To: <20190412144921.3a152478@canb.auug.org.au>
References: <20190412144921.3a152478@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1V1pV/zWcmIrgm4TFnFSdey"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1V1pV/zWcmIrgm4TFnFSdey
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 12 Apr 2019 14:49:21 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the staging tree got a conflict in:
>=20
>   Documentation/devicetree/bindings/vendor-prefixes.txt
>=20
> between commit:
>=20
>   189733b0a7e4 ("dt-bindings: Add vendor prefix for Rakuten Kobo, Inc.")
>=20
> from the imx-mxs tree and commit:
>=20
>   2e5cee6c7622 ("dt-bindings: Add vendor prefix for Kionix, Inc.")
>=20
> from the staging tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc Documentation/devicetree/bindings/vendor-prefixes.txt
> index 5f2b185a04e6,93753f447c20..000000000000
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@@ -211,7 -210,7 +211,8 @@@ kiebackpeter    Kieback & Peter Gmb
>   kinetic Kinetic Technologies
>   kingdisplay	King & Display Technology Co., Ltd.
>   kingnovel	Kingnovel Technology Co., Ltd.
> + kionix	Kionix, Inc.
>  +kobo	Rakuten Kobo Inc.
>   koe	Kaohsiung Opto-Electronics Inc.
>   kosagi	Sutajio Ko-Usagi PTE Ltd.
>   kyo	Kyocera Corporation

This is now a conflict between the arm-soc tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/1V1pV/zWcmIrgm4TFnFSdey
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzSUU8ACgkQAVBC80lX
0GwTPAf/cEVh8RWOnK9RS7qYoOibc+Ud8w21cx8GoOiArXG95S1BgP+HUekZMS/m
gy13w1VEqM1L391i+d/lrBuEQR/D5dQCXkIF6DzjBqmSUZ2X4D6y9IIFjXde5+21
Fq8F0bShBq8XI4zKbaUGT5BpbEEq/7Z+PU63tPL5jTuIdoA4666mMRUFPhcCoHj4
ajRQORxZsEdLv6MsTGQ6LLnTcfzbPMKT/B2M/aPFp8NolcHIvSt2lk+HjOeD5MJo
ltA1BMt6Tgwguq44o9IZIMGrfMwVYZNm3fY55zc8+jINsj+Ysb7gsLGAjwbEvQHB
PSrvQNm/09DAs+ziVUOhB3/uGroe9A==
=cTIR
-----END PGP SIGNATURE-----

--Sig_/1V1pV/zWcmIrgm4TFnFSdey--
