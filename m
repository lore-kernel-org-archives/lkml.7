Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757DCC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAC8206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tOYL0IMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfCFGmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:42:12 -0500
Received: from ozlabs.org ([203.11.71.1]:54467 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfCFGmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:42:12 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44DkhL0zn5z9s7h;
        Wed,  6 Mar 2019 17:42:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551854530;
        bh=zFm2NDCL61DewbMRmOQrGVTHe3tii8hyhWoJP43j6hQ=;
        h=Date:From:To:Cc:Subject:From;
        b=tOYL0IMjhAnofuvCCwU00dVrveCUiz6L6pe9jYy8XOBZhcuaizMRjXvLjP1mHj/7m
         HuCMMmJaH0DMWNFnIow7x6gCMqe9tWSwVUGDm0uSitdC74x8OPrnut1SFZyqlpXeqy
         XFNuNMVhcYMpgdcUXtSPnWOus9tgubc9MH5hiGrUapYmMVv6RZ7qdOEFpj60h8egZJ
         MdZd036X01DoM3z3N/vyPGM6zvSgXhM8qjepjiNEYUFdxj4AgJE81WSxL6C0EaNFjK
         3kreNxtCzmCG3EfyxXULrHt063WlTgthY+N7daiLuYkMMNnGXPxQQ5uhzqc9VnFATn
         S+GqxrhdY5bpQ==
Date:   Wed, 6 Mar 2019 17:42:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the nds32 tree
Message-ID: <20190306174209.6a425193@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RQ0YcJawkrx=DsW4HLecSxp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RQ0YcJawkrx=DsW4HLecSxp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greentime,

Commit

  90ef626b651d ("nds32: fix semicolon code style issue")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/RQ0YcJawkrx=DsW4HLecSxp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx/a8EACgkQAVBC80lX
0GwLCAgAluj+sxBScUpE2GgeE4YDdhc4peO4d2sAZj3nUYEaQsK+paBrzecWUggG
RK2kff0VukI/p94lndvKZx1Vv6kd1n9WdgVAATen3iCOAyNHIc1qjA2jz2+dW72o
1b6YAOmy9syPKKgpYrdNP3k4FdSBk9loIfEBbtiHVfVvyaMiEjpQi/RfFcP2nCOx
vSCHUzERcccsP7xiVGq9+HJvSQJAP13oeJgA199tZTn+UTuVEd+fQR5+XC/ew7p9
zbC32Gfx3FvuAsiu3bk/TQDfeJV0jCVRf4DPAAx00VGe9qWzCB/12jyTEoUBnE7Q
LJYFmlQ2WGJo7NxobOhmz7Lj2CEAdA==
=Hmmc
-----END PGP SIGNATURE-----

--Sig_/RQ0YcJawkrx=DsW4HLecSxp--
