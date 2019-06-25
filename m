Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8374BC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5605E214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561461593;
	bh=ZSXGLNGUEXL/zZcr48QzRi69McLZKGv7hjKhzIZWOK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lbx2/iGbwJrVxBtH/tvmQytOHbCOxL2fTfzW18f0LyYASW17gwmLF+xTZb+pH8f7n
	 tiwZ67SFjh0etLYHbPfDML0JHV2Qt4QuTeJ4cLZnbQSxodeQpf0Ne3NuE8FU7GverM
	 6O5gELfCglaTkS4VB5pZOSGNyHtnl7yrfe1ZQUck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfFYLTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:19:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40364 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfFYLTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JCFOlY7my5LaNTExvJt7ORvW5sA/RJVVsz2dF8gTHNY=; b=UV1bFLAxFhqpsTRLYrIOSnkUm
        Zp7bkceku7WRDzTJcfrwG/udKCHgZki8IlMw/T/ujjHJzENADaWcx8xI92qETqPO0Z1vmuNZrMvK3
        C+ZX2mAveWVF13pbON8bjOe/X15KFtFothA4KVuN0KXKLDSmmc3QO/NLekrMJFVsW7LpM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hfjUK-00057J-1Q; Tue, 25 Jun 2019 11:19:48 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 223C5440046; Tue, 25 Jun 2019 12:19:47 +0100 (BST)
Date:   Tue, 25 Jun 2019 12:19:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] regulator: core: Expose some of core functions
 needed by couplers
Message-ID: <20190625111946.GP5316@sirena.org.uk>
References: <20190623210835.26281-1-digetx@gmail.com>
 <20190623210835.26281-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pSb/ns2SnWJqkKHb"
Content-Disposition: inline
In-Reply-To: <20190623210835.26281-3-digetx@gmail.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pSb/ns2SnWJqkKHb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2019 at 12:08:32AM +0300, Dmitry Osipenko wrote:
> Expose some of internal functions that are required for implementation of
> customized regulator couplers.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-couple-api

for you to fetch changes up to d22b85a1b97d12a4940ef9d778f6122546736f78:

  regulator: core: Expose some of core functions needed by couplers (2019-06-25 12:15:35 +0100)

----------------------------------------------------------------
regulator: Coupling API

This series introduces a way of specifying a customized regulators coupler
which is necessary for cases like a non-trivial DVFS implementation.

----------------------------------------------------------------
Dmitry Osipenko (2):
      regulator: core: Introduce API for regulators coupling customization
      regulator: core: Expose some of core functions needed by couplers

 drivers/regulator/core.c          | 194 ++++++++++++++++++++++++++++----------
 drivers/regulator/of_regulator.c  |  63 +++++++++----
 include/linux/regulator/coupler.h |  97 +++++++++++++++++++
 include/linux/regulator/driver.h  |   6 +-
 include/linux/regulator/machine.h |   2 +-
 5 files changed, 287 insertions(+), 75 deletions(-)
 create mode 100644 include/linux/regulator/coupler.h

--pSb/ns2SnWJqkKHb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0SA1IACgkQJNaLcl1U
h9B/agf/ZN1FfEH/kisPsw/QpppR+haTC2xYUvHQmelY29bbY2yXwjPYBpXl8Ztk
/rE6ZjD3gCdXzuBBSCyd8P+RTnkb/18NynDJAVv9WLe6AOZ/e1UYB4d7mh0O/IAB
bjE+IiBMcwzgaMBnBTyF+EJ8JmhWkkEl9Z/FE0RcXT4oiTAU6oHSQ8Xs96H9/374
Hqf9QfEge+nvqAdVwsmhJ2cbb+BXbGDfmcMRJjWv0swcRfJqDrLTFn6ATq/i5o7j
ni2sOaGeQj0x5dhMUUT8oq4+ElSHJaJft2jpwb3xRdCehu+UYdLWeP13jwiS0afJ
NIcKyExMiyb/PEYmhAN57EljvVIoGA==
=6Ntz
-----END PGP SIGNATURE-----

--pSb/ns2SnWJqkKHb--
