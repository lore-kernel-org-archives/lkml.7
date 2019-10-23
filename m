Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF42CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5342086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571856410;
	bh=VBBJnbXsxrWKlfwaLYXzeFg+QgmD7eayoUqAyOZyLDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OgWojU4Jp4QIPjVKmMfEN5P3zJx1NJV1nuzd1SC9bY+1gwmXohF1Y3QfHEUcb6TnN
	 SrPe+8+r5c4E3zPlVQeYP+CrE/D64lGnXYOQqYq9lfwNkLqNLH/fzw65j77WrD3EGD
	 ujNSRTjlpsSs4YvRsXQIMQI4F2EsSztDukFguLh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390191AbfJWSqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:46:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43358 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJWSqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fLdwq/VvKULq7jt6cG/bIySr1awEyiRVYbUab2xrSZA=; b=HiIyxVYFokpeiHOOH6sZm2QbO
        ltYwsGyJZl8lZVshacALlzLpNLS4to3qynfBXm9qCDyOM0Y0q4aIXnKaTF5oSnZ9WuErzXW/dXXso
        lSomU+hxDaiU4Vx1rprMVvd3E1NmaltvPuY0WZHdoEuNj9vXr8NIFH33QnD6PvFs9NINA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNLeb-00019i-EE; Wed, 23 Oct 2019 18:46:41 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 883192743021; Wed, 23 Oct 2019 19:46:40 +0100 (BST)
Date:   Wed, 23 Oct 2019 19:46:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "ASoC: hdmi-codec: re-introduce mutex locking"
Message-ID: <20191023184640.GN5723@sirena.co.uk>
References: <20191023161203.28955-1-jbrunet@baylibre.com>
 <20191023161203.28955-2-jbrunet@baylibre.com>
 <20191023163716.GI5723@sirena.co.uk>
 <20191023182618.GC25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nb8zVy0QMK3AA1xu"
Content-Disposition: inline
In-Reply-To: <20191023182618.GC25745@shell.armlinux.org.uk>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nb8zVy0QMK3AA1xu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 23, 2019 at 07:26:18PM +0100, Russell King - ARM Linux admin wrote:

> If you look at the git log for reverted commits, the vast majority
> of them follow _this_ style.  From 5.3 back to the start of current
> git history, there are 3665 commits with "Revert" in their subject
> line, 3050 of those start with "Revert" with no subsystem prefix.

That's assuming that all reverts have Revert in their subject line of
course!

> It seems that there are a small number of subsystems that want
> something different, ASoC included.  That will be an ongoing problem,
> people won't remember which want it when the majority don't.

> Maybe the revert format should be standardised in some manner?

My general thought on this is that reverts are commits like any other
and that the documentation for how you're supposed to do commit messages
also applies to them, might be worth a note though as I do see people
not writing a commit log at all for them sometimes.

--nb8zVy0QMK3AA1xu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2woA8ACgkQJNaLcl1U
h9CMiwf9EJdc+RNiYB+xMKLeYHQ2oOUm2OgQDbGEq9GrRjgTFwUdSDrtRMJtqttS
QwsvXxANfiQCYD0g+5A51/WY16SkLF2Vq2+WWAkR44nQpPwqpVFY6Y2/hN8N1Ne9
P2fC+oXsbAe2TFxEtvkojdzp5Vmz7HevYKnTv1cGoi6nx/QKwJ6oFKHFYcae3vD6
Fg4RuSz9txILSbR8v18+YvYf48Y/3+INJYVBnLJbeI+ispLKcVJz2nHjznIqQw19
SsaOw9bIOtxpK4Ah5g5UxIFL0/QiS7pKV2dS/aIb0WkeCTr+deu8WMHiOdXVG6vK
lPwi9F0aVSs73wwXh18mTPvhGdP05w==
=/6rf
-----END PGP SIGNATURE-----

--nb8zVy0QMK3AA1xu--
