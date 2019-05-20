Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA06FC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D3520815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mumQleps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbfETMPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:15:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56153 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732661AbfETMPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:15:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 456yXd5b41z9sDn;
        Mon, 20 May 2019 22:15:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558354548;
        bh=ETBmQ+Y+GyGiALkiX0vj+AzC1DdCK5qfZ1pG+ZVbdpo=;
        h=Date:From:To:Cc:Subject:From;
        b=mumQlepsUvLMzAtjAm0I8cqlF/WYBi67C4W3B8zJjHcy+EvQ0OYqJMzBe6oEayh9z
         QW7ggmBIl5Tpi0T8cHMjqioPUcFB+LkKfNfUgy9ZW0cBuUBODEWWS14sgs8ZPdgVa9
         P9oJ1ldnszoOiB9jiwLroNmB0yY1ce5IgJqiXaBqCpfuXi0N3S1kcIZ10Xjlc/5cg2
         4aaaSJ4PJw81As14pe0Dwtw5Peaw8fsdqD8EwUZxO5N+XQYq22SS6asfgHkA+eHNJA
         SKzpYH+Tmnyp1+xOuZgnoNwSLtHzUec2kO+iCFXUT79WuTRnxAJMQqcWZdR6Wa//8U
         LjcgFReypfV7w==
Date:   Mon, 20 May 2019 22:15:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: linux-next: Fixes tag needs some work in the drm-intel tree
Message-ID: <20190520221526.0e103916@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/93.yJMrxB2DtnwT3NNY0Pe4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/93.yJMrxB2DtnwT3NNY0Pe4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  0d90ccb70211 ("drm/i915: Delay semaphore submission until the start of th=
e signaler")

Fixes tag

  Fixes: e88619646971 ("drm/i915: Use HW semaphores for inter-engine synchr=
oni

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please don't split Fixes tags across more than one line.



--=20
Cheers,
Stephen Rothwell

--Sig_/93.yJMrxB2DtnwT3NNY0Pe4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzimmoACgkQAVBC80lX
0GxWzwf+JJpeqte4AZNmzAlqyodr2d/yBI5DD7IxonPDxwoD/Ilm+eMpi0WIpLe7
ZES0519Y1Q9WOZXLZyjwLcRyxXMZjBdCjtFsEqBXN76kv75lycG+36jLMRETIf/I
oJ6cfDd1XPgvY08HvBvexcO9hfABtSWhOuOcN/h8AJBf8YG1nt2fTF4KERXQDLpw
nvqwKEmaM3y/s8LTUx0oJnQxCUFrfRE1yq4S2M0Ga99Bho84Qvh+wo7I3EMa1HnG
oOIo3vShLHmNoK4buX5kfqRJhgs/Cqn6P83KQvDcoUjJagEsuSnAqeUMO5y90jmZ
I1E7mYfhYZpsnDyYGm5Q/srqj9PDjw==
=vD+z
-----END PGP SIGNATURE-----

--Sig_/93.yJMrxB2DtnwT3NNY0Pe4--
