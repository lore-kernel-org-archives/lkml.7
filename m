Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75776C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 04:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3856F20872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 04:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BEx861Rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfCSEYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 00:24:14 -0400
Received: from ozlabs.org ([203.11.71.1]:45203 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfCSEYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 00:24:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Ng170mDjz9s5c;
        Tue, 19 Mar 2019 15:24:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552969451;
        bh=poF5ciph9KDsJlgevVC2oSFWCGaWo9zj/rBg/KWvbpg=;
        h=Date:From:To:Cc:Subject:From;
        b=BEx861RbVQ+NEwLMljJrsnaJTi/flhE8Q7eyLOwAOy7OJfVSlqriBBj0WdelFemPt
         x03PaoT5zHiInzPgD/tdTVmeCouB41pA4sOSLS70Coq0fKM8QrnFdTOLiMoTpZpohZ
         P7W+uTeB5uIAaY86pb4SW0VDVaemcYe6pvM8ErXhWsbzqQFr25U4CZ+rSEnv4Sz2ww
         Ve4OZW3Fv4UVPL22iW/y1Pdrg2LuIW/eLJN/gOmhX3q6Ov8IyvdMlRSdWVSeknOey3
         e5QEG2wmXeLv0YHQdoHjO1o91Op4fEtk0LOJs/74FPR7/d1viOSf8Reu7e16B+UmEV
         V4I4PZCn0vAkA==
Date:   Tue, 19 Mar 2019 15:24:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>
Subject: linux-next: manual merge of the akpm-current tree with the amdgpu
 tree
Message-ID: <20190319152403.41570130@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/j+tJL_kw4Tm17VEcFezTcpn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j+tJL_kw4Tm17VEcFezTcpn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/hmm.c

between commit:

  e811b0a79998 ("mm/hmm: use reference counting for HMM struct")

from the amdgpu tree and commit:

  e0ed7d6bb0c5 ("mm/hmm: use reference counting for HMM struct")

and following commits from the akpm-current tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/j+tJL_kw4Tm17VEcFezTcpn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyQbuMACgkQAVBC80lX
0Gyb7Qf/TQxNnjwXMss+AiF6aYhuzG5NrAZ61t/8/IXFdIFIJGBnhSGBBvc0WlzJ
KFc4XPYkw5aO/9b0BD1uRmv3dQhm63VZfMzROUmMO13moylM+YqafQXR5u0SOQLT
74XElhfHBsrsGpv5kkOjF2NuwIChZaijGOUzNQsjmbZ+2ZF+Il4XqEh16pIdGED8
OzFsDDG8E4owTj8bYn6OQYhtaG6uB3Z4xJ2Bfc/DkZ0wSyBVfLhR1XjsCHNA6mK6
NecCGHcyBVhjQsEA3lAgagvbqlMRHOP4lVMigGTXIiClvwtglfibc7D3WdG41cAr
yfYqt4W/Aqyo4TQJPD0VMxrBOXmf9A==
=Yx/A
-----END PGP SIGNATURE-----

--Sig_/j+tJL_kw4Tm17VEcFezTcpn--
