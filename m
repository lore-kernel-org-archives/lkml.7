Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DCDC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEEE20873
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UV/USXyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfJHXq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 19:46:56 -0400
Received: from ozlabs.org ([203.11.71.1]:42561 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbfJHXqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:46:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46nvC1154Lz9sPL;
        Wed,  9 Oct 2019 10:46:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1570578413;
        bh=6OrTjE3t9ygAfHzNoX0ip1W8c0QKgjQEfaZQpY3XfHg=;
        h=Date:From:To:Cc:Subject:From;
        b=UV/USXyqBfII3sO5V6mZGit78XP6DoEGKIrXJFrLEhIzA9W5bvQ9j19pqb1eO8U2/
         phC0L6bAKSgzMsYKusvhsrD1KLGyHgvt/TQVgySHCeRyxYuonyO4V3NG0FD1QcD5ot
         xfhozrfNAe0OH++t5E/TDWNxG5MDp4FYfjcFYp3023LQuHC8i/sf8pPbKuNoCMSkXF
         7uPghycbTQx5XUAyHGTDV+IDM15298r2+hC5WQFEwV3mEin+NpfAUG2Yh7335m3vwZ
         LjhjQEoZIz7bPSCuEFR6xjNi2K+SWuovJ9MknojmXP412O9dc0a2KvWgujPLBxqYn5
         YfmBIVS80tKcg==
Date:   Wed, 9 Oct 2019 10:46:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: linux-next: manual merge of the drm-misc tree with the drm tree
Message-ID: <20191009104652.137cbacd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oOPKY4k85s01QjgBgefDM+0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oOPKY4k85s01QjgBgefDM+0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/i915/i915_gem.c

between commits:

  b290a78b5c3d ("drm/i915: Use helpers for drm_mm_node booleans")
  2850748ef876 ("drm/i915: Pull i915_vma_pin under the vm->mutex")

from the drm tree and commit:

  71724f708997 ("drm/mm: Use helpers for drm_mm_node booleans")

from the drm-misc tree.

I fixed it up (b290a78b5c3d and 71724f708997 do basically identical
things to this file ...) and can carry the fix as necessary. This is
now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your
tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/oOPKY4k85s01QjgBgefDM+0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2dH+wACgkQAVBC80lX
0GxMawf/bbQNuwdYolOK23NR4s1kLF/cdAkplFbd6oyY0iJxlBgkkrZI4nZbPgTn
Djaz929XF/QzdtQmdnsbNJ3nyoZAg6K4jKM+Y3k/ALA5sTRVyvmWajEFHPnnZML2
u22afe3A1IwBPrsHv7DI4dNxwo29zCcC8UYbPZ0u49L5JTvGozH5I9raCvhbmMpZ
zbnpjckrKdLjwOXIjH/pkMWSAfo+8NQ0evsym5EekQWnQK3B4zEQk8dqOjUm8F60
V6NqdOIsTGMo0riL/Kwznd9Uk37HWk5rAvwfLk3BM0Jpas+xJJULnzA2JXLEU76P
YY28uKFHLcGs41i7PIyROGqH6tPwyg==
=yfV4
-----END PGP SIGNATURE-----

--Sig_/oOPKY4k85s01QjgBgefDM+0--
