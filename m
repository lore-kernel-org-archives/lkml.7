Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF870C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84769217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tl1UDr8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbfEWOFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:05:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56315 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbfEWOFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:05:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 458rqM10t9z9s1c;
        Fri, 24 May 2019 00:05:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558620304;
        bh=3h0BBJ3O+yn3aVX5y1pI8OPBlE842FlSdhXH1r7fhpU=;
        h=Date:From:To:Cc:Subject:From;
        b=tl1UDr8a73UZAfYW7vtwGLILiyNIxrB0R5MkcbYp8+aiaZGzSbHRAaGPUMhMNOqc1
         H1qPeHRWZusA63RfN6Y0aJdqzQc4Ym6e8g7Yb3BbIMt/oeUp9udGrzMTZrTRzivtIh
         sKpUsmQm8O59VWxHccO+lGCkyRWmeWkrQGFBfmO28RkAQQP6aah/yQIkRYOnmHd9m+
         R2wQBhTlEi5xdG5IYOXehs8hq8AdyqbDXf/sOsSKfswPgHXrdTlELLjOzPZO0fOZ0g
         D73wiMhQ0ULrpi3sGkRrLyRnvOqlg3rbBEf+IDoVBiHQN2oblJKIP2Q0LxqVaFdD2Q
         bQnI3ie3sWDAQ==
Date:   Fri, 24 May 2019 00:05:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Shawnx Tu <shawnx.tu@intel.com>
Subject: linux-next: Signed-off-by missing for commits in the v4l-dvb tree
Message-ID: <20190524000500.61cacf9e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/O8P95TJW9lavI20hcLXF0XM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O8P95TJW9lavI20hcLXF0XM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  eeabf6320e2f ("media: Revert "[media] marvell-ccic: reset ccic phy when s=
top streaming for stability"")
  bbf83ed40252c ("media: ov8856: modify register to fix test pattern")

are missing a Signed-off-by from their authors.

--=20
Cheers,
Stephen Rothwell

--Sig_/O8P95TJW9lavI20hcLXF0XM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzmqIwACgkQAVBC80lX
0Gw1pQgApMEALJonkcF2jt9Vipi+s2PqtfmkE+Y5BheSOn39v4/NsfL42leXTiGg
PohNjO1nLUtz27FE7mxhT03Cdzftl66EpNpiZnzIyRtRfzAqnhN4t6pOHGM2XK6r
xT8Eyn84tpZGzd8xreCHu77Y83Hrp3z2IKOGi+hrD1JZCkneLalk6b55UB4Crs2c
1wOUkc1xuegN7hxmwHPcpM+8XnXxsRoWuUlEI6BbxApUd2psxYGyDA2h3OJQ28hH
3Yh+/BjflHTA/67klKqgmpuU+9hS08tZSmwxIaWVEV8S/CLDBjo526ZMYGHW//xH
tQQcKX5cyHUdKd2FvQRUoGp3LVcLiw==
=HoPq
-----END PGP SIGNATURE-----

--Sig_/O8P95TJW9lavI20hcLXF0XM--
