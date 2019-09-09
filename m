Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5F1C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2102086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568038568;
	bh=WRjZ44Y2X+VtFPk/w2hbQJ56D207xXfEQntjZgZQyrw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Hi5XF3KOPl6PI4aA9LRAKXdjXix4GRpXbzm+yi262wDP6OGXLavDOhTW4WrD/C5xp
	 8YekjWrRyAEpv/YxLFFVxGGYeOLgMq3+cAqQs2RiEjhepn5QPTpKXVLFh7QQgaxTNy
	 e1F7dpGKa04ZjOqyRkeeCv0/2ajqc9CRcmQMlNHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405353AbfIIOQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:16:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50694 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404997AbfIIOQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ncaGoyv9geFRKOoOCYmfj/M2T7iV6dkN+y33439/hIE=; b=wPCUkQLmKHZEibVvCCogQ5ua/
        28sxrmbrMOEjq25ltxakLx0wcOjCLOIbQv0EwU5Bz2Sjhx7taIVMNPpVNjN3LNVLCw5jSNPBXGxZg
        d+/l/j/gpp0Jx/NS04IQD/JNbesEGaJCgp2FDdIHW63E+pG/Xjy6wk5fq5hO19LiBbES4=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7KSb-0002cw-1E; Mon, 09 Sep 2019 14:16:05 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 69799D02D3E; Mon,  9 Sep 2019 15:16:04 +0100 (BST)
Date:   Mon, 9 Sep 2019 15:16:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator fixes for 5.3
Message-ID: <20190909141604.GI2036@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="itqfrb9Qq3wY07cp"
Content-Disposition: inline
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--itqfrb9Qq3wY07cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 811ba489fa524ec634933cdf83aaf6c007a4c004:

  regulator: of: Add of_node_put() before return in function (2019-08-01 14:07:46 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.3-rc8

for you to fetch changes up to 3829100a63724f6dbf264b2a7f06e7f638ed952d:

  regulator: twl: voltage lists for vdd1/2 on twl4030 (2019-08-15 15:08:41 +0100)

----------------------------------------------------------------
regulator: Fixes for v5.3

This is obviouly very late, containing three small and simple
driver specific fixes.  The main one is the TWL fix, this fixes
issues with cpufreq on the PMICs used with BeagleBoard generation
OMAP SoCs which had been broken due to changes in the generic OPP
code exposing a bug in the regulator driver for these devices
causing them to think that OPPs weren't supported on the system.

Sorry about sending this so late, I hadn't registered that the
TWL issue manifested in cpufreq.

----------------------------------------------------------------

Andreas Kemnade (1):
      regulator: twl: voltage lists for vdd1/2 on twl4030

Dan Carpenter (1):
      regulator: slg51000: Fix a couple NULL vs IS_ERR() checks

Raag Jadav (1):
      regulator: act8945a-regulator: fix ldo register addresses in set_mode hook

 drivers/regulator/act8945a-regulator.c |  8 ++++----
 drivers/regulator/slg51000-regulator.c |  4 ++--
 drivers/regulator/twl-regulator.c      | 23 ++++++++++++++++++++---
 3 files changed, 26 insertions(+), 9 deletions(-)

--itqfrb9Qq3wY07cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl12XqMACgkQJNaLcl1U
h9DCigf/enqBxwYXqqvNW3drvpkZj8//pHANeq7uF4YzzNiuucfocWV8BPP4ZOV0
E6/8ike5h91/Hv9Zr/Ls2QxIDHmpUv/Eoj5GCiiz0nr5E2kvLXzfFbk7YUWwAwbg
Xj1qN3DsfIRUuV2V3TmYk5WHNBFkARepDbf9W9Qc1nSFjwntg7VeKNoG05V+lCkJ
uAJTOFjEAnGNXxGIpTYb9qjLP8NsyqYGFjDn7U14IJ+x2jW63hlaXXke2iWK/F0D
/sUikORUY+8iEN72vFrXjOa6uLYL7qXcuNGgFCBPPJGGE0a56pAEqbI1vwtsqX1d
jv91sQCzGkt8HvbX2oJfcP98PTbg+w==
=Utx9
-----END PGP SIGNATURE-----

--itqfrb9Qq3wY07cp--
