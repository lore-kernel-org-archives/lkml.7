Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EF8C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D42206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Jcv6OL3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfG3Wsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:48:38 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45233 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfG3Wsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:48:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45ysD33QR9z9sBF;
        Wed, 31 Jul 2019 08:48:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564526915;
        bh=K0/yg7jrNEBJPJyk0B+k57Fh4MnkRq2hXlPfcWAN1ao=;
        h=Date:From:To:Cc:Subject:From;
        b=Jcv6OL3KJ6NeVkpXZ8vDNi1pyqbzhAkWjPTo+2zwEd24MruRHEWyXzTBHT/uV43/i
         +Bj0TR92aSUMfNQMoeqdqqUAWGJ855/M7X1Jk6lA3pyuzSfe3Y4xT7BgfgWqPQaSmV
         0YvOMUBjM1KQa1hLd+6HQ7nd4G0xNTkCRXGFoIAzWGuAm12tOAIR7/xQQn0l4bQp+Z
         IQm6HNIMMdYVYAeCC+oj0WemUSAsQEFt68hEPpC57K5KyLmwrGTz0W42Qm9pv30lNM
         9UtQIb4TlDjBTrZ+/rDKzRbyCWl6gFVBrvXX3VExOpTVEUOH0MWbnk3iFBG+rd6O/I
         G2UT8AjB3potQ==
Date:   Wed, 31 Jul 2019 08:48:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>
Subject: linux-next: Fixes tag needs some work in the scsi-mkp tree
Message-ID: <20190731084829.7c4b4c9a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U/dlKXCbMb8n.5hvzZ=mrlc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U/dlKXCbMb8n.5hvzZ=mrlc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  d31ca849b04a ("scsi: qla2xxx: Fix Relogin to prevent modifying scan_state=
 flag")

Fixes tag

  Fixes: 79140e2f4fa7 ("scsi: qla2xxx: Fix login state machine freeze")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: 2dee5521028c ("scsi: qla2xxx: Fix login state machine freeze")

--=20
Cheers,
Stephen Rothwell

--Sig_/U/dlKXCbMb8n.5hvzZ=mrlc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1AyT0ACgkQAVBC80lX
0GxaTQf+LiwYeAIKG6+fbPos8WUQT6JeA8OSh2Wmqu+7uekDqJUspwGgwzkBsJ4A
pLW0koZnwkyHGiN51HBJqrx//b9SjF5f0lM7h2WmY5PGj7JOZwklIgr5PnuNy6IR
mUJipmUeaR0dzQ9t0T6L6jwGaq0HZo2cwCVqB3bbcsqU3S0O6z5tkTSpYHDTDKVm
slJXrniSCgWVqgDGEKwWzjWGuQTuqHzrHXA/4/cso5zhJ0AM+HAT+dhuwx0HMEmb
qmcerJtmHlvRdyRAgW0Tw1+1+QYu/Et8o+qaFlsLaHxlbVAJVU11Gel0Qr4+/Q/D
aRWYeXsTo0LizP+0tX5nrp2YsYmv0Q==
=XOFi
-----END PGP SIGNATURE-----

--Sig_/U/dlKXCbMb8n.5hvzZ=mrlc--
