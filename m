Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AAAC072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F5021851
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AIecjfu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfEVAIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 20:08:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59039 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfEVAIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 20:08:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457tJn3wMmz9s3l;
        Wed, 22 May 2019 10:08:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558483721;
        bh=I3crdQQbKqLMOdRE9Ayqn0WENYw7zW7YjkK6K356lrI=;
        h=Date:From:To:Cc:Subject:From;
        b=AIecjfu6JLjr/+c6PVPzWaG4Q2ZCvPRUwNrtnyutnLEmxnvAtYr7fbnWFDAETnAxB
         yywQFQVZ2o2GISW+gBD+kp4kpdAP0CyAclMRfPuReIOx9xSqoPWTBaPtwMCp4n1VH6
         dAMBP9Hy4zFqFh4bBMzw2iuan/r6x1hPD/Bu4z1rMZftTJvOJIzNLAiQSAKnSW6If6
         szH9sDYcUKeEACv35NmkMb66H8ZDTkrgF+lzgKnm1RVOPm9G4K7DcH6iw0JtdcV0IS
         XHNtzwbJpJTqRvxCiQuHlpuJnJrvmf6sIS2EeQsKxur1WKtDdTpjr7z9r/3dq7J5CZ
         zZcCgyYgnvqLA==
Date:   Wed, 22 May 2019 10:08:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>
Subject: linux-next: manual merge of the scsi tree with Linus' tree
Message-ID: <20190522100808.66994f6b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YwkOGvG=CkLqflpVH/R29Pr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YwkOGvG=CkLqflpVH/R29Pr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the scsi tree got conflicts in:

  drivers/scsi/hosts.c
  drivers/scsi/libsas/sas_task.c
  drivers/scsi/scsi.c
  drivers/scsi/scsi_error.c
  drivers/scsi/scsi_ioctl.c
  drivers/scsi/scsi_lib.c
  drivers/scsi/scsi_pm.c
  drivers/scsi/scsi_sysfs.c
  drivers/scsi/sd.c
  drivers/scsi/sr.c
  drivers/scsi/st.c

between commits:

  457c89965399 ("treewide: Add SPDX license identifier for missed files")
  09c434b8a004 ("treewide: Add SPDX license identifier for more missed file=
s")

from Linus' tree and commits:

  026104bfa591 ("scsi: core: add SPDX tags to scsi midlayer files missing l=
icensing information")
  5502239e73e6 ("scsi: libsas: add a SPDX tag to sas_task.c")
  5897b844b7f9 ("scsi: sd: add a SPDX tag to sd.c")
  95b04a2ff9c7 ("scsi: sr: add a SPDX tag to sr.c")
  50a1ea5bebbc ("scsi: st: add a SPDX tag to st.c")

from the scsi tree.

I fixed it up (I just used the scsi tree versions - which are GPL-2.0
instead of GPL-2.0-only) and can carry the fix as necessary. This is now
fixed as far as linux-next is concerned, but any non trivial conflicts
should be mentioned to your upstream maintainer when your tree is
submitted for merging.  You may also want to consider cooperating with
the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/YwkOGvG=CkLqflpVH/R29Pr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzkkwIACgkQAVBC80lX
0GybKAf+OVoyCmYgeS/h1QR3Ovw1c+dwqba2qpyaIzgcu40gB1XO64HZaKjWn4Zp
/q2bEtNJHOtjo8Cnu7g/mop4Yod9dIk2oDcmPTKCY0JFTE9RTzHs/xvxKUAWuvgQ
UbbJR/pKEOAADHCLKle3zuFz2CAJSQ4N51x1HOn7bGJHDnlGJteyN1lRJ4bONZKH
7tqtOdnvrlq+SlgVrZfGoe3h2Sp8Nm0CAKHJXGBpOih28MrQyhCpfXaj05hnqVlC
gM9jD5LaSOyQSay7dUdD1TeSRk9UOc1VrrzqUQ4KuuZmdqe8g1R7YfUXQXTRazJc
XEaNl5jDVqIj6onzR3ysuKFiTmpXlg==
=bfyr
-----END PGP SIGNATURE-----

--Sig_/YwkOGvG=CkLqflpVH/R29Pr--
