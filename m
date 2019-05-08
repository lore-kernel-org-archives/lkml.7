Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4A2C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20972173C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UJ65kkuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfEHVru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 17:47:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56547 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfEHVrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 17:47:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zqpB6JN0z9s5c;
        Thu,  9 May 2019 07:47:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557352067;
        bh=fsWeFJ18i29DlMOTNiKm3faX0b2v6GdafoFItBbR4VY=;
        h=Date:From:To:Cc:Subject:From;
        b=UJ65kkuyeK6mnzpSOIioS3VFFjfQNCPghbiu3lbKeb90cxZXUh7b9p0+oGL+8RHi8
         l2lydsL0w6E45cnNiGa+/6VfNL+Upz1wWVwTkSfkC56ME1eafpqaUs8Ah6+6RDQxVF
         sRL2iObsNjePt4ZYyh9ILtgRH2IaNhjdKPMhUr9VInTtDN+Ra2W9riloca7QmvFEGW
         8lgIewyQr8xTGiaJKAtdUudptJOUPmxLVV0LZWOoXLH6ySzWHg1SMIPG/c//9MwQOS
         +UuAC/Mpp1PA1vlxfmEPAiRO7kzw8ztpf1tTct5rwKTYM67f7QLkqKVXV74Bm6x1kn
         q524D2IJJpWBw==
Date:   Thu, 9 May 2019 07:47:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the risc-v tree
Message-ID: <20190509074745.65336288@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JuVz_E.gihc1z=sUgwxe/Hl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JuVz_E.gihc1z=sUgwxe/Hl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  da8e7c379659 ("riscv: Support BUG() in kernel module")
  564bd22ea4e5 ("riscv: Add the support for c.ebreak check in is_valid_buga=
ddr()")
  67363778b72c ("riscv: support trap-based WARN()")
  efd48cf0b393 ("riscv: fix sbi_remote_sfence_vma{,_asid}.")
  89f7840cf346 ("riscv: move switch_mm to its own file")
  8c0e1593f15d ("riscv: move flush_icache_{all,mm} to cacheflush.c")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/JuVz_E.gihc1z=sUgwxe/Hl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzTToEACgkQAVBC80lX
0GwWjwf4wB2YFLNTSbr42lg6yvdodtwSa1b1gHnaFmD8hyc652cB3pgpoZ0fXR8o
284nZ1WomaqkemWG8hysMSJ6cEM8wU7aTWPkDkI+LdVAoGcsTuPMgTjT+cd09Eac
cRZTO8YQ9H5nUfmka5yOrUKCvkTUhBdQBJafOo9hZx56lkcojI7utGS0kSfeCDvN
P0jfDXdZNsqNTzys6lhCiwcZxD0+nmbn2Vh6CTNdH7o3OVOqm/XEy4EPQcpLSXZB
XYsEjANDK3W2VSZ1RY6mQ48Eaz3k5x+MTxAUZIFsjch9c6FOUk+nyE5lQROPoIoF
cOW51aynJXYlsUT0onQyXH58AUht
=ca2D
-----END PGP SIGNATURE-----

--Sig_/JuVz_E.gihc1z=sUgwxe/Hl--
