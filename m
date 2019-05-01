Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC78AC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD7020866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RXpd2YWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfEAVmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 17:42:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33171 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfEAVmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 17:42:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44vX193pzMz9s9y;
        Thu,  2 May 2019 07:42:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556746941;
        bh=5hiGaQoIG0uAw4xFMIcub/IVsipRRaSm2u/2wIbwaoc=;
        h=Date:From:To:Cc:Subject:From;
        b=RXpd2YWqol42y1AFutefbR/glDVLcZG2/ZDptlhbAHHXETJPaFaK+uXVQ/2A560AQ
         dRqS0lmUnNvL02FhyNr69wrgtbCvL47652g+j1lXdyHZ6aVw4dQ12JswHu7b0DsQWr
         s64fOnRGst1vFJbHe/RSctksDyYZoUq8JXhh1aS/XO2pBeyRqodwDTqeKYxoMLgjFM
         516mN9DFp9/w4vIEgU4NEiigUafxY6p1nin+Prx0WK71dd8WzgKPeE87x+SPMKY/a1
         YX4U+cLQRhmvDAXoI8okuz85CZNIgyLzjSHA+3Cb/3IaQwQkQeMDperQ4JUcDioEas
         S9UwFfDzHhJzA==
Date:   Thu, 2 May 2019 07:42:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kbuild tree
Message-ID: <20190502074207.01ae28ba@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nz79D.vKLeh/Sf1bfBDs.U2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nz79D.vKLeh/Sf1bfBDs.U2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

Commit

  7b6954a982e7 ("scripts: override locale from environment when running rec=
ordmcount.pl")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/nz79D.vKLeh/Sf1bfBDs.U2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzKEq8ACgkQAVBC80lX
0GwWRQf7B3SsBzdthPP+lVz35l6tnQsMF6k5txw9wWHEEZR1B6xB/8+yvMmXgrSB
Z5LAfY4HmlqmHpzi2DvU3uZRUH2J46xmOCpTWYAFdOyUwb2Jc8kRJDCHuzJ26Qkr
+/Cc4JlirhZ1OHrbIANuC/gXj9F5vxHJ+zekOMP6ws1ERlMw5/6RYXLkfXOY5xVm
QJs+8beHWkRULtM4iP+lNcTdpHdGNKneO62MTA5BD0XdXpL0WHrdSsUJNSKLMC40
/tPM8XQHxjFWpueziiUfmKoY2jm2NZuQ1gbRGlUxI0FachJ5PPOXgxoKuphRqWE/
KLNHC7fzoGC6sUhr1yxdVqiuRdCulQ==
=XrbI
-----END PGP SIGNATURE-----

--Sig_/nz79D.vKLeh/Sf1bfBDs.U2--
