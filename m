Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78962C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A582207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578316003;
	bh=3GxSAKCIRsy8VGcCu6EpRzx5LbAhqpbgzANdh4xP1Rw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=DWa4DTOhLHjGDZ+PE1iqXVcnAUCQSg9Yg76USU5mMiQyzrrOazHvAOQTynEs484sE
	 Hb995YVFFMvKcFusApTaJhjWrzFWdZF1egZjxAm3qirQnjtEpllhmT6vvdikDXVUud
	 Hzce78dKyhhXHx5s+8/X0dobasIY1pfjC+//3Ank=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgAFNGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 08:06:42 -0500
Received: from foss.arm.com ([217.140.110.172]:43828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgAFNGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:06:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84967328;
        Mon,  6 Jan 2020 05:06:34 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CCBF3F534;
        Mon,  6 Jan 2020 05:06:33 -0800 (PST)
Date:   Mon, 6 Jan 2020 13:06:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator fixes for v5.5
Message-ID: <20200106130632.GB6448@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
X-Cookie: It's later than you think.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 62a1923cc8fe095912e6213ed5de27abbf1de77e:

  regulator: rn5t618: fix module aliases (2019-12-16 11:53:37 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.5-rc5

for you to fetch changes up to 6f1ff76154b8b36033efcbf6453a71a3d28f52cd:

  regulator: bd70528: Remove .set_ramp_delay for bd70528_ldo_ops (2020-01-03 00:58:58 +0000)

----------------------------------------------------------------
regulator: Fixes for v5.5

Three small fixes here, two the result of Axel Lin's amazing work
tracking down inconsistencies in drivers.

----------------------------------------------------------------
Axel Lin (2):
      regulator: axp20x: Fix axp20x_set_ramp_delay
      regulator: bd70528: Remove .set_ramp_delay for bd70528_ldo_ops

Chen-Yu Tsai (1):
      regulator: axp20x: Fix AXP22x ELDO2 regulator enable bitmask

 drivers/regulator/axp20x-regulator.c  | 11 +++++++----
 drivers/regulator/bd70528-regulator.c |  1 -
 2 files changed, 7 insertions(+), 5 deletions(-)

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4TMNcACgkQJNaLcl1U
h9A/Xwf/SUii0T6C+A/j27+1EX9pvc7c+E++PDdy7cF30b+rejpN9pYgho/Bv9pU
urYLWzocEQ4BjMpn711s+xI+QNTNisEGZg7A8Y8wp4q4dPu/ZgS2dJD+vjiJVG45
aMeX8mGHGxy6b4VkXqAa7SGHUVHpEXrbbYosO6671iTK+z1R3xTEWt2E0srsCIsd
YHKcQpHOc0H22MDd0dKsYl7LC+6L7sH2njPYP+RjT0bgeTAZgds6rO3U75gONwZj
xn5GNhqpYv5CAbc3mza/P9xnrJOrlSN/EZjBfOtUixQM0F7xezwH2o7mtOzuHm6j
mns2DOnfv8HxAOXTQX80kt6HujFhSg==
=Yu07
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
