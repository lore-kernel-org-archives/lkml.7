Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE9CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF2220818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555078747;
	bh=rIqpxox270vB4irOUPphUCXCbNpDS9NyZi9ONdE2qoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MIWln4UlVN1JYwPNYE1Yr0+Dj6RG02a5dUCVn5Kqou4Gh5ByQ2U9top4LDQXiRR9V
	 bKHbpqyKVJaNWKmm5f9rXNKf+yDT67UU82k3XcmbTxANfJTVOvmFzfju/RI3eA/F4W
	 DHxtpcYPDV1jkuf1es2ilG3/Ku450hGuQrxyq8Rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfDLOTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:19:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50412 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLOTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jY4ZPXuoo7mLQlAbp/JAW0VgZNxJo2xO2I///BNysD8=; b=KyVR7/ScZgKul/c20Gqs9jzFI
        KurJ5Tj/WtU20qUTYN+tIOYPPzy5z9qmF0DdUkF3aa3EwiPdWsWm4g7xBptKKSD7ZL0j6fFldliSx
        om1fZNffybmTw4b7mYSE0uUbolKF0UjWV9xHuiEyDoURhUor12lCRTxKmE2iCS5zZIbFk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEx0x-00072Y-DP; Fri, 12 Apr 2019 14:18:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 19CDE1121A6C; Fri, 12 Apr 2019 15:18:41 +0100 (BST)
Date:   Fri, 12 Apr 2019 15:18:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com,
        jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [alsa-devel] [PATCH 1/2] regmap: soundwire: fix Kconfig
 select/depend issue
Message-ID: <20190412141841.GA6235@sirena.org.uk>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
 <20190411192814.10663-2-pierre-louis.bossart@linux.intel.com>
 <s5ho95bpqis.wl-tiwai@suse.de>
 <bd9a5c75-8519-b6ac-ca16-7fa93c706ead@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <bd9a5c75-8519-b6ac-ca16-7fa93c706ead@linux.intel.com>
X-Cookie: You dialed 5483.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2019 at 09:07:41AM -0500, Pierre-Louis Bossart wrote:

>  config CODEC_XYX_SDW
> 	 tristate "XYZ SDW Codec"
>          depends on SOUNDWIRE
>          select REGMAP_SOUNDWIRE

That looks good.

>  config REGMAP_SOUNDWIRE
>          select SOUNDWIRE_BUS

> it'd follow the typical pattern seen in sound/soc/codecs/Kconfig:

IIRC the select here won't actually do anything.

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywnkAACgkQJNaLcl1U
h9A7BAf/ZQPvLJvY2riHokRX7TsbOrjabKTlSnHcIylInSlPNaDWMb4onD5Mo3Ma
C7OFe1IN/Xrxtd8xj4Z54s286Irimk+KwJGVYNjUuNP4ekEzcLmVe+UN6TzCaelg
dlB8d7i0lGGTc8LVXgto+Rf8CzoejfbmbGPjzynsIbiqZZ/eljacwAkuxMD8IPZn
g32rsw3f/vzhOr3frnTfTe9SvZp3qiKMPRtRYHofXYp8xoOa+hU1jwHmF6bZ2D+O
p6uaBh1SeVt5VtqThNWGvFUHB+QZfqGV86C4T6OkaPWpEK6F58ANWao93izGPlz4
nwO1+67/EJ2bQzGNPAVJOcc0MjOsaw==
=Uu1+
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
