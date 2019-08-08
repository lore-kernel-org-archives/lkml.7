Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDA9C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A92F20679
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565292471;
	bh=IA51LJFFQtc9CnnhayGgVXwqpo7oil08WWkmBaObzUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bjnSLzOD3s6s91jChgCR1Fa+RL0PyTugS4vROvQxCt6HQgKbiJkWn17V+hoZzEb/r
	 htTIFlbqHkFfnkOhbrwQKQJkEVUwIQ7vPxvGnRz45miT4f4PDeN20/E1aKxEOMxa9x
	 DlsfFzECyrPmo/6pMHNEUg4QALs1qk/G3S8K8OzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390272AbfHHT1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:27:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60984 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfHHT1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=loQXC1douT+pE3TmAqOFGF87K1GV3m/+5JMD18/HSF0=; b=LEu9JLllOYP8sy6yAvu08FPGc
        Go/ojWDAqu+DptOthMkNG7BVmL/SloDqUb8BJ4haeFBUx2PNGzh/xulrr3SIF8uiETb6VcQwIwyEe
        8OUGQcLy3oHIhwWseE1QRYt5Dl3u1NI63a9hjpt3Dm6TRYMj+6g/rQZd8r4FIixFbFb7c=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvo4e-0003oc-1Q; Thu, 08 Aug 2019 19:27:44 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 404BD2742B42; Thu,  8 Aug 2019 20:27:43 +0100 (BST)
Date:   Thu, 8 Aug 2019 20:27:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz,
        Stefan Agner <stefan.agner@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-core: remove error due to probe deferral
Message-ID: <20190808192743.GL3795@sirena.co.uk>
References: <20190808123655.31520-1-stefan@agner.ch>
 <20190808124437.GD3795@sirena.co.uk>
 <s5hlfw3izhl.wl-tiwai@suse.de>
 <20190808130217.GE3795@sirena.co.uk>
 <s5hftmbiyuc.wl-tiwai@suse.de>
 <cd3fd8b9ce6e4f9820197c70dfc42b67@agner.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1hKfHPzOXWu1rh0v"
Content-Disposition: inline
In-Reply-To: <cd3fd8b9ce6e4f9820197c70dfc42b67@agner.ch>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1hKfHPzOXWu1rh0v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2019 at 03:16:53PM +0200, Stefan Agner wrote:
> On 2019-08-08 15:14, Takashi Iwai wrote:
> > Mark Brown wrote:

> > I guess we can use dev_printk() with the conditional level choice.

> How about use dev_info always? We get a dev_err message from
> soc_init_dai_link in error cases...

> 		ret = soc_init_dai_link(card, dai_link);
> 		if (ret && ret != -EPROBE_DEFER) {
> 			dev_info(card->dev, "ASoC: failed to init link %s: %d\n",
> 				 dai_link->name, ret);
> 		}

Well, if there's adequate error reporting in init_dai_link() it's a bit
different - we can just remove the print entirely regardless of what the
return code is.  The point is to ensure that we don't just silently
fail.  Unfortunately there's no prints in the probe deferral case there
so they need adding, that'll actually improve things though since we can
make it print the name of the thing it's mising which will be useful to
people trying to figure out what's going on (we used to do that but it
got lost in reshufflings).

--1hKfHPzOXWu1rh0v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1Md64ACgkQJNaLcl1U
h9AMagf+L43HuMa/NUgOlEHZm98nUtKAaX8K47V2+fZA8apI3qs/jrwjcUoIfhMU
CZMT7n2i3X520n100poQubrce5JFTbXLd5Mm7H5E77Fs5zoZ5W53jL6ts5DoyQ5E
UYpoxkg4bMQXmSgAlihHpjLRubteVsS3+07FhrSdGlvwlpGYSBrh+IOMtZes3I7W
b7xTa6denXXkrx8sg6tznkI7q6xweTy+B3gc9GpIEA1CQek6a3WYq6DV+1C+t8dN
Ps0f2A39s+UVOaHpPgtwb9V3DwlBGnUis0vdrET8JpfK7whAEaw1D58ADRW77QiS
o6jc4CTInKtvwwipe0OcMO4Dn9jssQ==
=mPEe
-----END PGP SIGNATURE-----

--1hKfHPzOXWu1rh0v--
