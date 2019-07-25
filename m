Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721E6C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 00:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4B02189F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 00:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P9VahW2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbfGYA0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 20:26:31 -0400
Received: from ozlabs.org ([203.11.71.1]:58633 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbfGYA0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 20:26:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45vCgm0pqFz9sDQ;
        Thu, 25 Jul 2019 10:26:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564014388;
        bh=yY5f1BQ3ftQUAXgwLkvTQkAvi2ppt1EQF1gUmO76NVs=;
        h=Date:From:To:Cc:Subject:From;
        b=P9VahW2jkh41g3gke2aO4mfmaO3xOYfwpCsvpYnUcbxtCQYf8c5UmwnHJQfj2IoeP
         EYAijFZfdADICDr63weqx6E5HgIqcHs0MjnIYloQE4cFkpCSuXDwePGMySyV2b7O1o
         A98GQvdYycMhjc0yBk6Ym/rgE4bksjL24lbNqlM0ApJVNIgvnfRqfN5y2FknWXnBDn
         dCn50uPHoEAgDRbXGQ4tDmqSoYw4+N2DoIsRPWJe7DfsSvoY323sTlm9KA0W99Ud+3
         V8rUp6mMyD0vbvkiaUioc2aWCW1cxi7h2KCb3xKli+QRaTaRlI7p3zyqeyEKX5eM9r
         x5/ikcXgtdw+A==
Date:   Thu, 25 Jul 2019 10:26:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: linux-next: manual merge of the jc_docs tree with Linus' tree
Message-ID: <20190725102610.532ee65d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l5DBjrVyCcpeC5DPJue_iV2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/l5DBjrVyCcpeC5DPJue_iV2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the jc_docs tree got a conflict in:

  MAINTAINERS

between commit:

  2f5947dfcaec ("Documentation: move Documentation/virtual to Documentation=
/virt")

from Linus' tree and commit:

  bff9e34c6785 ("docs: fix broken doc references due to renames")

from the jc_docs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 641ff29be1a5,ff3ae2be2746..d376dc0c7b68
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -12136,7 -12137,7 +12136,7 @@@ M:	Thomas Hellstrom <thellstrom@vmware.
  M:	"VMware, Inc." <pv-drivers@vmware.com>
  L:	virtualization@lists.linux-foundation.org
  S:	Supported
- F:	Documentation/virt/paravirt_ops.txt
 -F:	Documentation/virtual/paravirt_ops.rst
++F:	Documentation/virt/paravirt_ops.rst
  F:	arch/*/kernel/paravirt*
  F:	arch/*/include/asm/paravirt*.h
  F:	include/linux/hypervisor.h

--Sig_/l5DBjrVyCcpeC5DPJue_iV2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl049yIACgkQAVBC80lX
0GyYeAf+MatWr8lBzbqj+wi+Bo3/00xIfrjgUkVuY67COcX8gTz8E6KS8U8yZKgc
rf8pPmnpr0LWvpcz1QMFVtgDNnnHy/BTh1JFif3luwBUWTQKofjIbB2pO9MhDnSM
MbkpQbZyMCgfH4KSz8SCdX0Ur3TzG8AcVjKAhsqk4GGE03rj94TgrWAWlArNbF03
bDGLb55PRvkKq8UG5nmRBBMk5w1QXr7KU8G8PICWNtnlK5fauxSihwU0z/bq3/tz
Baw1gGGkJbHH4lONTRxjy91SIRqhDNaZy7K107W2fQpGudXClXUoerlh3D/6oCo6
UXJb4+q0JrwM55Nzo+fbn2J2yuuCOg==
=hFhW
-----END PGP SIGNATURE-----

--Sig_/l5DBjrVyCcpeC5DPJue_iV2--
