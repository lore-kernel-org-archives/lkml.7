Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAFBC4CEC4
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 23:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE41520692
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 23:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568588616;
	bh=bV0myK9Lj6Fm2EeflbK9GS+uBcXC5nn0XRcUK70gDV0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=aBBOQxx5uUqEQOO0V5Iq9RiRxFY/EOLeQS8qHb6/pI6z0gwc+GWG9LiNLKPeL2/cc
	 hF1xVH94gt6mjLaXiGP4EfB7XaDH8xj/EF0BREi2ntEbZ7NVVaWPaXdHYnhtXjoqgi
	 /dYpH/M1z4mvK9RQvo2+0hJHGmPF3QjkU/aRxbaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfIOXDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 19:03:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44358 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfIOXDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 19:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KYcEhqS5e2f+CVk+iQ04yvaeF9OqhnSOCiQvzIdc9Aw=; b=JykVjsGsaMIptHRsSO47lfYFj
        mdfQM/TxKoDB5DbJmcabsC0oLbf7+ASl/0yR3KrVfxIIJpZ/zpcLMceJFA1FsYMr7On8tTiwIYC02
        9HMe8+MJClCg2LulafzYEQ1lc1V14J1z/49s2PwnO7JKkfd7pkVdsk3APvxzkRC7hCex4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9dYK-0001bG-G0; Sun, 15 Sep 2019 23:03:32 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B31C227419E4; Mon, 16 Sep 2019 00:03:31 +0100 (BST)
