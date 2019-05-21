Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE13C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E252183F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="1bZQI6fP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfEUSX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 14:23:57 -0400
Received: from narfation.org ([79.140.41.39]:36640 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbfEUSX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:23:57 -0400
Received: from sven-edge.localnet (unknown [IPv6:2a00:1ca0:1480:f1fc:85bf:177e:518e:79fd])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id CD5C61100E8;
        Tue, 21 May 2019 20:23:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1558463034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W2EIgYMdthltEjaqH/MSEKz6cj8nobY0doOOED2HHWU=;
        b=1bZQI6fPPnfGSdKwu16x/WZ3xlj9m7K5bxtTN1Ah6QD1XGIf4W16xt5r7Ip76CwYkUAa7d
        F4IEwPX5/FD5Tsphsypk+xQP7QkJSsBbqaKYGKoOjbCDd/nFcE4X4XeLh7069RDJseEznM
        aaVZ0DdHbwq232nuYdP2OIffpMcKJiw=
From:   Sven Eckelmann <sven@narfation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the jc_docs tree
Date:   Tue, 21 May 2019 20:23:48 +0200
Message-ID: <1654747.HbZAs67LzE@sven-edge>
In-Reply-To: <20190521093107.79790d12@lwn.net>
References: <20190521074435.7a277fd6@canb.auug.org.au> <2143236.hFqxAeOdFG@bentobox> <20190521093107.79790d12@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11295293.SPKp92hNlV"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1558463034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W2EIgYMdthltEjaqH/MSEKz6cj8nobY0doOOED2HHWU=;
        b=wtf5bKh03bU6XEWZx6u0GfbM5ULi965ILC3LFX8ctQAALNQyRnq27O/NDHgyne8x2lsCn6
        NGm0NOzThVYcF0TOdmaftxZM+d9uRnyRsvTQYO13VCFIsADo12GX9sHv7102sbkNxYVbta
        cjys9h+mAq0ylqDZ95rYFTC3xrqYXXA=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1558463034; a=rsa-sha256;
        cv=none;
        b=zPkY2jq8vnLu2ockg1+2SitM7g76kPYfkm72TYtvAa3b/hquSTDYptGp19e6KDd+dPqrQf
        R6MOrt63p2GenFPuf/bB4qwukP6SEJqGsBDq7V3Lyul3ijOZ4czUFUh5CTGuFidAlQMde9
        IT+B1T2Wka+nPBQqNTsFpUAGTPolCl0=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart11295293.SPKp92hNlV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 21 May 2019 17:31:07 CEST Jonathan Corbet wrote:
> <sigh>

It is ok, I will never send you any patch again.

> We want those tags to be right.  I'm going to fix this and force-push,
> hopefully nobody will get too made at me...

Kind regards,
	Sven

--nextPart11295293.SPKp92hNlV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzkQjQACgkQXYcKB8Em
e0Yo0hAAqLNzKa1aGFnd2TBKGsYMHRS/rfrMUrKve/oz7HNvl961lHnY8x82+nPY
xvXMH2F3qR+l6eOckz/0WppD7+KyEHfr+0ANmTkfDb6zE7UUCEj2QmSpLNVztQkR
ASlGd4wvTuOBLdIJQsSxMMDmrNxcCumnlN/tJKdPVoChj/gzZXl+fnZIVu6OGbuO
h4JMmZDbLx3R0RT43mq5K8p3elpsOBM9HNzRZWui9IQO9kaObMND3ZjepxRpnnKF
MNNNK3sYyKUxryfXK/mAA5DSVCA+YkhNGHcsngImcQLpvvG73NAq5ys1CfimJJUZ
Cg0fgaYmBRHhQ5PzYg25W4SilfNnv5nU3WIwnc38TPchlNW7IHXJ+jzHwGHwVIfV
pAT/NWHAqkrNDgipKJnD0txE0QMC8hYNjdVC/eSVgHghnTj2oLbDRPSvz9Iejg66
pIse50g87nYYzCBR2Pu7J+AmnkjpOL/9VE04btya0+IMVP7b2aXYEhVrIT3DyXC5
6v/lP9lioVi1oOvBajsgHyC50giaA+hGmIiSxYJekYt5vxatcoPSlAoC6IZBx+0M
hNAeXOATBL6djBfmwQMBw2bKOIaDjerdXg3Hpjmiizg/UyVNB5vOMqN97tjNhRjT
+Yi3KEuz+f0Hc4sRgfrYGXW5Dt78J1mYB5o84NJMxiVtJZymh/I=
=8bgz
-----END PGP SIGNATURE-----

--nextPart11295293.SPKp92hNlV--



