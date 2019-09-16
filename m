Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01BAC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CF1214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568673126;
	bh=jB/TgHX0/r76X4MZvHSADWtxbouIxhGXGon83l1oFTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XqUDMEDeS1tCXF1cqU3x9g1LRH0u6aFUlHw+k0T4Z4E48P3f78muiH71X0bxkitk0
	 C/is14vxJddNxxh6VjpmyDIxdyWWwbUMol0gxfdG37SS1xScuVee9ywdbaLh5NVN/U
	 vgfVI19ZqNUpxCHrMBwAA978dk+5nFchSaSY9xJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfIPWcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 18:32:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40384 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbfIPWcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 18:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=msLh9WbxBA7EbuXEsQM1F8/XWc+BFLvXBH9jc3Uggd8=; b=VMCIikLP6xHgM6dCFwKl27qn8
        YLLMuBCGHFk9swkyMK8zSODwb1q9D8ICqjyXcVs4Jy1XBKsDoHliZbNaUz+v8tdyg2559+9xS72OF
        tGyVs6Y0c4ValEGmSU4hWUzrC2bAbhslN2DJMDJDvIBKfJTuzTlcvXhHJaMRzh9YRLgJo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9zXF-0005vZ-9X; Mon, 16 Sep 2019 22:31:53 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 813572741A12; Mon, 16 Sep 2019 23:31:52 +0100 (BST)
Date:   Mon, 16 Sep 2019 23:31:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Austin Kim <austindh.kim@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Roman.Li@amd.com,
        amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: Fix compile error due to 'endif' missing
Message-ID: <20190916223152.GO4352@sirena.co.uk>
References: <20190916044651.GA72121@LGEARND20B15>
 <CAK7LNARZMr5ZKGufi63GZrZ45k60faAiXr4mBB_mU9h_QifjxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dBmMfAlnUmK8h9+K"
Content-Disposition: inline
In-Reply-To: <CAK7LNARZMr5ZKGufi63GZrZ45k60faAiXr4mBB_mU9h_QifjxQ@mail.gmail.com>
X-Cookie: Man and wife make one fool.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dBmMfAlnUmK8h9+K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2019 at 02:46:48AM +0900, Masahiro Yamada wrote:
> On Mon, Sep 16, 2019 at 1:46 PM Austin Kim <austindh.kim@gmail.com> wrote:

> > gcc throws compile error with below message:

> GNU Make throws ...

Xinpeng Liu via Nick Desaulniers sent a description of the problem and a
patch so I think I'll be able to fix this.  However...

> This is probably a merge mistake in linux-next.

> If so, this should be directly fixed in the linux-next.

> If it is not fixed in time,
> please inform Linus to *not* follow the linux-next.

...as I said before I think you definitely need to coordinate with the
DRM people - Nick Desaulniers' patch 0f0727d971f6f (drm/amd/display:
readd -msse2 to prevent Clang from emitting libcalls to undefined SW FP
routines) breaks in places that don't have merge conflicts due to this
change.  I wouldn't rely on the merge going well if things are sent
as-is, the only reason this one showed up was that other people were
adding new files to the Makefile.

I've CCed Nick.

--dBmMfAlnUmK8h9+K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2ADVcACgkQJNaLcl1U
h9CpTAf/WVlKZHB2Ctr3ilkr7vpfMjEg59XRGkehdnNZnbqDxT4ydz27T7yuIHCw
mtoSmDyKi0sUOxW3Jj09CRuMhmbu56hfaNodbB6Mf2fj7InHXHbJ+32kxgHg5wlS
QIPMHLqU9w7wvidN6Ry6d6sinfokqcaiZVbmp0Q7sGcEb4CpVUGK64zuS2thwjSO
7WdhJ55MC6yV2co4FYS8yp0hSFeSnudaMG1/n7yniVUKpRkCF/F0r+XdS0i/kfrf
uE7cqXSfgk/DqnwscbZwuiFo0QcPuUfAuc7nJRrJkIXxQjAacepligIXioedCkQ1
PK7Hsf/bRVBAE+piKlcp1DJe6TcPaw==
=valx
-----END PGP SIGNATURE-----

--dBmMfAlnUmK8h9+K--
