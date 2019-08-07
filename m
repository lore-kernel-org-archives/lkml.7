Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59E4C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 19:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B914421BF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 19:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565204974;
	bh=CXHaHEJXstFHVGXsaMRkGDgj2vzdFlugILr5Qa0FLNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JcI7Q7ObKueo5286Nt4hEsiK2GMaX+ficufXoYWxhIhFFFgazGPQ8J8Fc/p/k0LBr
	 Cxgzga5vJti5bWq08UrhbWVna83E2uG/g5+8YbpP4mmcuNN4jL9Cf//YAPO2hdvC80
	 X1DrfalfU2ubeZ4mbsm+AUcvJu8TizIwCgCgm1A0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389417AbfHGTJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:09:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39364 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbfHGTJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 15:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CXHaHEJXstFHVGXsaMRkGDgj2vzdFlugILr5Qa0FLNM=; b=ikBpsz+qWT62Q1D/1GPoL/kBv
        /aykvlnfnzRjcqSuohssVwp4Qh9gS6S8wxtZVHM6ny9J/rLDJ4sIJpY9iCdLOKAwKlShFLH7WMXB2
        qplis3TX0xH5vE9FSG03bESDuZdGb53FpxKbMjtUJH4Jv8qKWBnsDnPQTP5lojTBEHBHQ=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvRJH-0008SR-7z; Wed, 07 Aug 2019 19:09:19 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 9D0AB2742B9E; Wed,  7 Aug 2019 20:09:17 +0100 (BST)
Date:   Wed, 7 Aug 2019 20:09:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        jank@cadence.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH] soundwire: fix regmap dependencies and
 align with other serial links
Message-ID: <20190807190917.GL4048@sirena.co.uk>
References: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
 <CAJZ5v0g5Hk9JYLvRXfLk5-o=n_RVPKtWD=QONpiimCWyQOFELQ@mail.gmail.com>
 <52a2cb0c-92a6-59d5-72da-832edd6481f3@linux.intel.com>
 <20190807175646.GK4048@sirena.co.uk>
 <5a7473a2-83c0-1a09-0cab-31fcc5b21302@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m+jEI8cDoTn6Mu9E"
Content-Disposition: inline
In-Reply-To: <5a7473a2-83c0-1a09-0cab-31fcc5b21302@linux.intel.com>
X-Cookie: Dammit Jim, I'm an actor, not a doctor.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m+jEI8cDoTn6Mu9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2019 at 01:17:20PM -0500, Pierre-Louis Bossart wrote:

> I don't have the knowledge or means to test what I suggested initially for
> the other buses, and the optimization was minimal anyways, so this patch
> takes the path of least resistance and aligns with others.

> if there are no objections it's probably easier to push this patch through
> the SoundWire tree, with the relevant Acks.

Makes sense I think

Acked-by: Mark Brown <broonie@kernel.org>

--m+jEI8cDoTn6Mu9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1LIdwACgkQJNaLcl1U
h9DFBQf+KQtyCfkxOfIv1rEOZ7sfj9ypg/0DsSRjVwhmqS8DoTwcpPwzJlVJFRs1
1Qg9wUYGxMpwhkiYJ66KhJs7Ugtb1XYdGiYzvhjAbxsB9YZ3z1kCK+h91jkMXxS+
4DX6U8/hLEqR4DpwnBYTo91TAJnJi3Bj/xp8qsViOsacjECpiZG11E9FmYTSPUFi
pKgyVB7nWj0kpL7aaEyweJJcSwrF7Fy7/+1KLgpVmewCepH1BooSaJI6ymEEz6+P
RAAKwUwDIksuajG5KVJduJf0BsSTZ2GFLE3pomj8o+OuMMABvnzmwbYofQmWHu2n
0/p+EPuDpS7b+n4obTY1DL0audj1HA==
=Ercr
-----END PGP SIGNATURE-----

--m+jEI8cDoTn6Mu9E--
