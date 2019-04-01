Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD98C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6912070D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oJ+BArgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfDASMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:12:08 -0400
Received: from ozlabs.org ([203.11.71.1]:59133 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728670AbfDASMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:12:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Y0mM4GTYz9sPp;
        Tue,  2 Apr 2019 05:12:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554142323;
        bh=6kErWGUQjEY0vpo/L8A8qwpLUQJcBARb9NJ0C8N/kCA=;
        h=Date:From:To:Cc:Subject:From;
        b=oJ+BArgY1hJGaH1xVVzadyU0TxA9H2HPw9CpUYxgGVPJZWAjIVQrcUWK6og5yjHop
         g/W7r1a5b5OcQFNPhiLZTW1KYHEgltoUphZjZ2DRpWmw95pGiTmn/h3sEGKxSSyx7i
         HVZoiRrctRTH2krHU83LMXAcmmFPpfQ8G4IPXBuH2RtSjJiu0e+iouf8qtSpa6TzGK
         hvzVja8LccwPK/rg6UFsWWDhjjYFuA/8Ptqjmxdr2KuZqQnwHlBgUIatyhxxs5nLwo
         cQ0t9nyhxi57gwsCT9MxzqfXqo/a0XH/SlxTAQSU8v9aNIPkveNVTCr3XJqMdPy478
         G3Dcz6tYat4Xg==
Date:   Tue, 2 Apr 2019 05:12:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: linux-next: Fixes tag needs some work in the spi tree
Message-ID: <20190402051203.1d7579cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZVP/=oh7A.EE_TbBm=fa9ab"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZVP/=oh7A.EE_TbBm=fa9ab
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

In commit

  fc9ba6e3e28a ("spi: tegra114: use packed mode for 32 bits per word")

Fixes tag

  Fixes: Use packed mode for 32 bits per word transfers to increase

has these problem(s):

  - No SHA1 recognised

--=20
Cheers,
Stephen Rothwell

--Sig_/ZVP/=oh7A.EE_TbBm=fa9ab
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyiVHMACgkQAVBC80lX
0GxBDQf9GOoynd/oAAwY5tyzijyrsdJ4theirRJ5eKnPom9X8G3f+CjHlvqY0rH2
LxknGV/0dK1POM1sxC2lfYrPXO5DHZH57todXOE5xTmODEyr+IURcRhKcDhoqg1O
YuuS5N/N8zRtupnARxmH0tn0/i5rlDtSAwrdQT5MV1FMWCGHl98mKVHrvMNN2B5Q
9iuVqcmW+JWbPQ80N8YDcoeMS7yXNEEZfUcsZf7XYfhWtBIoLLTdhoDj6c2j3M1D
CsJL7MS7N6fM6K+wvFG/zbeB1Z/95bt7qHsi9TYq+m7nYqU6zYjIZKx94+bqXdle
31gdptNtV4yNiNK9v1k3ngO9i8Om/Q==
=HnR1
-----END PGP SIGNATURE-----

--Sig_/ZVP/=oh7A.EE_TbBm=fa9ab--
