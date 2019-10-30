Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAF7CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFE4205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Iz6PdOPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfJ3UXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 16:23:42 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37763 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfJ3UXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 16:23:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 473KfM5hYJz9sPT;
        Thu, 31 Oct 2019 07:23:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1572467020;
        bh=w6kDQkfrEux2/gUU+VqSk7zCj38XPqFLGM2B19pK83o=;
        h=Date:From:To:Cc:Subject:From;
        b=Iz6PdOPmGgzdhBgjbcB+ONLXp1g1q+GKmBA5NuMF7jGRn3a+uX5iqHPJojy9c20zm
         xSgrpv28iejUsUpUBBVSNeff3tSf/XqVspGMvIyvTkiUQaYEFfjLpg0mjsev83Jp0Z
         g8nqDfOvTclp8N3WhVc0R4SJYW21kRljeQvb5W3xTmEGXtGQxHbNjMoovvlgFnozpp
         k64fisdcbhZOHXdHs42TaMGBdMoi+A0TAkWfSaIQgeIG7L0LgqojOQxOGS4TUNK0g5
         uKTqIgi0gP6HzuQpP5yHQVOo9sEkKhvjNZNMENTxnHKpOb0cy8woV1zwILAtN9igR3
         aPBzo96ko8chQ==
Date:   Thu, 31 Oct 2019 07:23:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jan Kara <jack@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Mahoney <jeffm@suse.com>
Subject: linux-next: Fixes tag needs some work in the ext3 tree
Message-ID: <20191031072331.1830d07d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/inn1J9XHnUghkUxv6i=quF_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/inn1J9XHnUghkUxv6i=quF_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  08b866beeb61 ("reiserfs: fix extended attributes on the root directory")

Fixes tag

  Fixes: d0a5b995a30 ("vfs: Add IOP_XATTR inode operations flag")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/inn1J9XHnUghkUxv6i=quF_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl258UQACgkQAVBC80lX
0GyWvgf/aguf4b0HpMRcnPoR6g1Z64Q8xktOldj2qLtChR/q8dxHiENMV3857lT4
PEOog6LrolmvR5QiKzChAJPMHYJN6E9KIv2uhYnJ0ZBV3BLKhmPo2iC27hQXpWPS
jyFpuUN2DHZAGm46GdFp/O+SXc2k4Pj7aGM+z4BaVO8viqEBj2PHYjXNZqq5uINU
v+yfCOMAGlS8GQnJciCG50AolIfC0wj1El2K+QROPdGYijsyUkq4sivVt7BHQU9L
rfWJT1ojJDml3wNzZhuG9QCYH5MJB42kvYOY09okDJI1KEb1c3GqmuGHmVal2PEp
I/b3LLdYKZ2wcq2q29c3TGBTACVeBA==
=rk7G
-----END PGP SIGNATURE-----

--Sig_/inn1J9XHnUghkUxv6i=quF_--
