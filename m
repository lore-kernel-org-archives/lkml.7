Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DE2C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4C820B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560878100;
	bh=AdqmnS+jSpXufXG/3VyMe7oXq2Nu3sE27Csk/wuPMmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KSPBcXUbtU6ogkPpHDRumPdXrTzHvK2lCe6s4Dpyv4dkF84fy/MxIw5PoYzBaxQhC
	 HGrS99IaPHlG8mfabIBA+G3FhvGSMAcA2ByUEL6tcI9qtkY7EvtSN/dm8mhkn7bELn
	 pX0zNXlSclo28UNxT7yu8mu9FUG/iPvInqtyPqak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfFRRO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:14:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56688 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfFRRO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AdqmnS+jSpXufXG/3VyMe7oXq2Nu3sE27Csk/wuPMmo=; b=vzHqAUcrGvyva+Zzs0Ak9hl0Q
        BNC3mnAzNrkLx7pN8lWManuEj9IIkjgOla9PZEROf99WTOwnQp2LUzqJkH+8aReTf8A4nD9nTd/PY
        TP7X+SCxKsD66mx7O/iWWTBbR9KW0Elo/ZyczZ+/Ntht/hRi+kCnqULszXYpz1MzwJGRY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdHh8-0005Fb-Am; Tue, 18 Jun 2019 17:14:54 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id B1519440046; Tue, 18 Jun 2019 18:14:53 +0100 (BST)
Date:   Tue, 18 Jun 2019 18:14:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] soc/tegra: regulators: Add regulators coupler for
 Tegra20
Message-ID: <20190618171453.GO5316@sirena.org.uk>
References: <20190603235904.19097-1-digetx@gmail.com>
 <20190603235904.19097-8-digetx@gmail.com>
 <20190617154632.GB5316@sirena.org.uk>
 <2308e5da-a8fd-a0e6-f98c-0931a30baf14@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e890kymSckUvwzhr"
Content-Disposition: inline
In-Reply-To: <2308e5da-a8fd-a0e6-f98c-0931a30baf14@gmail.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e890kymSckUvwzhr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 07:52:06PM +0300, Dmitry Osipenko wrote:
> 17.06.2019 18:46, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/*
> >> + * Voltage regulators coupling resolver for NVIDIA Tegra20
> >> + *
> >> + * Copyright (C) 2019 GRATE-DRIVER project

> > Please make the entire comment a C++ one so things look more
> > intentional.

> This is actually a correct SPDX comment style for the source files, accor=
dingly to
> checkpatch. While the C++ style should be used for header files only. I'm=
 not
> following the SPDX effort much, don't know from where these SPDX-style ru=
les are
> coming from.

The SPDX bit is fine, what I'm saying is make the rest of the comment
also be a C++ comment.

--e890kymSckUvwzhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0JHAwACgkQJNaLcl1U
h9Adkgf7BRUN7vDJiY8PukrNZjKDCtqOwtshsNBH1cFOzUQKpciz9amzrYfVfsc/
6ov8uf5yZSf9hI5bDdTc50dUt0/OgO9GzicotrEEFigksUYoiXRGdSxw3KdbUZt/
oUlj1kMfYyPuMJAlfjhUENenMFLjdy+cVMh3eLInBpAgb05vqVA5iVQe7TIhhEoG
SnEYnQhnoYhlfWW5QedRHVJqT2Q2plD1D1etkNDJ8mLnkthpp41qltl3CCWQB7Du
8PyUAEdj2c2ghozukM/G462I9un6VMh+umO3j49Ub9bhc/aZMI0XE1v/y+G7EI3G
R02wzbvVGiTHnJxbj4Tpf/W4wwFAdQ==
=Dc/q
-----END PGP SIGNATURE-----

--e890kymSckUvwzhr--
