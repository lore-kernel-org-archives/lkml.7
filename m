Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A695BECE58E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732E7206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="p3S+X27Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfJGUQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:16:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57037 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfJGUQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:16:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46nBZY6jbQz9sN1;
        Tue,  8 Oct 2019 07:16:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1570479382;
        bh=VZSjK1l2wJBxw+0pH+qmLvoKYUvEQg+U3nwvt7myCpA=;
        h=Date:From:To:Cc:Subject:From;
        b=p3S+X27Q0Ly/9/U3A/2IEM1hNt8EC/yi2Exy14yAXcCjG766UaNuxGOyMjJGhsXeR
         LHIo8HZOtFPsW/ZkUubwffPLods3pDHzI28ui40l+swLQnII0sD8yqv12PUaE95hA9
         QKhk/LrvQYGXGNJtXiUm+mAHqTMn1rGPmKjNHXe9lWmOLnJTe9es+GIB9jj+rW4QbM
         r//TjTl7uuBW4+vXBi8vjErawXyXXZq1PdlEf8r3+qS1xI9VYJJz2RcsTXsnEv8ndr
         jCtsQxe9PvLBIUw6yIqX874npak/jaKk+RF7uSG+SO0gG+ImyxFjK42Kk438KVTr3O
         wpeRXl+hIblyA==
Date:   Tue, 8 Oct 2019 07:16:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20191008071620.5799d02a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/44=j_MypSp1sY6i.Y4Mw/cs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/44=j_MypSp1sY6i.Y4Mw/cs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1d200e9d6f63 ("block: Fix writeback throttling W=3D1 compiler warnings")

Fixes tag

  Fixes: e34cbd307477 ("blk-wbt: add general throttling mechanism"; v4.10).

has these problem(s):

  - Subject has leading but no trailing quotes
  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/44=j_MypSp1sY6i.Y4Mw/cs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2bnRQACgkQAVBC80lX
0Gy4FQf+PpXTMFyu5QMWaT8tvfHQRzqdAfX5F+AqaW85fujLHpnQhr38RpErlm3R
oBNV7P2xChsmK4NF3vShkn9vpsVqSd6N2lI76hOc0xE2EVq4mofVAjgQ5AHHejJi
aWsup9/AxHSFJ12KF//hecSIJTCBUXicvrZfkzCL3XjdT4WneqknIBAx/qLv6c/3
M+BGnx3eE1ju2P3FhrPJtQDLA/6Cmf+9DZkFXSpeOnbbXNF2RIalxmUnG1jxdgf5
geyk9wnUZWSUjgmCezDH/rwV5tNI1Hz1KCjtLYtmrP71k+EzfpLGvSblQpbv0kfn
ZEjuWHdabOrGmwaGe7sY/S4qzgey2g==
=EUxK
-----END PGP SIGNATURE-----

--Sig_/44=j_MypSp1sY6i.Y4Mw/cs--
