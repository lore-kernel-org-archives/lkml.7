Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40082C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0D0204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Pz5b+QV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDJVAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:00:49 -0400
Received: from ozlabs.org ([203.11.71.1]:58085 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfDJVAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:00:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44fc4r5Zlsz9s00;
        Thu, 11 Apr 2019 07:00:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554930045;
        bh=GPQo4qIogM/05J8ehOZxgzTUjmDzNxA4M8213SSJrhs=;
        h=Date:From:To:Cc:Subject:From;
        b=Pz5b+QV/H/XPramkDky2tJAUDtfSonYrfHlnxVZ7LZM+1Vv8GPKpbeLTUjz99V00j
         1FB+vBElpSEXmnNDWuxK9Mr6tTHNlVdEG+iIt4T35X0pmWIdbEs5tA6x/YKBCmNhON
         tlskUlUqvwDUvqmUiBz+8W9IviqHTviF0mDUeBT0NSaLYSNhA2X5gXjyBOA+/B5tLx
         x+GBQMRQqQhuejoqcsAfkr6697gZI9lQo++yzW+/ad7JidGcGwQTf9HD8Wxr300FdR
         ZlZ55rdUxBHZEtj2ECZ1SYyHE3J58EeY10iD7/pOS+3mSBTZZaTbv/giA2to7LtN8x
         c1Ig7HcKJYTIQ==
Date:   Thu, 11 Apr 2019 07:00:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc-fixes tree
Message-ID: <20190411070020.38749a8b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gmH.ErzNdf.+VgZ6kbf.hin"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gmH.ErzNdf.+VgZ6kbf.hin
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  70802487bb91 ("ASoC: pcm: fix error handling when try_module_get() fails.=
")

Fixes tag

  Fixes: 52034add7 (ASoC: pcm: update module refcount if

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").
  - Subject has leading but no trailing parentheses

Please do not split Fixes tags over more than one line.  Just use

  git log -1 --format=3D'Fixes: %h ("%s")' <commit>

--=20
Cheers,
Stephen Rothwell

--Sig_/gmH.ErzNdf.+VgZ6kbf.hin
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyuWW4ACgkQAVBC80lX
0Gx7Rwf9Gav4B9R1wsmQc+BPoSx/a1xLX4wlHkwTkp7B1r1QccZxFhQubuY+Jy/h
/0EuLyJSmqE4GxYCNizChjRg9yNB8XZprrJ8EE7wKQPu7VICRCvw6QipyqguXNwD
TBGw0LFCIBw5NhSg4Gf1lAHaLapsEAto7za7TnI7jT/uu8gHhkM1S+d1QiKBWYNj
8SAuQDp5t/QORMaduMXldFkvukxc67sNsWkYKKgLJz/C6if+3ciRjJXP78qWdH3d
FFJ6EgsqDvhzY6rU4ey5WvbOhQx8AwW92YLXIYaysjfxBKUuUX42ONuuOCJMHNNV
k0Tknwze2kFjwYM4go8z8dp+EaZHsQ==
=rVd0
-----END PGP SIGNATURE-----

--Sig_/gmH.ErzNdf.+VgZ6kbf.hin--
