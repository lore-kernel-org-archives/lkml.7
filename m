Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4B7C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 11:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33034222D1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 11:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DvaTcZ1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfCXLcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 07:32:33 -0400
Received: from ozlabs.org ([203.11.71.1]:34819 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfCXLcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 07:32:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44RwH244dfz9sS5;
        Sun, 24 Mar 2019 22:32:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553427150;
        bh=Cz8HdbTt6cYAAD5buSDFvGalHWMmTtKSOpFWH57stWg=;
        h=Date:From:To:Cc:Subject:From;
        b=DvaTcZ1wAC9MJ+i3dqvcGQ7XkRbrQ9qJAHLVAodAMCJnuU5PqZwJLs/A6NwlcySVe
         +GgBqVqnfCOYTzETOynWqXhetn6ayrTBsRCpK1J7lgmjhNrip8rESfHqYCc5p7VxR6
         55q4jwxKLfwUnbOZVPjMx9eipV7Y+0QrYYosEi1XVtaxbjATyMatVRY/YhUAekP96+
         WTGDk2YIqOk9Nb0HIjTLUg8JRJ6cEaDvXRvCjsBGYJPyAEb8YfokwdZv2wvQoZzzV5
         MDxH+/kXmZ22rsDin9li7yM5Yexl54NpOf12D9NEIA62oLF85tKvRrnfubxkzUTT9r
         TWzpaqUEepUxg==
Date:   Sun, 24 Mar 2019 22:32:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the coresight tree
Message-ID: <20190324223227.1987c866@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9Cp+v+LaQOKw2piETWmDytV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9Cp+v+LaQOKw2piETWmDytV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

Commits

  0a3a3dfb0d15 ("perf tools: Add missing case value")
  0dd14fd06504 ("perf cs-etm: return errcode in cs_etm__process_auxtrace_in=
fo()")
  9b884872f9be ("perf cs-etm: Remove errnoeous ERR_PTR() usage in cs_etm__p=
rocess_auxtrace_info")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/9Cp+v+LaQOKw2piETWmDytV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyXassACgkQAVBC80lX
0Gw0VggAlr3kAsn0tVyYqYAB7NipocrEVzLApUHlum2Ay1rA5Fh97WZd/4ZoiPnG
uQGBbAYeKZ9iuVnydx6pMoG9J9Q47wNof2FyOf+ALgrVoOnvkQQNG4HwOl2qNwdn
FVHhKMtbXVt5gAI0rax/qQbCU1GZLtUnOsUR0JH/iNlb3kboHucL1drL/KInsxLs
uPu+zHyxcDynCYpZnT40YBLFWdERY+C+KC3oJFfkTQuakNcnDSn0YMIPHbgZ/ahP
7DYKuUGmKidJ0KWuo3sgf5tbUc3lrMwOyzGbr3thHMb3kIvAG3qeT2bxRaWUtqZ4
sW9JaI3C2+kJgoDOTNEqQx3XtagE8Q==
=rdCs
-----END PGP SIGNATURE-----

--Sig_/9Cp+v+LaQOKw2piETWmDytV--
