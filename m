Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E948C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF64D20881
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556385487;
	bh=9Ni2YRPbf4GMMunOYWIHYcrCRiFTp5FPuVt13sVOpXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IZ3YPJa347IwFgQgzmb1PIXijezcB+Jhk6K+2TqrC0zPg2BmzqS4arvMe35sUfzpg
	 oNns7nufyTHjhVk9F3iXUImvpqznEqCimGE02/Iq4218rHusIHNa/9bxNCbwTz/Mdb
	 rxRHqvgNRkshDA6mDrzpsDv59zmlTeA22mk0cx58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfD0RSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 13:18:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40378 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0RSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 13:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9Ni2YRPbf4GMMunOYWIHYcrCRiFTp5FPuVt13sVOpXA=; b=daPx8YikwrUepaPWMqT4aN8tI
        SsXhwvgRFVOFZwsMtbroir3Z3uFn2W3wa/io6Npseaelpj5R4Sx10dcqtBSDhLWea/OenRSOJzpt+
        LmrSZnN7aIPhLKz5XY+Vdel7xQqa5tYtZR53RQatBvM5tjlZURKGKY3nLlR4iVaDcDDZQ=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hKQxS-0004YI-UN; Sat, 27 Apr 2019 17:17:51 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1E81C441D3B; Sat, 27 Apr 2019 18:17:46 +0100 (BST)
Date:   Sat, 27 Apr 2019 18:17:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/3 v2] ASoC: fsl_sai: Add support for runtime pm
Message-ID: <20190427171746.GG14916@sirena.org.uk>
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
 <20190421193853.10188-3-daniel.baluta@nxp.com>
 <20190426100025.GD14916@sirena.org.uk>
 <CAEnQRZCPPr1iHvKEj=fOsE8A2iW=XZd=CaoFqAoUqJftg4pN9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p7qwJlK53pWzbayA"
Content-Disposition: inline
In-Reply-To: <CAEnQRZCPPr1iHvKEj=fOsE8A2iW=XZd=CaoFqAoUqJftg4pN9Q@mail.gmail.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p7qwJlK53pWzbayA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 26, 2019 at 03:10:10PM +0300, Daniel Baluta wrote:

> The only patch left in the series that needs to be applied is this:

> https://www.spinics.net/lists/alsa-devel/msg89733.html

> I will reply also to that email, to be easier for you to find it.

Content free pings don't help...

--p7qwJlK53pWzbayA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzEjrkACgkQJNaLcl1U
h9AWVwf+KSlrvfBfUuZMLNHSHD7WREpZgHjLFsCPB8QHrdYC2CjypGjl9cjkYFDL
zvVk9IotX8UodiLJN5KwgU9eO38JRbxXR+oVTN4+HnRIJv690m8LztYI9tAcqGIp
2BvosaU2xv5RTitkpD8v3rykVDyAvDNvYDWK6gj8/Mz4UHi68onYaKMmoDNTnTKC
9jAwU6oCeivjDydZIzMbyoQb1lUBpeHXHZrTn4e8iar9AfOEGEoR8QEhD+7D5k01
y/t2YU6KD1U9YlHUK+FEfUeXLAMslI4284MVKw960xesrxvOcSltnQozVvR/tESL
a+JaBF7FAsQc29UsdOCjSKKubkfKQw==
=phjH
-----END PGP SIGNATURE-----

--p7qwJlK53pWzbayA--
