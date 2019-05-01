Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69351C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 03:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375C020866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 03:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PYTnRD1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfEADlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 23:41:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59107 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfEADlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 23:41:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44v41M23gFz9s55;
        Wed,  1 May 2019 13:40:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556682059;
        bh=8/XWx6sTUgF3n+CQYAwAK2rz3oF1AniFXec/UrIaKoU=;
        h=Date:From:To:Cc:Subject:From;
        b=PYTnRD1j05cpZNgnouPOZxI2LE0Q/a8toRyA0/QUVtb8v1kzwLcnXLd9UYHpEadEE
         zV2NwIt5nLO1hSF823ITo54wVvvF5rjuFgDmRCm+fh4ZKIrMcTlONCatxL9u/9/IUZ
         StEn07m90jAkYHleo5Hg9BcrY+vU0xgxDDEbENmMiozm0fiP+i0EpzQIA+TPxCuItM
         fOzmvyv7wDczI/NcakxbGOkxMBltqSgEHyzf5givh9eSzMqOgjsGsa2Wg/oyZIAKeK
         JPpTRbhtfWbk8i8kNmIaxcoC8yTHgsbqmxNzl0qof0kaSenwp8BRiNaFnL+vKpHKue
         1vm8ZLg01sZxA==
Date:   Wed, 1 May 2019 13:40:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOp?= =?UTF-8?B?cm9u?= 
        <peron.clem@gmail.com>, Maxime Ripard <maxime.ripard@bootlin.com>,
        Jeff LaBundy <jeff@labundy.com>
Subject: linux-next: manual merge of the input tree with the arm-soc tree
Message-ID: <20190501134054.4271616e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UWQNxjObisc6mUEj5M3b=YF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UWQNxjObisc6mUEj5M3b=YF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Today's linux-next merge of the input tree got a conflict in:

  Documentation/devicetree/bindings/vendor-prefixes.txt

between commit:

  2c98d9e47533 ("dt-bindings: vendor-prefixes: add AZW")

from the arm-soc tree and commit:

  7b5bb55d0dad ("Input: add support for Azoteq IQS550/572/525")

from the input tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/vendor-prefixes.txt
index 5f2b185a04e6,51f99549161e..000000000000
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@@ -54,7 -53,7 +54,8 @@@ avic	Shanghai AVIC Optoelectronics Co.
  avnet	Avnet, Inc.
  axentia	Axentia Technologies AB
  axis	Axis Communications AB
+ azoteq	Azoteq (Pty) Ltd
 +azw     Shenzhen AZW Technology Co., Ltd.
  bananapi BIPAI KEJI LIMITED
  bhf	Beckhoff Automation GmbH & Co. KG
  bitmain	Bitmain Technologies

--Sig_/UWQNxjObisc6mUEj5M3b=YF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzJFUYACgkQAVBC80lX
0GwG8gf+PSn5NwiucS2UN3Q5cHfZXRaTVQjB78Dkpj3XTPbyFqg7SVpsas3Ct9Ns
8OjTx6pYCJp1tWvhxYAwqRVqETe9NmBDB3o4Xh9yOnqim16XqjihKG9dI8zGnpGC
hRvvtAYJA4cRK8vvfjJyH+AEakSdAsxeMT2f4ga0EiRbJzqA+w1xXANhPJaCb8i/
IbfkkIJlm7BBDFASt8ffm20NZPBLCgw6W+FgwztU6YRT2GI+d1wxO+ntlAncoFtt
5c6Rd4n0RVLoZk6zXXA/20Vbb/8C0hIa/QlGX9zOHykOb2dzAEIlBJ4eR41+gmo/
M/lYHoOjepSUO1R3PU9dCCguMDsalg==
=tn9Y
-----END PGP SIGNATURE-----

--Sig_/UWQNxjObisc6mUEj5M3b=YF--
