Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF00C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B303206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553000179;
	bh=P6156dEmowZcJ/RinJKVjsPNACHK6/meCp3qLly6MAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EcZRZ68l6Jzw7EFrAcQy6Q89+gRze8LEJculFp7dVZAre70s0sKdfpT9heyIi50uW
	 IfHYgKU2kphpUMqFNtlF8VDm4GE9ewkKDZThelUFpFt3aVeOIUDtiagsr4SmBnOvrE
	 g3Ev5y7oqy/booUevd252X3rMhO5hyuKSias+Kjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfCSM4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:56:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47634 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfCSM4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q26EjlD7Wy208S90jcgbS4ne2mCBxWg6maHCdNF8gTY=; b=j5oGCflQ+vqUU+DjY6odPSlaQ
        3mFpC60EOZWR8sZcQzML6RnG3UtMbpETzHUxGzksuIoQokMl0Oupg9/bGvgTJJErnkcrhSfgLZYIq
        Jwl3YztR0gwnPxgB6D48bTSGlp6GN4pGIbjiYl+9UV0GSsskR7UODzHK3vab9evP9r5h4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6EHs-0002vY-VG; Tue, 19 Mar 2019 12:56:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4A74011288DF; Tue, 19 Mar 2019 12:56:12 +0000 (GMT)
Date:   Tue, 19 Mar 2019 12:56:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 2/4] regulator: da9063: convert header to SPDX
Message-ID: <20190319125612.GB5514@sirena.org.uk>
References: <20190318155728.28365-1-wsa+renesas@sang-engineering.com>
 <20190318155728.28365-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <20190318155728.28365-3-wsa+renesas@sang-engineering.com>
X-Cookie: PURGE COMPLETE.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2019 at 04:57:25PM +0100, Wolfram Sang wrote:

> index 2b0c7a85306a..42dca1cac077 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -1,4 +1,4 @@
> -
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Regulator driver for DA9063 PMIC series
>   *

Please make the entire comment block C++ so this looks more intentional.

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyQ5usACgkQJNaLcl1U
h9CydQf/bssh015KU/rpuL/w3Lt88S7AU3JW8/haq6SjnAv5RfvJq+0+6trekuxr
SqUvXyKcv2wdXyL1Gx/vWnA8M2x4laIIavo939IqhRy3lS6pa8Omz6JvdpLgaxBq
rfH0U7D2fbT56mJpz6F6Q/OkEbCpyrXYSyYGLu5J6x9ueNHwvuUQ4e7bLj+i0aB8
QA8f0Bw1309gVIZLHp9gzguSC2KSDYf9RYdpKKPcPg89FwBBvr4RN/J4OAOPkaHG
QkMapP/KQQ6ggtN6bupiFd+IedvjXpKLWoFdr1Q7hb4Gaz1sdI4ZJQujIoS9djQK
GV74kkDe+gZq5zzEcUSm/xXRvXiP5Q==
=LKqb
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
