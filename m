Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C1EC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92152071E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="E7f1kXLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfLBUjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:39:25 -0500
Received: from ozlabs.org ([203.11.71.1]:33811 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfLBUiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:38:20 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47RcQ11brKz9sPT;
        Tue,  3 Dec 2019 07:38:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1575319097;
        bh=rhHd8s7nCE+B2Ro3ajMN45mURwMRXeZNXtYAQBqpDeU=;
        h=Date:From:To:Cc:Subject:From;
        b=E7f1kXLpC1QYvXGGbQn+3ZNf4HrB2+D7MO4ip9pLjq4LPGocBUaKTTKAxin8NqvbN
         eVqhjkFASvI0fLbXxgzA31JsEtouk+fcjv8PjoKSzsdh/JT4re4rKi8bo/ZQpGu4XJ
         z61sC20WpErK523pfahN4oGTo1czfqUbK67RnRksXNPAWwt0HW/s6H2Y2BJDuUJ9+n
         ogDUMiwsIQKsKAvljliAIV5OxIgkYyCYuUetOUOu8iaw90241gg9ImmeDZzSQvmpKC
         jksya8U45O6hiyHoB3L8bJI8x9v5teciWZUE6FGzSWFaj8euN2d82guotNXJX6qshJ
         yvTs5jC83Bl3g==
Date:   Tue, 3 Dec 2019 07:38:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Andy Adamson <andros@netapp.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>
Subject: linux-next: Signed-off-by missing for commit in the nfsd tree
Message-ID: <20191203073815.78965ad1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qslm3ilGvqTnyko99/FU7FL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qslm3ilGvqTnyko99/FU7FL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  dd4320a29d65 ("NFSD generalize nfsd4_compound_state flag names")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/qslm3ilGvqTnyko99/FU7FL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3ldjcACgkQAVBC80lX
0GxXtAgAoruuKX7ZasWpH4XfafgKow1I+d+JH4MX9VBvyuaGBGFzAQBegZY6C1e3
Yr05tOo11Kn54fBMBdGFJq7brJ94X34QD+yUoE9WfmbVfLjIzPrYvCggkW/2Onbp
VWl2JmLpmXiZFUjC5EKKDphXRiheLyNCT4wSzYWr6F1ypgLDcLYVQmWDR207suLo
aJR0OGFOoUMIEx7lQeWILJywdquXNFL27bJNNp3WRG39mXSOTthQtQyDBD8lxeZW
9s1ojHFZ4QZhuOoVhp/yhx0vpd54Cs2yQDHLXLYzy8fxYP3AkLXmrx9OAwEO6F1f
RQPg9Gm8OgWFBWDyDt7prl0Vb2b7FQ==
=aIWY
-----END PGP SIGNATURE-----

--Sig_/qslm3ilGvqTnyko99/FU7FL--
