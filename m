Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84311C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E1F20879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YsMZ3Bdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbfEMPBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:01:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38801 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfEMPBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:01:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 452kXY6XYWz9s4Y;
        Tue, 14 May 2019 01:01:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557759662;
        bh=jM/BYYYQ98rAruaEqByhmGooQVIjYf4G8WEdp+Ovptk=;
        h=Date:From:To:Cc:Subject:From;
        b=YsMZ3BdoDUiAyblJPK6+7zhwwBvC1uIbNaSRG0CCV/oKf0rFn8E9zjNLnQwHqBrxt
         uDZLzPOFOOKscDRG2OAEuMit8DldE/yJtaCxNdGJnl0n5JxnRBT8Nkme6QjgDmCEgT
         6VItbh4NqHKn9I91CMt8HBp5Nfml+pZ/BslOaBedklCBD4FmaWSbCzNu9fXDWdH0g6
         Ts8dnMUZbwPqny9pxVl0iUhT0LaZbN0kLXeSFWqN8ISOGVzstSx5HmwAGb+K4+5dr1
         exC3XN91/3Jupne9xe1QUJgRr/U6i5OxrTkEyqlQrjCJKPDvMozT9ITahL5toJtfVS
         N2eA9gGQDq4rg==
Date:   Tue, 14 May 2019 01:00:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc-fixes tree
Message-ID: <20190514010054.5ab84a56@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/00XKta0_obGgJC=tRojAR=4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/00XKta0_obGgJC=tRojAR=4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  7df8e234449a ("ASoC: pcm: fix error handling when try_module_get() fails.=
")

Fixes tag

  Fixes: 52034add7 (ASoC: pcm: update module refcount if

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").
  - Please do not split Fixes tags over more than one line

--=20
Cheers,
Stephen Rothwell

--Sig_/00XKta0_obGgJC=tRojAR=4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzZhqcACgkQAVBC80lX
0GzOyQf9EUlQwT2PGd5j/mRjB7SMtOV9hVhk7bzj8rxE/7F9i08M48c9k4lCRK4K
hTF/fMryO7pxldkKtE8FR86SQRu200o89N2X4+81rNniXs61MTWezo1yzbfUPRZI
ciQDMjA5ij1bdCOc76xLpfYnIQWH9cwhVhOZZ19ldzZcAR3QBFEWDPxX6b2O8Ksn
tTDRFyJdRczeM+rwftRdQqVt7yAxyDFXmP6Lcej2Jq3FLduEZdliCdJzDi1fiZdV
IHBDQRKMdCMrbflLM9G06ALkVkN1qnAXnE2oj19lJD0uGqCp8jlnK8mwRaPkEGNo
aae7XyShZbaIkirqJLE3+9RD1WPFVQ==
=6KL4
-----END PGP SIGNATURE-----

--Sig_/00XKta0_obGgJC=tRojAR=4--
