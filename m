Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616B2C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D576207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575908708;
	bh=ZS5XZN4gCPFyQzgcuSL43cOoMrs2/8mWFHRjg5bqDtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f13ET2/iT8msanDQacUdoDzvRKKxRodvG19Cegrmfd0P3y/8d5q2NBfCmfmCOuuaA
	 tQc0EYgf5GX1N0UP54Ih0IwapeCWizhsP5MtvyM8X0UM0Yj+aWXh5MmLSP7fA+bcBJ
	 oj61dXT2n5Xrv3Kaggl+xUmQPJziXZ4u/4shbyC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfLIQZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:25:07 -0500
Received: from foss.arm.com ([217.140.110.172]:37526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfLIQZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:25:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 627321FB;
        Mon,  9 Dec 2019 08:25:06 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D73783F718;
        Mon,  9 Dec 2019 08:25:05 -0800 (PST)
Date:   Mon, 9 Dec 2019 16:25:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tas2552: add missed regulator_bulk_disable in
 remove
Message-ID: <20191209162504.GE5483@sirena.org.uk>
References: <20191206075239.18125-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Content-Disposition: inline
In-Reply-To: <20191206075239.18125-1-hslester96@gmail.com>
X-Cookie: We read to say that we have read.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 06, 2019 at 03:52:39PM +0800, Chuhong Yuan wrote:
> The driver forgets to call regulator_bulk_disable() in remove like that
> in probe failure.
> Add the missed call to fix it.

Another runtime PM interaction here.

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3udV8ACgkQJNaLcl1U
h9C0oAf7Bcr/KwDFz16ZGoRZQwalSCIYDkriphNjueah8hpKRCYaRMf4czOgFyiS
U7qICXScZ/vId7Fo6DYTIXtGVJKWAwMwiOC7nK2ZXdXZx8WMEhjb2KTyKX7Xnu2c
VcPJtml9iR0uzb9VZKUO3tOMTRXCDmhtVV/DwYQljgCEuL+cn77eMBIUkqFDieRM
rYP8Lvuxcrr8nyLXFs4MUupBTJoyRyTTyy4ShyXWndSL/ZbcfihvJbMCF3d0wTe1
PTKK/rjPqtCpkve3ogT+niLty0w1LVyWA8XglaNtHsN48n/nRjEPjUOciJISsobK
CLvOieHHXYcbemR9R044Yt/7k0qKZg==
=gdxw
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--
