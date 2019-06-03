Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35184C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A67D27888
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FUhD80QZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfFCOlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:41:22 -0400
Received: from ozlabs.org ([203.11.71.1]:58759 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbfFCOlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:41:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Hd65126Gz9s4Y;
        Tue,  4 Jun 2019 00:41:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559572879;
        bh=BsUXuWa7XZdMan5Fr/rBomN8mgUXMm2wwUq2B3Ou28s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FUhD80QZIpWWBSfznH3zCDFWzaeAnWIH0wHVmpu/F3XL7BZWkG6pc6kHmSCd5P/+o
         +3iR54uLVbLlQx6F7Zm6RsWmqyYwRVtlvjAPUajyFuaKiktVT9eZheBdsWMuLh/EuH
         T6GH3qGYrKu15TKH0scM96UyXDA44ijbe0+jCsXK8rFPcLO2PvZjnepniqD9nXXh7s
         hizaG6+A/q13y4a8U5T/yUOhQ4mTcDMaehVAzdfmegzLzyr+jWae26uhzhsRdscOn9
         It0nU4836ERGVkch8iWh3rE9jmh4eZY3zSvukKQrS34YCAqGA5PJ4yl4c2EAqW1suG
         8fwBV3mcLZQyw==
Date:   Tue, 4 Jun 2019 00:41:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: linux-next: unable to fetch the drm-intel-fixes tree
Message-ID: <20190604004115.47bd8b0b@canb.auug.org.au>
In-Reply-To: <20190603195018.2b7d5650@canb.auug.org.au>
References: <20190603082051.273a014c@canb.auug.org.au>
        <20190603110403.0412ed22@canb.auug.org.au>
        <20190603073103.GC21222@phenom.ffwll.local>
        <20190603195018.2b7d5650@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PVNl=NbJTltydIWQshEQ=3x"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PVNl=NbJTltydIWQshEQ=3x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, 3 Jun 2019 19:50:18 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Mon, 3 Jun 2019 09:31:03 +0200 Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > drm.git too I guess? =20
>=20
> No, I fetch that from git://git.freedesktop.org/ which seems to answer.
>=20
> > But yeah fd.o anongit keeled over over the w/e :-( Admins not yet awake,
> > so can't tell you what's up. =20
>=20
> No worries, I will just keep using what I have previously fetched.

And they all look good now.

--=20
Cheers,
Stephen Rothwell

--Sig_/PVNl=NbJTltydIWQshEQ=3x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz1MYsACgkQAVBC80lX
0GxQ2gf+MsA9Cz1p3W5VUruP+KpaK324qe/ntfUXjDtOCjOgpLIl8DFk79R869Dc
/4uy0ZCYI8PNCWMhZB4bjtcWQuj/biI9dzHuochdCT2g4We0x/+zpRPmaicxDCHa
NRHd56TZ+EUUUfr+7dinpCW42lHv0hRSEpyyi7IDg0eU7iT95CGFU61m/Hf1nuuN
Mhy6MW8poK3KP9fIFrofepMO/39weWwOH62/uMw1I9QiA6LNEsnZxi3fk6aLhr9g
Xco3trX6NOe541/10yyWVDSPmzIu3pGiB3e6YW9W84/R7B8RPeeQUnJOFfn/aNoS
xYMfxQ48+Pnb1XCK1bFMQ9Aoodurzw==
=Y1hp
-----END PGP SIGNATURE-----

--Sig_/PVNl=NbJTltydIWQshEQ=3x--
