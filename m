Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D88DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF30214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573577973;
	bh=0oFanHzvRKjHtSffMmTBvtzgldwVkwNTRsjU7YGLOJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pcaKsrrrc/sXOs9kOA3WK6pG/Iy65Hk9fBhv9fofa87JoOmmERtdb9gXyyF26zTNb
	 I07FeywCFzo1sotNtiteKvHef2fhDBBhatAnDKMd/SJYNq6sh98mu+c/v0Wi7miipT
	 +cuqzgKcAWushhxKNFjbdg6ncJoHdNa5h8Tb+7Mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfKLQ7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:59:32 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39170 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfKLQ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0oFanHzvRKjHtSffMmTBvtzgldwVkwNTRsjU7YGLOJo=; b=jHKdcLx0GiMlDV/Rekrrc7/2L
        kNwJCF4PhwI6JqS4K0PSmP1cs6+zoC3L3mP6AVvNdaku45Lo2bZSggel/I/Y8nsjs2FAkI6zrtON/
        yw+tMxnc0m0joDHNC6rrdRMv4CGzziLNxWU9OIqWzV0yA+Z/4AuhxCVYtYEuVCBjNdrf4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iUZVC-0008Gh-TW; Tue, 12 Nov 2019 16:58:50 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 44080274299F; Tue, 12 Nov 2019 16:58:50 +0000 (GMT)
Date:   Tue, 12 Nov 2019 16:58:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCHv1 1/5] ASoC: da7213: Add regulator support
Message-ID: <20191112165850.GE5195@sirena.co.uk>
References: <20191108174843.11227-1-sebastian.reichel@collabora.com>
 <20191108174843.11227-2-sebastian.reichel@collabora.com>
 <AM5PR1001MB09942731970692EE42BE9CB180740@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191112152411.d626b34wmvkzpqjf@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Uwl7UQhJk99r8jnw"
Content-Disposition: inline
In-Reply-To: <20191112152411.d626b34wmvkzpqjf@earth.universe>
X-Cookie: As famous as the unknown soldier.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 12, 2019 at 04:24:11PM +0100, Sebastian Reichel wrote:
> On Mon, Nov 11, 2019 at 02:07:46PM +0000, Adam Thomson wrote:

> > Having spoken with our HW team, this will cause a POR in the device so we can't
> > just enable/disable VDD_A supply. Needs to present at all times. How are you
> > verifying this?

> Ok. The system, that I used for testing shared a regulator
> for VDDIO and VDDA. I suppose this needs to be moved next
> to enabling VDDIO then.

regulator_bulk_enable() might be handy here.

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3K5MkACgkQJNaLcl1U
h9C6TwgAhsGHpb6UsZh0hRdSvQrMRjsrI6Ehz5Ij8M6Ngr2O6RoBOD7dVHLHm5xh
YOj1zRVI3ytgajOb4UkFgMXiMTAk00lvTninl/JPtR46HAZ/M3RUhwFcUByz6iZb
AHzSsNM56dO6rrwhmIlcO2cpQP15pP+ctCsWtgL+1HK3937f54d5LuaFyiP4EZRz
KVBPTfKWBdhOH1j/KzQWrttlhfkKZJYfy8T1lJRxQC2AT4RSME99g1gAEp9B/ING
bz8TrjkcW/3fzbU1FawD5AV5vcbiTiNkVapVh75sHcunN44xug13jf+BHgCwYmYo
wVDuoCE212CxXnb5oB+7AEiEruIbVg==
=igeR
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--
