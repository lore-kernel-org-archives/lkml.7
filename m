Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABEDC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C82F2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gP9kErX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbfK0V14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:27:56 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:54787 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731378AbfK0U7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:59:06 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47NY6F4Q1Xz9sSf;
        Thu, 28 Nov 2019 07:59:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1574888342;
        bh=nDXhCxVCeocAgjs+KzcbhyqbajM0hYI/r/7dm0R0rxI=;
        h=Date:From:To:Cc:Subject:From;
        b=gP9kErX86mf7ar6BFDxp4FUj72lXh7tMD2rc242/1j9lPfXf5oBU1uJndnva5dDC6
         wkP7UQhHYTaNLRWMLBMfgjvNdvwiiQ4gytTH2MRduRxO0ufrYN9h6T5mfCXl04hyAc
         OBWH8wLJiTqwIsSWMhthMT+UgZ2b9RC3UjntfzxaShhpyH0LDmKzi+u/inQ972hcuH
         2BWsOV9yKcEamm2QvmKWHTqzelcSFBExvoQ12Pg4U7u5fLvopBGKhDSLu9qICEtegP
         q4dzdQXagz2SBiaAIFV28Pbt1DKTgP79WwU/u3BBsnGS3+NYneTyKfOcZ06PXBkggA
         /f9dARoCJwhgg==
Date:   Thu, 28 Nov 2019 07:59:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the origin tree
Message-ID: <20191128075903.78c39170@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qz8BamVi=IPBCHlwgP8EYVy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qz8BamVi=IPBCHlwgP8EYVy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the origin tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

WARNING: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pinctrl-equil=
ibrium.o
see include/linux/module.h for more information

Introduced by commit

  1948d5c51dba ("pinctrl: Add pinmux & GPIO controller driver for a new SoC=
")

This commit was not in linux-next before being merged by Linus :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/qz8BamVi=IPBCHlwgP8EYVy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3e45cACgkQAVBC80lX
0Gwv+wf/TSiJpfgmb+vB0/yn71eqSADoB/DU3ri0mn4N/ABgDvg41iRLOHJFs2+d
yIyI1dnvC4wcTS/Ac6FxlD3Gw5HG3rlOx4flt8KTv/ilby6CwB6vIJ7n7kZzYY99
xqNwEyWyy4mgneVJ6ZEi6yctgf3t8xkinPnfB6udPq19m63vJMUAoStf+gY+vR+u
0MN9O1lujknAxMRHgIOD07vtHPdbVH0Wi9FU4xwRvIF//yKtFwoD/5f1KALrUuTJ
Z9FCDbYWo0+2TReVSn8oDyoJzL5tDp2UHuj7FtmprBqcYtFct8dupEph3FsWQB+O
WQttj21xs9HwB5Q8n98EAh1om7ESEA==
=Tacb
-----END PGP SIGNATURE-----

--Sig_/qz8BamVi=IPBCHlwgP8EYVy--
