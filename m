Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792B7C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49129205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Nu0HwoT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfFXBma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:42:30 -0400
Received: from ozlabs.org ([203.11.71.1]:41179 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbfFXBm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:42:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XBhl16qxz9sPH;
        Mon, 24 Jun 2019 11:36:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561340183;
        bh=mXfAPd4wEewFFVOAb8egEK6h14/2g9IBvmSgUITDhvc=;
        h=Date:From:To:Cc:Subject:From;
        b=Nu0HwoT4bQjzu21IfZevvglyxYd051dcE8LNfM04ruhmhGOTjYYHC4sqIu7rk9qGW
         3P1YsnJUXlW3uIid1RbqwmT0tU71QfP7CXMT3i44idkb6RRh9zudx1vDDTPje0+kt6
         LtPGswW7R37bQGsIV/20HHx64aDoItHhwGp7aAJ61D3H3HrJuKYwGFMP+fyiPdwpdo
         ZJtvlWBVt0a8bVs6ccqDdeKVFvGZRbimcJ3t2f2IDLVpQlVISdS6eCHZ8hps9+olKB
         gbYv3Q5rBPJ5sVWr0vrdfyUKsece4rO4pne5Wat1tYvjGUt200vC/XKAt7JcjnLKPh
         6cUHjcfhY81kQ==
Date:   Mon, 24 Jun 2019 11:36:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: linux-next: manual merge of the v4l-dvb tree with Linus' tree
Message-ID: <20190624113622.5c1abcb8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NX_RlpezVxPMk3jUESTSkqh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NX_RlpezVxPMk3jUESTSkqh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

Today's linux-next merge of the v4l-dvb tree got a conflict in:

  drivers/media/v4l2-core/videobuf-vmalloc.c

between commit:

  77512baaea9a ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 237")

from Linus' tree and commit:

  513dbd35b5d9 ("media: add SPDX headers to some files")

from the v4l-dvb tree.

I fixed it up (I used the former's SPDX line (GPL-2.0-only v. GPL-2.0),
but the latter's Copyright line) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/NX_RlpezVxPMk3jUESTSkqh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QKRYACgkQAVBC80lX
0GzQzwf/VVHFUMGafQhmY+8XtJKUM7HfEtO8yv+TGbx8U226+PKHvg47xbbc/uyo
vEJ0A4S2kAN96XB+EAOnD2XivXflUozdnnEY2MwAMhpTVz+ilOrgCHR/sF5s4i8Z
shAGbYDF2ECxxrdleCF7HCdmXbILXU8dR6/zsGgxfZhSoI+mqlMGgRHukJz3d213
pVJ9LZ7/LyzRAekrNv1f1cqDNrnWa92SjJqIOCWltpYWVQ+PxrC9egGAQR/FFkto
N3Vm/XbqziKUOwoPF66NtZd+aQj2NqjOQ6QzvWL/9b7LCpeb86XKEgep1QtXrM6A
3eqfSdd9pZWGWSkkYHFIufE66kFUNA==
=QLNw
-----END PGP SIGNATURE-----

--Sig_/NX_RlpezVxPMk3jUESTSkqh--
