Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED96FC48BE3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEEF2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cgOQG0u2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfFXHMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:12:42 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46147 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbfFXHMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:12:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XL8k6cZ1z9s5c;
        Mon, 24 Jun 2019 17:12:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561360359;
        bh=i12NKFmhdL+rltUaVDXyIXkIQigSP6RZ9AXJcZsdP7A=;
        h=Date:From:To:Cc:Subject:From;
        b=cgOQG0u26bYdJCfzABk78C2oDBIKDop3CizYb/NmkzIRDh+5Kz1kGEBAuO8QIFeQ3
         g0tiI6v63NhsuZfwS11DCnanUoxqjtWfxbBCwG/jAn7DaqDr8Bbfre/PLoZeAKlLlK
         d1wvOhqojXEKR9px05twa3LuibyKPPLBLJxG1ePOQXcc9v7cj3FwLILV7C3J9855zJ
         PxZA9265skZtrZ50osxCnVBm0ldS6oodxnY4lLf6/H3QI+TYTkUTadTQbRqeAzrIx4
         fOoSgUdENbb8hDm7iNTG0LZqE3Xq1NQO/rX1e6iHfCfNLlS3izE35JoV2LhADhOH3g
         tErl2ZKakfccw==
Date:   Mon, 24 Jun 2019 17:12:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: linux-next: manual merge of the usb tree with the pci tree
Message-ID: <20190624171229.6415ca4f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/P5iblX_jEpcqCmZ4YPKcOh8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P5iblX_jEpcqCmZ4YPKcOh8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  Documentation/index.rst

between commit:

  c42eaffa1656 ("Documentation: add Linux PCI to Sphinx TOC tree")

from the pci tree and commit:

  ecefae6db042 ("docs: usb: rename files to .rst and add them to drivers-ap=
i")

from the usb tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/P5iblX_jEpcqCmZ4YPKcOh8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0Qd90ACgkQAVBC80lX
0GyNzAf/fVw/v2vFj7LNgNdaaxB4yikXKCCCipHc7M3zAgZvH9U4sV1nJEvEQOgG
ns6k1sfcyLW0YuG8g6tF4pIWPfKc4sOZlg3coZibvmaQogSd5gHz7Pu36OnTY0Vv
c3+6yqt8hYWw6Ua8bMM72KtFeO+AsOJMdU6hHIx2+0f3I+kKscH6wni0PWW8TnFv
Zl9Ymv8ufHQDqdVzIhL04BqSLwd5zB0bFiiDTHBSgBWDHMIuDD6GBuNiOlcrXpMo
XrnbFr3yLRvPY37eLeG9CgopdMgxDRg5qFqAQEoG43YZG86yBqVUQ8HufeQFEY0h
XbzKLI7S7+fKRwtSTwN39BybGQUdPA==
=/b3H
-----END PGP SIGNATURE-----

--Sig_/P5iblX_jEpcqCmZ4YPKcOh8--
