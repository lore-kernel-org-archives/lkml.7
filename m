Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DC2C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F114204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561552059;
	bh=DvpFXGkn8D3TAMVnH/XfK8pie9+euDypEwPPovS+cDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Gzntt1Brf146TVBNeDxd2qghwTXrbV9amnK3dnE00sou+wnZubOjsM4ycXsy7wQ7
	 Gzd75lNAv3HkbvZCrRpH7DlGRk/u9tzZtW7I3nQkyO4gPVJwoQ3zlLu6rueFZ8x27Y
	 2C/pEa7SYM9PHD04hSRKIR19VROFk/pm+EDKYy2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfFZM1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:27:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60516 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZM1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DvpFXGkn8D3TAMVnH/XfK8pie9+euDypEwPPovS+cDY=; b=WnOodiXsfD4fyL9Z5NzzOmO6b
        PshG1mD2SemWwT82Ewq0+W5sgLfgnN/7Wy2xLYIvLDJDTAOA7P6ilpPmInXPb6zKSPKJh7Km4YNhI
        c3mLQ4o36WI78rn3nKWKeBgqIxNUrHaHrWPGkunEuBsb4IXfVtTpLBkX0U4MiJDuloDRc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hg70f-0007qs-Sb; Wed, 26 Jun 2019 12:26:45 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 1ABC1440046; Wed, 26 Jun 2019 13:26:44 +0100 (BST)
Date:   Wed, 26 Jun 2019 13:26:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/11] ASoC: Intel: Skylake: Remove static table index
 when parsing topology
Message-ID: <20190626122644.GD5316@sirena.org.uk>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
 <20190617113644.25621-6-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="on+I5Kkc+zqLv55g"
Content-Disposition: inline
In-Reply-To: <20190617113644.25621-6-amadeuszx.slawinski@linux.intel.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--on+I5Kkc+zqLv55g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 01:36:38PM +0200, Amadeusz S=C5=82awi=C5=84ski wrot=
e:
> Currently when we remove and reload driver we use previous ref_count
> value to start iterating over skl->modules which leads to out of table
> access. To fix this just inline the function and calculate indexes
> everytime we parse UUID token.

This doesn't apply against current code, please check and resend.

--on+I5Kkc+zqLv55g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0TZIQACgkQJNaLcl1U
h9CIkAf/XqlWXek/c2A2wcZGYAvrtlTTQ8sZ/0UuXaQmIjtdEo1DyARVUHh+Qssv
Fl4RPsk4Bs9kkVhKIpoBbIzonFCi37z9HmzixNEUG8ohCZZ4T5KP4zM/nkhXkrjC
dv/CrAIRGAL252YrJEaZHjHs15sKRP3vIKB2gdrgIQbDS/7CbQSo4e8kPc4gFzWp
iL14YeiHxQxadR9Vx3YkF5c0ArkbsCgHeUQB66a51ENNA9d4dA4J/kZHKczYawv6
lYiqS2cjv+e8KT1CgtPHEaTchKTOfsoxxDahf7uwzxg+MieeSyf8Q8e6YQVX5ZL5
qLrUTgT38tJxoRIHV1vLTaGIJ1it3w==
=H7fM
-----END PGP SIGNATURE-----

--on+I5Kkc+zqLv55g--
