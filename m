Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F31C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30980218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uraAkV58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfDWV13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:27:29 -0400
Received: from ozlabs.org ([203.11.71.1]:43613 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfDWV13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:27:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44pc3g3Nnlz9sNB;
        Wed, 24 Apr 2019 07:27:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556054847;
        bh=WjyH/grUIHp3oAWAW6J8c8CRFKGr0TUbE0yRhEsAlCQ=;
        h=Date:From:To:Cc:Subject:From;
        b=uraAkV585idPc6ZjsHMsKG7ODu243fwssHjf4DHwtQYjTpExHs9SiV0bSJ0omffew
         nUxifxYQ6JdbdcWGfNPhgCqPerB/JXEyVkQRc8jGvd7XpZZpT2hBuc5nTrPyEFCNVx
         AyuBOcwunW0jmAcUcUufabD28kskjcZNlGmVwT4w0FNlOk457mORlY3aKwGCvcnfwJ
         7ulWD5/+j9q8UJ1e+ThC5jEa+SDq90xo368+mDDtR6GRqZ5IlDbnAqIGQbcV8rbE42
         zmT+JaKBqp5zjyiuvzM0qTh0dg/SUrK0p0SMOdTuJRQCFhvXXSXbIrD7ZRbEBClVw7
         jyiPU/iNRNUiQ==
Date:   Wed, 24 Apr 2019 07:27:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the clk tree
Message-ID: <20190424072726.0e1318bf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jhGerAt9b_NTWsMMsrKjMXt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jhGerAt9b_NTWsMMsrKjMXt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  1a80c922c718 ("fixup! clk: divider: add explicit big endian support")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/jhGerAt9b_NTWsMMsrKjMXt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly/gz4ACgkQAVBC80lX
0GysSgf/T8voy1eM/YFdObYitMDfgeunpVx2KjtkrRivl6GPboHkBZk98RMRAo4C
D1sO6UlJVKXhFlnbI33tf9zD9RevrSlL89sQvxpdiCSR7OhXEaWAutkofZEbwKkZ
3CWLR8MbG5hFsdSscRhFyfHzhsQtDVsFbjVnh/4FCk5MJNv9rcRhHZaex6DsIiNU
l3pzXISFTh48XhdfGrqX5jKe9zRQ2Zxa93zZgceATX9iMhZRFKMeW40kswizNHN4
ex0OAMvW5bmz0MB1I7tPZKf40b7kW3tgI65uMumtY+NK2C0cJ9/EhPCNjTKgKhGV
9nnzhM5kujWAZ1wPVOjvUgoVSCMr/Q==
=4qu1
-----END PGP SIGNATURE-----

--Sig_/jhGerAt9b_NTWsMMsrKjMXt--
