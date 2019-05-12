Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591F6C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 23:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E74208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 23:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cr4qdUKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfELX2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 19:28:22 -0400
Received: from ozlabs.org ([203.11.71.1]:35877 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfELX2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 19:28:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 452KrG1Hc0z9s6w;
        Mon, 13 May 2019 09:28:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557703698;
        bh=ATL4kHU382WX2z7ErWNR+vsPla44tUhrsoFXnbXw2Y0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cr4qdUKrwnwRXUpL3BoLaRJnZZ5FdthHRGxDrERn6sxYAdpbik9HKok9T97dRU+gc
         1VKWXDLvsjROpY4ltlIBLN467BG0yaqhy8yH/kV+5YuuHj9m1XF6lDu5G3wrXhMxtP
         TTqWEv5BizCJbP/8ncjynWtKJ48XvXxqEyIq/C3SmtsZrLOBG5xntJm9vLXjpbgr0d
         A6Z/2QexU79acLgesUQ5ikzgllSy7EiRItm5/78u1m17lLW1IUCJ0BKt6T2u1AtYVO
         skxi4ZUHN22lbtt2W2PLDqEGEM2rWoIc5PrQhXPST5e7CUnQBvJGtQPxC/oGBvT4RU
         WAN4r0Y4i1NCg==
Date:   Mon, 13 May 2019 09:28:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jeff LaBundy <jeff@labundy.com>
Subject: Re: linux-next: manual merge of the input tree with the arm-soc
 tree
Message-ID: <20190513092756.0eb03c72@canb.auug.org.au>
In-Reply-To: <20190501134054.4271616e@canb.auug.org.au>
References: <20190501134054.4271616e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1Ut8vlM/tSGq=IsIjYTN6gG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1Ut8vlM/tSGq=IsIjYTN6gG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 1 May 2019 13:40:54 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the input tree got a conflict in:
>=20
>   Documentation/devicetree/bindings/vendor-prefixes.txt
>=20
> between commit:
>=20
>   2c98d9e47533 ("dt-bindings: vendor-prefixes: add AZW")
>=20
> from the arm-soc tree and commit:
>=20
>   7b5bb55d0dad ("Input: add support for Azoteq IQS550/572/525")
>=20
> from the input tree.
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
> index 5f2b185a04e6,51f99549161e..000000000000
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@@ -54,7 -53,7 +54,8 @@@ avic	Shanghai AVIC Optoelectronics Co.
>   avnet	Avnet, Inc.
>   axentia	Axentia Technologies AB
>   axis	Axis Communications AB
> + azoteq	Azoteq (Pty) Ltd
>  +azw     Shenzhen AZW Technology Co., Ltd.
>   bananapi BIPAI KEJI LIMITED
>   bhf	Beckhoff Automation GmbH & Co. KG
>   bitmain	Bitmain Technologies

Thie is now a conflict between the arm-soc tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/1Ut8vlM/tSGq=IsIjYTN6gG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzYrAYACgkQAVBC80lX
0GxLUgf/TPvpX9Qyf51e5o+3yuVhTPB/uirCiqJYU1bRIO1fKDPYvNJR9p0jvYQk
UKK0tj7AbhRaAsHumme0mXwU5fc5QYX0/XpQrtL/CVHxk7ua1FmtFIwDcI3bFY48
Tub91jqGMQSJtg8KdPHC5vs/B/6xf/YmLO6PBItiaQtiktN2ZAI3B4erVt4lij55
+/Yx3J5Qg735hUCpAM1FaK3swlHGCIOgl9c20xHlu75u59osFIpEAqeaD1tCHrqi
9sPGAFX8y/VtDfbPtVt1PS6TXLAttDWimk+MbntOJ7EctgbVcVZ1Ayf4A6nIZ7ou
RzsPGMCTB930djEoKWqmEKMVRs4J1g==
=JkKI
-----END PGP SIGNATURE-----

--Sig_/1Ut8vlM/tSGq=IsIjYTN6gG--
