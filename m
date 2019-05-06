Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76DEC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D060206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Dfv/PHCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfEFUkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 16:40:13 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38351 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfEFUkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 16:40:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44yZP64SFtz9s6w;
        Tue,  7 May 2019 06:40:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557175210;
        bh=UnBnDMtqaTMzpD60wTpxZ1W7LbEeYkgM1+66drzolYU=;
        h=Date:From:To:Cc:Subject:From;
        b=Dfv/PHCi7qC3G4m8hMZ9bmif4Ny2v/E01V2uHmyZkxNhns0wy6r3Q2DNKwCYVNN1M
         L5AVEP+Losj/J2G1adWriNKIPFi5X4C3lrSTOI9/7eCuWyUCs70JBrSKRjhm7k2wks
         FKIiFIUSjCBl1YuoboZvpgTUZBBhfubQntgBtELHFz9p9tAy3NtrCufFTtILIRhRVt
         We9mHhANk5MQ3JGsZy4uUSwYlzaRcJVf8HPEEgt7A8S1z8rw/6gB3c8yGotfWSirXF
         9z6A4GZlrcgI2bNpueVYpZ62OoRvPePER4NOmhi6HNPbjikJ4Rv69EFThLoAu0le/n
         TZcdw0kz03rVw==
Date:   Tue, 7 May 2019 06:40:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: linux-next: Fixes tags need some work in the mtd tree
Message-ID: <20190507064008.1ecba58b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EkRbAt_MV4yq25aod_a9qSo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EkRbAt_MV4yq25aod_a9qSo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  d41970097f10 ("mtd: maps: Allow MTD_PHYSMAP with MTD_RAM")

Fixes tag

  Fixes: commit 642b1e8dbed7 ("mtd: maps: Merge physmap_of.c into physmap-c=
ore.c")

has these problem(s):

  - leading word 'commit' unexpected

In commit

  64d14c6fe040 ("mtd: maps: physmap: Store gpio_values correctly")

Fixes tag

  Fixes: commit ba32ce95cbd9 ("mtd: maps: Merge gpio-addr-flash.c into phys=
map-core.c")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/EkRbAt_MV4yq25aod_a9qSo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzQm6gACgkQAVBC80lX
0GyXhAgAjY0Dgi71yc8VrVFDZS+yiHBMuzyv3q/eJFXapTNgzlrjVdrA31kNYFwV
XSHEcf/YLXNTlYXY9DUbTRrBSuO0c76E86Pq3h5T7yzfV5aVWrVoseLKTv85Rfhx
PzqYcQZdNMpausx2RxiRvrvgZjbOHgTuiiKeuIERa72IXG2HAC2scaXKnz9suCss
EWFtGMj4uEmG2yi34aeAFMcljR7ROlo4BeniAU/DEeDfLOzPRgkxkTgebwBWK3rv
FUHpaTAM78Ue+BrbUTtN14npWIcPKwwtEPwtOGUiTnYWNXMyNC15O8IZViK4y4bQ
U2qjRC46JkPpZND4OubDOeKNOT7Gkw==
=cSHZ
-----END PGP SIGNATURE-----

--Sig_/EkRbAt_MV4yq25aod_a9qSo--
