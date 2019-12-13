Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AC6C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7E721655
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PwXCpOpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbfLMBFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 20:05:42 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:34269 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfLMBFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 20:05:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47Yssr4k5nz9sP6;
        Fri, 13 Dec 2019 12:05:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1576199139;
        bh=iO92rk7/W8FfPeVvQSlBeV4w2NsHGETcsSRJq5rrtws=;
        h=Date:From:To:Cc:Subject:From;
        b=PwXCpOpD3QULgs2Mx/fO9TJtd/LkfuTbnx51d5cS0h12Xorg8LyH5enRJDeo+aooK
         98eCuvqHD1G6uyEosDJ1Tm92wKRuDmYL2T1L6/2rhnJNPKOY9Vwzsrk/h5cbvIjzG8
         oWcyUfSk37wgNTiM5QfUz7XLlJRJYtQ9BoSKcJt8JVWZcLj6afz5dmDTBfcw6WtWm5
         SOdI9TRFL7cJAtXnzfj9stOgcmYVCRDjv5JAegUIk6emfeM46wSAihpcpA3e1pA/KP
         fNA87b8Ic2UYY/EKJ0I/u+6lIHBKpVVtQCBkF2Pn0OgZYsVGHF5DWhGvU1yYnOwtq7
         EF5CbWLg0IFMw==
Date:   Fri, 13 Dec 2019 12:05:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: linux-next: manual merge of the staging tree with the
 staging.current tree
Message-ID: <20191213120534.6e04aa02@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3kYi1ob=NvdjEDSfW1b1_MS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3kYi1ob=NvdjEDSfW1b1_MS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/isdn/gigaset/usb-gigaset.c

between commits:

  53f35a39c386 ("staging: gigaset: fix general protection fault on probe")
  84f60ca7b326 ("staging: gigaset: fix illegal free on probe errors")
  ed9ed5a89acb ("staging: gigaset: add endpoint-type sanity check")

from the staging.current tree and commit:

  f10870b05d5e ("staging: remove isdn capi drivers")

from the staging tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/3kYi1ob=NvdjEDSfW1b1_MS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3y494ACgkQAVBC80lX
0GzVzgf+L8QCs+d49M+X4c9aqQaNB7MKOX2SqW3C5oBCokd0g1ITnX1E/dVhJ1mU
vWSpAox6k2f19WKZNdvyqpc/RBYFq2mJneo/2z3Uk4rkI0AEvsEVk/G4Cqw8Uv05
xj/mttubEeVtydh3X9SXbrNlmWtGrpngivx1pSKOMX2hPn163CCezTAXwtWudEAz
OOiQI/qQXUsBlRok6s+IcE7Yl2wVZaqreKM6OudoWCD7FawozH8IoQ8EbqVP3OI+
cI2mMX6TwRICE5q/4FPhnGu01TXMAbZwBevmZJ6nLFXBLJR+B2sofCeh/Cq5xU1d
sbEWa/XxWu5JQ1mV3W40roVU0OjXpw==
=R24S
-----END PGP SIGNATURE-----

--Sig_/3kYi1ob=NvdjEDSfW1b1_MS--