Date:   Mon, 16 Sep 2019 00:03:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator updates for v5.4
Message-ID: <20190915230331.GP4352@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3loezlmesXOUD0D5"
Content-Disposition: inline
X-Cookie: Man and wife make one fool.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3loezlmesXOUD0D5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit f74c2bb98776e2de508f4d607cd519873065118e:

  Linux 5.3-rc8 (2019-09-08 13:33:15 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tag=
s/regulator-v5.4

for you to fetch changes up to c4ad85026d4dd5a3f65c04b4564fe273e37e5b88:

  Merge branch 'regulator-5.4' into regulator-next (2019-09-11 16:00:19 +01=
00)

----------------------------------------------------------------
regulator: Updates for v5.4

A small update for the regualtor API for this cycle, some small fixes
and a bunch of new devices but none of them very big.  The most stand
out thing is the regulator-fixed-clock driver which is for regulators
where the enable control is done by using a clock instead of a GPIO or
register write, a novel hardware design that had not previously come up.

 - Added a keyword pattern for regulator_get_optional() since usage of
   that API generally needs extra review.
 - Operating mode and suspend state support for act8865.
 - New device support for Active Semiconductor ACT8600 chargers,
   Mediatek MT6358, Qualcomm SM8150, regulator-fixed-clock, and
   Synoptics SY20276, SY20278 and SY8824E.

----------------------------------------------------------------
Axel Lin (5):
      regulator: lm363x: Fix off-by-one n_voltages for lm3632 ldo_vpos/ldo_=
vneg
      regulator: lm363x: Fix n_voltages setting for lm36274
      regulator: rk808: Return REGULATOR_MODE_INVALID for invalid mode
      regulator: stm32-booster: Remove .min_uV and .list_voltage for fixed =
regulator
      regulator: lp87565: Simplify lp87565_buck_set_ramp_delay

Bartosz Golaszewski (2):
      regulator: provide regulator_bulk_set_supply_names()
      regulator: add missing 'static inline' to a helper's stub

Colin Ian King (2):
      regulator: max8660: remove redundant assignment of variable ret
      regulator: lp8788-ldo: make array en_mask static const, makes object =
smaller

Dmitry Torokhov (3):
      regulator: slg51000: use devm_gpiod_get_optional() in probe
      regulator: max77686: fix obtaining "maxim,ena" GPIO
      regulator: da9211: fix obtaining "enable" GPIO

Gregory CLEMENT (3):
      dt-bindings: regulator: twl6030: Add retain-on-reset property
      regulator: twl6030: use variable for device node
      regulator: twl6030: workaround the VMMC reset behavior

Guido G=C3=BCnther (1):
      regulator: tps65132: Stop parsing DT when gpio is not found

H. Nikolaus Schaller (1):
      regulator: core: Fix error return for /sys access

Hsin-Hsiung Wang (2):
      regulator: Add document for MT6358 regulator
      regulator: mt6358: Add support for MT6358 regulator

Jisheng Zhang (10):
      regulator: add binding for the SY8824C voltage regulator
      regulator: add support for SY8824C regulator
      dt-bindings: sy8824x: Document SY8824E support
      regulator: sy8824x: add SY8824E support
      dt-bindings: sy8824x: Document SY20276 support
      regulator: sy8824x: add SY20276 support
      dt-bindings: sy8824x: Document SY20278 support
      regulator: sy8824x: add SY20278 support
      regulator: sy8824x: use c++style for the comment block near SPDX
      regulator: sy8824x: add prefixes to BUCK_EN and MODE macros

Krzysztof Kozlowski (1):
      regulator: s2mps11: Consistently use local variable

Kunihiko Hayashi (1):
      regulator: uniphier: Add Pro5 USB3 VBUS support

Maarten ter Huurne (1):
      regulator: act8865: Add support for act8600 charger

Mark Brown (6):
      regulator: mt6358: Add BROKEN dependency while waiting for MFD to mer=
ge
      MAINTAINERS: Add keyword pattern on regulator_get_optional()
      regulator: Defer init completion for a while after late_initcall
      Merge branch 'regulator-5.3' into regulator-5.4
      Merge branch 'regulator-5.3' into regulator-linus
      Merge branch 'regulator-5.4' into regulator-next

Micha=C5=82 Miros=C5=82aw (2):
      regulator: act8865: rename fixed LDO ops
      regulator: act8865: support regulator-pull-down property

Nishka Dasgupta (2):
      regulator: core: Add of_node_put() before return
      regulator: core: Add label to collate of_node_put() statements

Philippe Schenker (2):
      regulator: fixed: add possibility to enable by clock
      dt-bindings: regulator: add regulator-fixed-clock binding

Raag Jadav (2):
      regulator: act8865 regulator modes and suspend states
      regulator: act8865: operating mode and suspend state support

Stephen Boyd (1):
      regulator: Remove dev_err() usage after platform_get_irq()

Vinod Koul (6):
      regulator: dt-bindings: Add PM8150x compatibles
      regulator: qcom-rpmh: Add support for SM8150
      regulator: dt-bindings: Sort the compatibles and nodes
      regulator: qcom-rpmh: Sort the compatibles
      regulator: qcom-rpmh: Fix pmic5_bob voltage count
      regulator: qcom-rpmh: Update PMIC modes for PMIC5

YueHaibing (1):
      regulator: act8865: Fix build error without CONFIG_POWER_SUPPLY

kbuild test robot (1):
      regulator: act8865: fix ptr_ret.cocci warnings

 .../bindings/regulator/act8865-regulator.txt       |  27 +-
 .../bindings/regulator/fixed-regulator.yaml        |  19 +-
 .../bindings/regulator/mt6358-regulator.txt        | 358 ++++++++++++++
 .../bindings/regulator/qcom,rpmh-regulator.txt     |  15 +-
 .../devicetree/bindings/regulator/sy8824x.txt      |  24 +
 .../bindings/regulator/twl-regulator.txt           |   7 +
 .../bindings/regulator/uniphier-regulator.txt      |   5 +-
 MAINTAINERS                                        |   1 +
 drivers/regulator/Kconfig                          |  17 +
 drivers/regulator/Makefile                         |   2 +
 drivers/regulator/act8865-regulator.c              | 316 +++++++++++-
 drivers/regulator/act8945a-regulator.c             |   8 +-
 drivers/regulator/core.c                           |  58 ++-
 drivers/regulator/da9062-regulator.c               |   4 +-
 drivers/regulator/da9063-regulator.c               |   4 +-
 drivers/regulator/da9211-regulator.c               |   2 +-
 drivers/regulator/fixed.c                          |  83 +++-
 drivers/regulator/helpers.c                        |  21 +
 drivers/regulator/lm363x-regulator.c               |  10 +-
 drivers/regulator/lp87565-regulator.c              |   5 +-
 drivers/regulator/lp8788-ldo.c                     |   2 +-
 drivers/regulator/max77686-regulator.c             |   2 +-
 drivers/regulator/max8660.c                        |   1 -
 drivers/regulator/mt6358-regulator.c               | 549 +++++++++++++++++=
++++
 drivers/regulator/qcom-rpmh-regulator.c            | 193 +++++++-
 drivers/regulator/rk808-regulator.c                |   2 +-
 drivers/regulator/s2mps11.c                        |   2 +-
 drivers/regulator/slg51000-regulator.c             |  15 +-
 drivers/regulator/stm32-booster.c                  |   4 -
 drivers/regulator/sy8824x.c                        | 232 +++++++++
 drivers/regulator/tps65132-regulator.c             |   4 +-
 drivers/regulator/twl-regulator.c                  |  23 +-
 drivers/regulator/twl6030-regulator.c              |  21 +-
 drivers/regulator/uniphier-regulator.c             |   4 +
 .../regulator/active-semi,8865-regulator.h         |  28 ++
 include/linux/regulator/consumer.h                 |  13 +
 include/linux/regulator/mt6358-regulator.h         |  56 +++
 37 files changed, 2048 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6358-regu=
lator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/sy8824x.txt
 create mode 100644 drivers/regulator/mt6358-regulator.c
 create mode 100644 drivers/regulator/sy8824x.c
 create mode 100644 include/dt-bindings/regulator/active-semi,8865-regulato=
r.h
 create mode 100644 include/linux/regulator/mt6358-regulator.h

--3loezlmesXOUD0D5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1+w0IACgkQJNaLcl1U
h9C3Zwf/bNh/gEtcsMTIq/0r3ZO3HRc044FLkWams6rj4thjpYMllJvwHJcmZEsj
CDAuJfoVYDgWghY+0Z4T/CBWi/Ecz8gu2TQkrjB4pioClEkZW4Vt25+giubMj1l+
8Y3n+XGME0PbhswRTvCdjVlfF7HwzJb/fQnFLHfNnNmJOuFTq0S9hLXlSTvCfyS0
tM8CB17HQkcLyFOOfT04tvqqX11fqrjdcq3TQATvseya6iph+8mJM2hzo7+5dFoD
C/SVusJVYGQKddAmf6aG7Ccmyp6QyqF0ZWV3tvf3DOcJZPAj6G7riz1RPXfiSUkR
biKn+gNVXnfhdUcl/QG/RuGfCWnbAA==
=k7xF
-----END PGP SIGNATURE-----

--3loezlmesXOUD0D5--
