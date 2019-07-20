Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27A1C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 02:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F2A20873
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 02:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ndg144Ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390251AbfGTCUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 22:20:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47357 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729002AbfGTCUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 22:20:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45rBRR5gqqz9sNC;
        Sat, 20 Jul 2019 12:20:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563589220;
        bh=bvMXkyNAr5r3GZ8F2W/i8gufa6oHmhb4XVtDwJJ2NQ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ndg144UxdSmgXcsGG688WMrERcnLxKF0belOZbashZDul+UgInRNyhBh4EBqsgATq
         ACgMkCOBa4CT5/jVMVwTmNOCnGrGal+H3DbU8sbmG7+LLSmNJy1d9UCZRk3CYhgDqa
         aO4W9wYcLCu8tMxagAeKGVcu/E3d+mvg+prPS6jAnK97vaukOEuQoUUaY8czbZKcto
         4Hzq9bPZFTDYSO02rEduG4WZzWqBQX6fIbmK/j247kRh9BDmMiRGJPplFOJ7KrMPXw
         u48uVwicszmJRkiX25kB2kbAeA0HIY9RwAgrP+txJXmPOxnCifxHjPcyGx2yyW8Rjb
         2WmvbC5tsgIVQ==
Date:   Sat, 20 Jul 2019 12:20:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] checkpatch: Don't interpret stack dumps as commit
 IDs
Message-ID: <20190720122012.24585088@canb.auug.org.au>
In-Reply-To: <f7dc9727795db3802809a24162abe0b67e14123b.1563575364.git.joe@perches.com>
References: <f7dc9727795db3802809a24162abe0b67e14123b.1563575364.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JnP7d0OjPCyUgA_Ck52rL4P";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JnP7d0OjPCyUgA_Ck52rL4P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joe,

On Fri, 19 Jul 2019 15:31:32 -0700 Joe Perches <joe@perches.com> wrote:
>
> Add more types of lines that appear to be stack dumps that also include
> hex lines that might otherwise be interpreted as commit IDs.
>=20
> Link: http://lkml.kernel.org/r/ff00208289224f0ca4eaf4ff7c9c6e087dad0a63.c=
amel@perches.com

That lnk gives me "404 not found"

> Signed-off-by: Joe Perches <joe@perches.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

You really should not add Andrew and my SOB lines (since we did not
write this patch).  Those were there in -next because we handled the
patch along it way.  Thanks for your SOB though.

--=20
Cheers,
Stephen Rothwell

--Sig_/JnP7d0OjPCyUgA_Ck52rL4P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0yelwACgkQAVBC80lX
0GzLBAgAiLKDwU+4L4Mlgk1lTSqkd+KXCbDZ+znj4oaOkrN6HXbgUxUFFY9Yy+8L
9DZIbTnz+dTjhGEd+V1YsIv165aZNwogPLcgvA3E7nga0mu8bCt23J6+L9JPPGEz
EwKoTJlKeJZD94WT+LI7c2W1sLzKjwhdXZ55g/zQcS5Wo8XCb1j5uyOXSCBp2wio
yHwe5UoEuWwTyOpaJWj5iTlp01VMy3P5kI2ptrQW/WM6w6AX2xDWixgVSrvE2/AI
YW+cfpNeiRmvvw5X82Lti9G6UUMMsuC2EJRnsI3EervM/kyuIlbEkdQXCKZFhSxU
Rd0mxXGdPZJETXH+JrR4lflaAsQdGA==
=7Arh
-----END PGP SIGNATURE-----

--Sig_/JnP7d0OjPCyUgA_Ck52rL4P--
