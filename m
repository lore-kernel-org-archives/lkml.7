Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BACC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CA420818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555058793;
	bh=mMNLN7Ct0KwUECG53d13jFytVmW0ABeVGHPjSIf99Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T3HdBfW0kRm1cE/7JirSQ48lTpKqvJJj3gIH7W3euvePyVYgseuA2pB6ncQy4LcAX
	 HPS/8Lg6BFU/7r+ABjzAVCgXpmklVOczOO7K5kyqXiKNKI6JVM2XTaVZ0libvZSDdt
	 La4yBUyN89xfjWXuWyQg+BEY0YM5Hzw6z3F/t8f8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfDLIqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:46:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56826 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDLIqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fwd4YXXSl17eSk7OcyfRz6PLIlFDaGxUZ/hwkoypEUU=; b=pbeCVRbRH4rndVsCUvjfmOSS5
        n6tLTDu3L0B4YLVjdza+6SAT31f+yhI9eVA9Zn0ZxfNpUPQirQ+zY5VA/1PuK8NO8HLnWAFTOMqTl
        /ocW1Beo0tDjeGzxdNBxuUqoNUY5zki2cUFzIgEUIi/NAEwLVDxk7Jd/H/Bjv9uQi1ND0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hErpB-00067m-LD; Fri, 12 Apr 2019 08:46:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D84711127945; Fri, 12 Apr 2019 09:46:16 +0100 (BST)
Date:   Fri, 12 Apr 2019 09:46:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] regmap: soundwire: fix Kconfig select/depend issue
Message-ID: <20190412084616.GC6909@sirena.org.uk>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
 <20190411192814.10663-2-pierre-louis.bossart@linux.intel.com>
 <s5ho95bpqis.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <s5ho95bpqis.wl-tiwai@suse.de>
X-Cookie: Your present plans will be successful.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2019 at 10:38:19AM +0200, Takashi Iwai wrote:
> Pierre-Louis Bossart wrote:

> > config REGMAP_SOUNDWIRE
> >        depends on SOUNDWIRE
> >        select SOUNDWIRE_BUS

> To be noted, in general you can't do put both depends-on and select.
> The select always wins.  So the depends-on in REGMAP_SOUNDWIRE is more
> or less moot.

To be clear the issue is that the dependencies of selected symbols just
get ignored (IIRC their selects too).  It can be useful for
documentation but it does get a bit confusing sometimes.

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywUFgACgkQJNaLcl1U
h9BhBAf/Vz9R/jt81fkpRirW2SlRm2rHMFwV/hX24VjBGcUokQpxGIJ3RzKH0KBw
YaNjW312cdqR6kQXEEbLdojwUvqZ+Wsnm1w6AG6IqSa83UctFNj0rsyyRjbeEBpE
WYxe16pFGohXUmjVEQI5Q3dJsq/khsZII1i3SUHLE7k6TTUBhlIWz8RM1LlhBOQ/
h49w8UEcWxv+SI+eI4Z8u1FuJvl7WoHU0AWf0B/bCO8+XOBOi8ccEhFxrGKzvXSU
Wq0F+10JVNATJMsidR/6yVGW2ckIWmAJPDszKw9eQpJ9+MVjNUXI72/2UZQJtQ+R
7uCLTGEpZcBKyU6phoR68LfKpDjOKA==
=yo9F
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
