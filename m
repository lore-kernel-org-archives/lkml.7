Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDF7C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802E620B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eokXJejx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfHAFFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 01:05:42 -0400
Received: from ozlabs.org ([203.11.71.1]:50707 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfHAFFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 01:05:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45zdXf6CGlz9sNF;
        Thu,  1 Aug 2019 15:05:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564635939;
        bh=uQHGuNLYTYrU7NFRobmHMq4rOJK5Uy4OtDhr0xWjywg=;
        h=Date:From:To:Cc:Subject:From;
        b=eokXJejxVJn+bmnstDrtNrk2CROd2epieBpQ+lPYrgddYyAkqd6HRZP7USS17Aowx
         eISdfjSoj9na7COOahOllnYHj8XH4BWFsYjmUc3g62dfRCsyAtsil1saoHVxs/jxEQ
         xJajlo51uyFsus6F1ZLSf89VNzleyH/EJwyjr4YzK078AKI03CniUfl0hz3w83kSXf
         UGLJFTgeQzAKHUggIOyovJ1+sLKKgPpQq9n4BO6oLT+hVkwi0mLJlJMX1bCszOhk9w
         osE5fILgtfJh3R+4bUEypXzQBrgqkGpfhp98pXiSDqSEeV49jNLCovW3tpo2GYWnn+
         MaP/2jcQUn4Sg==
Date:   Thu, 1 Aug 2019 15:05:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: linux-next: build warning after merge of the driver-core tree
Message-ID: <20190801150537.5878bbac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IcLhnQnv+oXa.axOEFZwF0=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IcLhnQnv+oXa.axOEFZwF0=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/i2c/i2c-core-acpi.c:347:12: warning: 'i2c_acpi_find_match_adapter' =
defined but not used [-Wunused-function]
 static int i2c_acpi_find_match_adapter(struct device *dev, const void *dat=
a)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  00500147cbd3 ("drivers: Introduce device lookup variants by ACPI_COMPANIO=
N device")

--=20
Cheers,
Stephen Rothwell

--Sig_/IcLhnQnv+oXa.axOEFZwF0=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1CcyEACgkQAVBC80lX
0Gwurwf/fSQtxIHIKg7KiTjwH1R8fQW0HLT/LrmDCigwqOnk/7OCVgxD/IHPGhUE
03ap8LvFIe5eQOivhXxk+BvOzv0RYVDccM8UCdK52AwXtIqC2DEP0SaiJw/AT76r
qeZMtCSh3k28GiNrSlxysUns3DSeGTDH1jImrPEMzR2jvwc0fyT+nT/JFoz6hFJ0
JA+ZWOc8f7FV+DwKP3RT0Ul9IcIkGI50Zn3nF8fcRd3t0BOV48W4kszS0piJVa+y
qdJuf45ZhgUfnASEya8mTXAhxRt21TRP6d0VHwvX1nceOclzQCchHdaJGdbZts8w
XVbpb8yOne4m8uyV4a59AaCvJGLG5Q==
=jXMP
-----END PGP SIGNATURE-----

--Sig_/IcLhnQnv+oXa.axOEFZwF0=--
