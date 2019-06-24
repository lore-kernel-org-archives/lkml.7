Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00FFC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0D0213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sMplEexP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfFXBmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:42:42 -0400
Received: from ozlabs.org ([203.11.71.1]:57899 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbfFXBmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:42:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XBqw6RT9z9sNp;
        Mon, 24 Jun 2019 11:42:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561340557;
        bh=XBZyZiWGZvEcYJxfAYdtAgq+Dh3SIHzZg+ZSyBneIcw=;
        h=Date:From:To:Cc:Subject:From;
        b=sMplEexP8oLKl06X1hDE3fCa3vHejQ5HRFepUQ48BZyVhBonGvMShVh5gNYeS+hCj
         15d5kJAEyezGOKGdNd/5X9Y+8VkjdLzUsYBnvea0cc6e9zYzrgeZ7reItNyHQQyJb3
         ix30/hp3XjtFXPoD5AyXN3D+fp/+1jmt8h8YgGPi/03QGcrRiFrI81cZ8/Nxccui1A
         EdyCcDZV8b4lWAq/ogT4HFdaUY2BXgRYg2puv5RBhsD/hEdWEmOck35JkNCu86CqFL
         j+21rDRm/E5x5ovPSxvfjsGdonRJU+v/Tco2Pc/pkLyfDS+t/RoUF10HNG5Fm0MHyT
         MophwVD9PzLkg==
Date:   Mon, 24 Jun 2019 11:42:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: linux-next: manual merge of the fbdev tree with Linus' tree
Message-ID: <20190624114235.2a7249e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UGr24t_4FVr3bOX8gNqfH9G"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UGr24t_4FVr3bOX8gNqfH9G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fbdev tree got a conflict in:

  drivers/video/fbdev/omap2/omapfb/dss/rfbi.c

between commit:

  caab277b1de0 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 234")

from the Linus' and commit:

  76c47323c151 ("video: fbdev: omap2: remove rfbi")

from the fbdev tree.

I fixed it up (I just deleted the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/UGr24t_4FVr3bOX8gNqfH9G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QKosACgkQAVBC80lX
0Gyz0gf9GKDIaaLzkF3pmY+zbZ2Sxitn2w2zl9kcAFwxdVPsDh//ltLL6ZZ+6e+i
iq24N3OiGfi7PT9vxg0xWZCOhwoErSRKWSQvuk9UaCJ+oZK9HdbIwFcjiM+2cm0S
h1QbElwb/Cvs3dyOiEMehHZUW2SWBDxOZyAFCxlTdy/wV+raQZHrTzQLcS5sk491
znQWgJn/b9q10fjncg9+nPM3Zg4c+BwfKYBHgn55GV82aytHS14GKHsumI4EzLyZ
fa7cU5Vn4q5Gstsy1Xfr7ZOuIoa5v5uB5z7Ghhq93dHeY5z6TxRZOCio7artUufn
nT1MxkJ+4KjXVEsQGJdzgDXCzGfDnw==
=ua0L
-----END PGP SIGNATURE-----

--Sig_/UGr24t_4FVr3bOX8gNqfH9G--
