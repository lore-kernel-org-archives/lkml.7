Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9991C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDBE206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VApL+Hhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfHPCn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:43:59 -0400
Received: from ozlabs.org ([203.11.71.1]:34823 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfHPCn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:43:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 468nhD4MTzz9sNF;
        Fri, 16 Aug 2019 12:43:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565923436;
        bh=QPfJ5wYTL4J7CFUo2tB9HqcKj050UwchqgwoB0MYhdc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VApL+HhhtSA2BbsYac5sYBgKjfG/61ZFmBBBcuqIriN+pF7jXyLieMvDADMB2fcif
         9kldu45k0h81QtAaucjUpXpGgcZPAaBan5WLviGzixUmJ4cYSWI7kjyudtO05IzzHa
         3/Wi7jSkNfLbzq+/wuD6NuMRCallp8cjIGId6vXxG9AJOUOR+8yJPzPZHGbMHRHUWw
         Ubx67+uoTbMyfkEY5HlwuB+yu9A8f4CPc0hxsjs4t7+a8YzkGTl9AU0fhm4iHI44hx
         J3/dz2+MhU8cvxeKV9dm4KWbxyLiLkMn1jAX7xpH+nUPHMrW884IWXybAUkTBuuVpf
         tDq7qZSd0yk4g==
Date:   Fri, 16 Aug 2019 12:43:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Huang, Ray" <Ray.Huang@amd.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20190816124355.18304448@canb.auug.org.au>
In-Reply-To: <CADnq5_PnhEHdpBKJEBr+kWoOtku1DMd=PYFzK1cJKFce8J7NPw@mail.gmail.com>
References: <20190813181038.2c6aafb9@canb.auug.org.au>
        <MN2PR12MB3309141545B644DCA7F144B7ECD20@MN2PR12MB3309.namprd12.prod.outlook.com>
        <CADnq5_MA-9pT=cZJYCZ62VXjwNtxaCLH2kb5ig5TLFKx4wsmjA@mail.gmail.com>
        <20190816102139.701937c8@canb.auug.org.au>
        <CADnq5_PnhEHdpBKJEBr+kWoOtku1DMd=PYFzK1cJKFce8J7NPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qIPTrIToIjB4_ZD=DIrpxJ8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qIPTrIToIjB4_ZD=DIrpxJ8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Thu, 15 Aug 2019 21:52:19 -0400 Alex Deucher <alexdeucher@gmail.com> wro=
te:
>
> Yes, sorry, just pushed out now.

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/qIPTrIToIjB4_ZD=DIrpxJ8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1WGGsACgkQAVBC80lX
0GwRdAf/eVgghliLS24/FvkGmJHoSFUfuJZ3P6+d2c3qpxtQtuNGZF0S1dTzx8YS
XeX92p7sbCa9PAxemXHOQjwpzoJzEFKmT7l54IrAvLa+FidxdmR4nBHoymtoPs4u
UPjKKMqb1rJBLHg6LN+yYO6nyPlFCNEtLoSSo6lIlMtQpSNYrHcni29jZs4CO4SR
95Hkjt5ojLgrz9XStHKR63gRg5Ixanve/mDQc1PifczfhwTkPTr0PptvHWVjZ+Q2
nPwziykN1SdJV9N9RZKMzSnHhbylbiv2Xi3DHMVX5mEP+qPSwOvFGP2T4nkUMNny
fE8rgJJV4vIBYmJFL5yJKFTuVBvWvw==
=9bNZ
-----END PGP SIGNATURE-----

--Sig_/qIPTrIToIjB4_ZD=DIrpxJ8--
