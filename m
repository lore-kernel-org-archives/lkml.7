Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5758AC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24903218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="X3PBU1Tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfDWVzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:55:40 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34031 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfDWVzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:55:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44pch83QMgz9sB8;
        Wed, 24 Apr 2019 07:55:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556056536;
        bh=UHlId9AYgte0/xzGUJHrcoLv+VMXojzigZ5cIwp5fTg=;
        h=Date:From:To:Cc:Subject:From;
        b=X3PBU1Trhv7dGhJi7TAB73bjcUx2z9d4eaNFqkfh5W9E9Odyx6S26mVgX7afAmU//
         oH4ic/aIOL+a9HuS8NOLcybefzmJGXuUtlgcRpo1GVCuf98KLCnsL3g93LPuDwFUya
         bRMLmGkiSPvpkuxIRYtxTOXLLno2fa6U1inPnrlGwzNwpJHu1RQzsrsNWVwxql4Yn0
         qR3p8qaPAKu8myswJ7yiOqFmvpdc4rc8uDrVhksZg2TtZtfNeaiBpBqX3079Z3t/XA
         gY6bDPYS8EMQ7vL7uDGnPl1bvPVvkTTbv/fx9/VHQi+NlJ8zuKDVlpS4t1r9xzOZzr
         wkLksFOhd6w+w==
Date:   Wed, 24 Apr 2019 07:55:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>
Subject: linux-next: Fixes tag needs some work in the i2c tree
Message-ID: <20190424075535.7cdd5a73@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7k+5vEFyz4c==QABG=3K+uE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7k+5vEFyz4c==QABG=3K+uE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  31cac068e9f3 ("i2c: imx: correct the method of getting private data in no=
tifier_call")

Fixes tag

  Fixes: 90ad2cbe88c2("i2c: imx: use clk notifier for rate changes")

has these problem(s):

  - missing space between the SHA1 and the subject

--=20
Cheers,
Stephen Rothwell

--Sig_/7k+5vEFyz4c==QABG=3K+uE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly/idcACgkQAVBC80lX
0GyAFwf/a4UAfA9ceSsFVpiu8IsqEgMntY9tGRtdlE3+MsSebIk+P4hopSnFXnI7
UwXG8I8slQC8Sgm3stXK1IxlYR5DhtFd+J/XlIEYj13EPgkGr08W+GFzbrJayXeO
gL8pkkeQODMmMzvh1GMp9NPsq0IFykVYvCdKyc/dMpp9AOao9JU1Hw4MXYrWdDfD
lHrQxGqOoGXgQmzU1In7JXOLIwqBaFmYkft8SmJI8iSgPSN3b/bLNkH4qwNGxWZp
uhtsmLNeHwItdDC9Sja3Y1rKvwn0q67BZbOMsZEIH/UeMEUUojSs335IEpqWPLK/
YGZs5XHFnnzHCmYM2FfzVsDOftqaMQ==
=zXMJ
-----END PGP SIGNATURE-----

--Sig_/7k+5vEFyz4c==QABG=3K+uE--
