Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8B0C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FE321479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="A53J2VX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfETXht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:37:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36083 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfETXht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:37:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457FgW4Ykfz9s55;
        Tue, 21 May 2019 09:37:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558395466;
        bh=NF6T8uXrXjAK9LT8iy22TRXHVorJ6rb199nxaLmJkzw=;
        h=Date:From:To:Cc:Subject:From;
        b=A53J2VX+n1TTtp+PXexl/UjP2vBOLFWUNJq2nxC+yfiABcQfIozOYO9XKHxWB8hn9
         6M7eSrRg1D+EFbKdyU7ISOuoBdFK2WQVZQV9AmaVZeqbkcgHZJzzoQwHDWEnUaFozJ
         tRI3oQeeZ0IowUt4xJzMp+CrVsGdTZ1Dbe37vPfNcVw91qdoEtL/BcA+I9VTNFOsxg
         fYghqyqxP2LE8Uef3lwDxLkgUtlL21PvsX1wHRqi/GXRo4eXHiv3wMS6/jbqNA8ArP
         ZRXZI8QzXXgpjsFSVoecTrL4lm1Ew7rkd2HZ8j0Fk9ehbRNfAvOB3HY/lz3XkoSPwx
         EXjXjQQHPZKiQ==
Date:   Tue, 21 May 2019 09:37:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Rich Felker <dalias@libc.org>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bart.vanassche@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: removed trees
Message-ID: <20190521093743.5afaaadf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qV4__MSYD94jb/_zn_wgk+5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qV4__MSYD94jb/_zn_wgk+5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following trees have been removed from linux-next since they have
not been updated in more than a year.  All the contacts for these trees
are cc'd to this email.  If you want a tree reinstated, just let me
know.

alpine
samsung
sh
befs
kconfig
dwmw2-iommu
trivial
target-updates
target-bva
init_task

--=20
Cheers,
Stephen Rothwell

--Sig_/qV4__MSYD94jb/_zn_wgk+5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzjOkcACgkQAVBC80lX
0GydLQf8D7+63Nd52glmAydK9CJpfUEr3D0PvktazS5wpUjmxyt1iqB5Ohq7YkZE
/2ib1WYbIAqEgFfwbW2z+gY2A8qRU6vA05+5QjV0HwLOO763o/GQ2Lujmp7KMqmF
+vpIoGxM56O+m/qLggKL7SZBdhbwX70r9Pwlj8qf59jGzVwkkySsNqVd4ZeG6roD
afzin133cQsMKo4FjOlzUNFjIxtUy3rDXhlzHMBQraw5BXLesYaVFZVMCOu51dWU
BXc2w27NsRvEDXMCdiqykv43pvu3krxaPDaIR4SLeRYzMYkgc9CRB4vd864M0HyX
lOKD1xl4alpb8b4Hr+iZBp5a6SAxiw==
=bxw7
-----END PGP SIGNATURE-----

--Sig_/qV4__MSYD94jb/_zn_wgk+5--
