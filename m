Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C45DC7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 02:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364F820873
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 02:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OFv71Zt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390279AbfGTCWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 22:22:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34835 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729002AbfGTCWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 22:22:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45rBTT1yBGz9sNC;
        Sat, 20 Jul 2019 12:22:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563589325;
        bh=89pchNQaTwCtJkzVgc2IMq14XT4KgGS+W+Ry+0m3DJc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OFv71Zt62//jyStqHBpzywP8cPrio53PCzouQv/+Tfr5vBpNCj11dokZTCtA65u/V
         FMWv0sTRihlvJXwhXP9njN66vHxlCw3MQLs0QMzsi3EdVSAXPUBui5mbLqSFsJJ9u/
         VZM1R0jv5++epc0AmVGz27W+iFzWsmOZBiC6c+4E4UZu1nuajDp/RjPGcnM3DQWET1
         KoTptbzTUgJM8EGAIK5nWxNbCO+PSXI0XtZyLlxbWA2dyPXqKYnnV7hH8Q+n1HGWdJ
         hLy1Yk4tHs+3Fl/ADuOsV6lOFYwvpf/DpbxCX5Ot8Ov7T35UhGk3Juh1VGWoOrANoh
         Q37UiopVynF2A==
Date:   Sat, 20 Jul 2019 12:22:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] checkpatch: Improve SPDX license checking
Message-ID: <20190720122203.7baf841a@canb.auug.org.au>
In-Reply-To: <f08eb62458407a145cfedf959d1091af151cd665.1563575364.git.joe@perches.com>
References: <f7dc9727795db3802809a24162abe0b67e14123b.1563575364.git.joe@perches.com>
        <f08eb62458407a145cfedf959d1091af151cd665.1563575364.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QPqjsmXWbqydUvC/uE/SuUL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QPqjsmXWbqydUvC/uE/SuUL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joe,

On Fri, 19 Jul 2019 15:31:33 -0700 Joe Perches <joe@perches.com> wrote:
>
> Use perl's m@<match>@ match and not /<match>/ comparisons to avoid
> an error using c90's // comment style.
>=20
> Miscellanea:
>=20
> o Use normal tab indentation and alignment
>=20
> Link: http://lkml.kernel.org/r/5e4a8fa7901148fbcd77ab391e6dd0e6bf95777f.c=
amel@perches.com
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Again, don't include other's (non author's) SOB lines.

--=20
Cheers,
Stephen Rothwell

--Sig_/QPqjsmXWbqydUvC/uE/SuUL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0yessACgkQAVBC80lX
0Gzp6QgAkw5u0X9lWHQsvWVt5/7xmfdophsWUNvshGO7kzD+of4HAJ2G8gJowAin
c8yY+hOcw74kRjohJvOEJtIgOYN14jgFHpcKkIpGZM8wOHQxEBOON0KVxY0TF/I+
g2cil4VRcxswJVwS4vPZ6A4NfsU73UQDm0TcJBQHXgl4AwhaykXCDbGhOfJiHJ1V
Xd3CZr5wwtKW8yT1AXLSByzc8C7Tz5NGZES/e8qFvaVsseyzH2bWOp8lmKBZXm2W
e7CN7xCm5AqibtDaZqT6Kqaa4dKdSLoDJVedSTwKlerpkmqXTuwTFz1emztNsHDi
4Kp3TDXvbUHjw1oVMlfaGPmuwFsFyQ==
=2fqo
-----END PGP SIGNATURE-----

--Sig_/QPqjsmXWbqydUvC/uE/SuUL--
