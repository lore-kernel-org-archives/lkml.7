Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90473C072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612F121841
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j0oR+a1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfEVALl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 20:11:41 -0400
Received: from ozlabs.org ([203.11.71.1]:48145 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfEVALl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 20:11:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457tNB6Nlyz9s6w;
        Wed, 22 May 2019 10:11:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558483898;
        bh=aWc4GcbweEa3FC2GdDxGdp7frJPYEwaj74KnxlB7MWM=;
        h=Date:From:To:Cc:Subject:From;
        b=j0oR+a1i2e7Flg04+CR7GF2vRSLcM0o6adO8oQ//G4fagnygBkIAc0zy5m6oo/y6V
         8k8lvLCBEiX/HOLT3EWBm7PCU9z+SSFoN92mxQDVAzcomZYPQmu4/lBmuwwLWvWYLQ
         scZ8HS4Yp7uoV5gXg6ymjJZoOF/1ITw2gkaPCng/wu3kfFOggPr2wM6i5ukATziwT/
         u27nQj5bFGLYRDdwadraxB/hLeumFPMZaKiLKXN6+5uGpFDQ5aLecZObqpO9zUdEBJ
         xPslUfp/DPLJggkDJPoV9aI3hQkai4pwGM0gqHWU7M1O3Kx3BoGebxIJzv7ET904B5
         FVcumTIdRLXlQ==
Date:   Wed, 22 May 2019 10:11:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinece <hare@suse.com>
Subject: linux-next: manual merge of the scsi tree with Linus' tree
Message-ID: <20190522101138.3797b3d0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SWqY30olTy+T8neXG.DkgSr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SWqY30olTy+T8neXG.DkgSr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi tree got a conflict in:

  drivers/scsi/osst.c

between commit:

  09c434b8a004 ("treewide: Add SPDX license identifier for more missed file=
s")

from Linus' tree and commit:

  70841904d909 ("scsi: osst: kill obsolete driver")

from the scsi tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/SWqY30olTy+T8neXG.DkgSr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzkk7oACgkQAVBC80lX
0Gz8igf/eIWVE3LL64EJmtlG73TBlNTQgiqQn3T2eBRPnFpbtNbyqIyhtMG1Uxja
3TscbjJkuBYLZw2r/gMKtqJlZJQiRoS5M5/+sV7iHrXhkbkBpe1h5+tQX5PC3FX4
PG9VKacU0cudMnO+vCKYlm46XIP1RCPD/wNPY+oEqrXpiaer/24MU/PpVL2rkmZT
nfOn6k/7kqBNMnR7AiRZKF54gkeyCUPB0VnHhLrbrRUSlDqVs6S/31EUCBMWNNdO
fYMY27AVnZ5j23ONTjuesbNfOn4iur66Q9BWfuxZvt2/gQvzkr5pwpGv8lJXCL/m
+VsvQiBNEFM85+Rlaq7A17A7F3vI9Q==
=GMpd
-----END PGP SIGNATURE-----

--Sig_/SWqY30olTy+T8neXG.DkgSr--
