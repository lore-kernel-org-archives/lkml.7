Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6B7C48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 23:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E93206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 23:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S5zY1mcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfFTX7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 19:59:13 -0400
Received: from ozlabs.org ([203.11.71.1]:55257 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfFTX7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 19:59:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45VJgw1xDXz9s4Y;
        Fri, 21 Jun 2019 09:59:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561075150;
        bh=dRKv1gpAuFaHe14KD9u3aF0D2BZrlR4R94W900TEatU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S5zY1mcXiVQk/idgHhGWbaZ13+bMLzLSmaw6eaibs1QzTyr87dTROWuyplLHZ+Ck6
         qubPVPMHPYfL2h7coUVvb68VqNL9zJwUrB1Ut9nSERRzrpAHBbJCLWhXZzlW9DYv1l
         v8X7ne7lIoriZWwHaVebkTodWTvMP6pSN+6KxzgHvaaGVtiiFnN+WpOE5fvud+ZGqO
         X8yXOyiDjTjOINMCSv1BddiaUlqVHC2vHNcCkMFDSXTd9n/AQF+yANHT5LqJmKdi2X
         YTlm0k5ebzSM93yuWZsh2mMQiSz9LrWyS79vPj3PGk9PDcp0ZWVE4Rj8Oaqn/EuJoE
         Yn5B84r2sM7Og==
Date:   Fri, 21 Jun 2019 09:59:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Linus <torvalds@linux-foundation.org>
Subject: Re: linux-next: manual merge of the scsi tree with Linus' tree
Message-ID: <20190621095907.4a6a50fa@canb.auug.org.au>
In-Reply-To: <20190528114320.30637398@canb.auug.org.au>
References: <20190522100808.66994f6b@canb.auug.org.au>
        <20190528114320.30637398@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ruxyLRDQ16ai9vFSC7QYoe6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ruxyLRDQ16ai9vFSC7QYoe6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 28 May 2019 11:43:20 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Wed, 22 May 2019 10:08:34 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Today's linux-next merge of the scsi tree got conflicts in:
> >=20
> >   drivers/scsi/hosts.c

	...

> > between commits:
> >=20
> >   457c89965399 ("treewide: Add SPDX license identifier for missed files=
")
> >   09c434b8a004 ("treewide: Add SPDX license identifier for more missed =
files")
> >=20
> > from Linus' tree and commits:
> >=20
> >   026104bfa591 ("scsi: core: add SPDX tags to scsi midlayer files missi=
ng licensing information")
> >   5502239e73e6 ("scsi: libsas: add a SPDX tag to sas_task.c")
> >   5897b844b7f9 ("scsi: sd: add a SPDX tag to sd.c")
> >   95b04a2ff9c7 ("scsi: sr: add a SPDX tag to sr.c")
> >   50a1ea5bebbc ("scsi: st: add a SPDX tag to st.c") =20
>=20
> I have now got more of these conflicts in
>=20
> drivers/scsi/libsas/sas_init.c

	...

OK, so here is the complete list (so far) of files in the scsi tree
that conflict with the SPDX updates in Linus' tree:

drivers/scsi/fcoe/fcoe.c
drivers/scsi/fcoe/fcoe.h
drivers/scsi/fcoe/fcoe_ctlr.c
drivers/scsi/fcoe/fcoe_sysfs.c
drivers/scsi/fcoe/fcoe_transport.c
drivers/scsi/hosts.c
drivers/scsi/libfc/fc_disc.c
drivers/scsi/libfc/fc_elsct.c
drivers/scsi/libfc/fc_exch.c
drivers/scsi/libfc/fc_fcp.c
drivers/scsi/libfc/fc_frame.c
drivers/scsi/libfc/fc_libfc.c
drivers/scsi/libfc/fc_libfc.h
drivers/scsi/libfc/fc_lport.c
drivers/scsi/libfc/fc_npiv.c
drivers/scsi/libfc/fc_rport.c
drivers/scsi/libiscsi.c
drivers/scsi/libiscsi_tcp.c
drivers/scsi/libsas/sas_ata.c
drivers/scsi/libsas/sas_host_smp.c
drivers/scsi/libsas/sas_init.c
drivers/scsi/libsas/sas_internal.h
drivers/scsi/libsas/sas_scsi_host.c
drivers/scsi/libsas/sas_task.c
drivers/scsi/osst.c
drivers/scsi/scsi.c
drivers/scsi/scsi_error.c
drivers/scsi/scsi_ioctl.c
drivers/scsi/scsi_lib.c
drivers/scsi/scsi_logging.c
drivers/scsi/scsi_pm.c
drivers/scsi/scsi_sysctl.c
drivers/scsi/scsi_sysfs.c
drivers/scsi/scsi_trace.c
drivers/scsi/scsi_transport_fc.c
drivers/scsi/scsi_transport_iscsi.c
drivers/scsi/scsi_transport_sas.c
drivers/scsi/scsi_transport_spi.c
drivers/scsi/sd.c
drivers/scsi/sd_dif.c
drivers/scsi/sd_zbc.c
drivers/scsi/ses.c
drivers/scsi/sg.c
drivers/scsi/sr.c
drivers/scsi/st.c
include/scsi/fc/fc_encaps.h
include/scsi/fc/fc_fc2.h
include/scsi/fc/fc_fcoe.h
include/scsi/fc/fc_fcp.h
include/scsi/fc/fc_ms.h
include/scsi/iscsi_if.h
include/scsi/iscsi_proto.h
include/scsi/libfc.h
include/scsi/libfcoe.h
include/scsi/libiscsi.h
include/scsi/libiscsi_tcp.h
include/scsi/libsas.h
include/scsi/sas.h
include/scsi/sas_ata.h
include/scsi/scsi_bsg_iscsi.h
include/scsi/scsi_transport.h
include/scsi/scsi_transport_fc.h
include/scsi/scsi_transport_iscsi.h
include/scsi/scsi_transport_spi.h

At what point does it become worth while to do a back merge of v5.2-rc4
(I think the last of the SPDX changes went into there) to take care of
all these (rather than Linus having to edit each of these files himself
during the merge window)?

--=20
Cheers,
Stephen Rothwell

--Sig_/ruxyLRDQ16ai9vFSC7QYoe6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0MHcsACgkQAVBC80lX
0Gz0Kwf/UtAP44k2jBLhnFZ3zojgA8TIB2uIlzOGUfABRubQgdAGEA0XZqsyh+83
lNuq22D7sfeCwt6/FHOtXWq8xIAqSguKcGm4DkxkHq6E9RvIfPWSViNLrEw1hUZn
hos4RB62OQWTupkttpBmaoUtfo2flKSw799uVGqFpjJd/sYKR7DsGkOhYodCfa5R
5G9by5AUSfmuVZ6Xoo3nbHDAGmFPwRQdNMQdF1z9/PyAdKwJ/qRVKptBvWng/RZi
YQOvoVjcfhMADt1enNZxwhEEUKFHzVd6fLQERDvRK6lZZCKdSrYbsEezP79bIUhV
OclE+2Fo/uPyVec7c+Db5zpipjCYJg==
=lySb
-----END PGP SIGNATURE-----

--Sig_/ruxyLRDQ16ai9vFSC7QYoe6--
