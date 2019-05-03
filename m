Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44840C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1584D2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="an5BuE+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfECFb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:31:56 -0400
Received: from ozlabs.org ([203.11.71.1]:47535 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfECFbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:31:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44wLNS4Sxyz9s5c;
        Fri,  3 May 2019 15:31:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556861513;
        bh=nZ6ciuS4/944fQQaG3TEj4mmYUnn442vpa7a9hmomog=;
        h=Date:From:To:Cc:Subject:From;
        b=an5BuE+MjtakgAg9QUr8BTe46A/F9l8ZHjuinRIRE+kzqsRzI1c2saV6JwJN2YKY7
         NlCGU40emAlIIdJAH/mcL/0USjRrDz4RrXNprSxv5Jn+6HfsxI6+bZmDzWpetqBM0Y
         eWLnP4spSDui+G5CY3OP8/YbMKXbUm4qdg7Ob58g8jYI3l1V/xNeu0eEiLZSAHRObb
         rK+I4xl6IjgTeb2KjjbvGsYKogyTBxN3Q89AFkyrZIf8Cjtr9z/c9RfjpvM8aub6si
         6DGZJYgt6ReXgJqxv4zMKnDYNh9pKAmm5NVGtrfVJjZSNfUidHbOg1hZ037dUzKpdZ
         BHtH2uHrge8Jg==
Date:   Fri, 3 May 2019 15:31:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: linux-next: Fixes tag needs some work in the usb-gadget tree
Message-ID: <20190503153144.06eaae7a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FdUO02xCRC3zY.1zL.XTFS3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FdUO02xCRC3zY.1zL.XTFS3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Felipe,

In commit

  9f8dc24f7f5d ("usb: gadget: f_fs: don't free buffer prematurely")

Fixes tag

  Fixes: 772a7a724f6 ("usb: gadget: f_fs: Allow scatter-gather buffers")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/FdUO02xCRC3zY.1zL.XTFS3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzL0kEACgkQAVBC80lX
0Gw7qQf+JwVEjPgY7PgCB6VQzYYqo3fCcOw+UwpCdtrUNY0PuQdBE9O1nJTAROvg
My2DFkDW+nB8xTBMRrOy5pkeK/AitCkaFLv4nEaI1E6UsylnLHiVLwGBqW34cJDS
lKAUcxNnb0rbSabeomIKM9BR5BVAjCY/EQ2k9HHh9zupFYz2n82M/DpFG67HDlRX
HcB2m9ZQI6ugxOmz4Mku0KsEGAjIxOAky9HlxUuC4sNlnOwIm02rGWHeBKUTZ13A
UfK7FvBJf8W2GAi13iXorioXCNMtVD5x0pNSzuTWc4F3SBwbvVTPsU6MLAo4fQrv
NprjJ8nuNsxb+E2MtFwHiUwl1uuArw==
=REs9
-----END PGP SIGNATURE-----

--Sig_/FdUO02xCRC3zY.1zL.XTFS3--
