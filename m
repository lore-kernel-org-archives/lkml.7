Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AF5C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7952F20675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557152644;
	bh=1oLSi+p/gfUgRP9PhvrokDcgBuKIQCxWQmaKvz2hHzM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=BLXeFLO+UfmJNacUFe2/Y8rIu5Fh8+TFO0Bbm+vwxIHGFyJorDTCVSo6U9JR7DH6V
	 EcEAJD9qFR/YLSWToH4OgNyqZCCkWbFhvxLrdrbfRE+W4r6uWS1aGqx9VSz0HJ5gcv
	 EjnrGvxresIN54GRyQMFOGQ/E60q2zQRaOF+Uc9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEFOYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:24:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43200 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFOYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6DniE1YRHvPc4rcxYLznnZUMqXdqi1H3yswpFDgu7tI=; b=SvivKR2JZLezxc6rMUUMUlw+k
        4j1FLJHrc5UjWSdUApfiFUCQnGn6wA9xTfN8DT5d1fRyWF1qYsMhW9INCRL3HHLPPhulaUP6TO+rP
        fAsWZE93hMbkzPwMuFynQS3DkrlT9RKc045IHYtk4itDp5ya1ye54nqCH0K17hheNvARg=;
Received: from kd111239184067.au-net.ne.jp ([111.239.184.67] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNeX7-0001oK-AW; Mon, 06 May 2019 14:23:58 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 00DC044000C; Mon,  6 May 2019 15:23:52 +0100 (BST)
Date:   Mon, 6 May 2019 23:23:52 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator updates for v5.2
Message-ID: <20190506142352.GT14916@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0+/s3RgBAfRJTJO/"
Content-Disposition: inline
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0+/s3RgBAfRJTJO/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.2

for you to fetch changes up to e2a23affe6a6a15111ae56edd7e4f3c9673ef201:

  Merge branch 'regulator-5.2' into regulator-next (2019-05-06 22:52:14 +0900)

----------------------------------------------------------------
regulator: Updates for v5.2

In terms of big picture changes this has been an extremely quiet release
however there's a lot of changes and a fairly big diffstat thanks to a
bunch of small fixes, mainly coming from Axel Lin.  Thanks to his work
this release removes code overall even though we've added a new (albiet
fairly small) driver.

Notable things:

 - A fix for a long standing issue with locking on error interrupts from
   Steve Twiss.
 - A new driver for ST Microelectonics STM32 PWR.

----------------------------------------------------------------
Arnd Bergmann (2):
      regulator: da903x: don't build with clang
      regulator: add regulator_get_linear_step() stub helper

Axel Lin (104):
      regulator: palmas: Remove *rdev[PALMAS_NUM_REGS] from struct palmas_pmic
      regulator: ab3100: Remove ab3100_regulators_remove function
      regulator: wm8400: Get rid of wm8400_block_read/wm8400_set_bits functions
      regulator: wm8400: Fix trivial typo
      regulator: gpio: Convert to devm_regulator_register
      regulator: gpio: Constify regulator_ops
      regulator: max14577: Get rid of match_init_data/match_of_node functions
      regulator: wm831x-isink: Select maximum current in specific range
      regulator: wm8350: Select maximum current in specific range
      regulator: wm831x-isink: Convert to use regulator_set/get_current_limit_regmap
      regulator: wm8350: Convert to use regulator_set/get_current_limit_regmap
      regulator: 88pm800: Get rid of struct pm800_regulators
      regulator: da9052: Convert to regulator core's simplified DT parsing code
      regulator: da9055: Convert to regulator core's simplified DT parsing code
      regulator: da9052: Include linux/of.h to fix build warning for of_match_ptr
      regulator: as3722: Remove *rdevs[] from struct as3722_regulators
      regulator: cpcap: Remove unneeded init_data setting
      regulator: cpcap: Convert to use of_device_get_match_data
      regulator: as3711: Remove struct as3711_regulator_info and as3711_regulator
      regulator: max77650: Use unsigned int for max77651_sbb1_regulator_volt_table
      regulator: mt6323: Use unsigned int for volt_tables
      regulator: mt6380: Use unsigned int for volt_tables
      regulator: mt6397: Use unsigned int for volt_tables
      regulator: lp87565: Fix missing register for LP87565_BUCK_0
      regulator: lp87565: Convert to use regulator_set/get_current_limit_regmap
      regulator: da9062: Convert to use regulator_set/get_current_limit_regmap
      regulator: da9063: Convert to use regulator_set/get_current_limit_regmap
      regulator: 88pm8607: Convert to regulator core's simplified DT parsing code
      regulator: axp20x: Remove unneeded NULL test against rdev
      regulator: axp20x: Use rdev_get_id at appropriate places
      regulator: max8925: Convert to regulator core's simplified DT parsing code
      regulator: rn5t618: Constify regulator_desc
      regulator: tps65132: Remove unneeded fields from struct tps65132_regulator
      regulator: tps65132: Constify tps65132_regulator_ops and tps_regs_desc
      regulator: tps65217: Simplify linear range for selector 25-52
      regulator: tps65086: Fix tps65086_ldoa1_ranges for selector 0xB
      regulator: uniphier: Fix build dependency
      regulator: tps65218: Constify regulator_ops
      regulator: tps65217: Constify regulator_ops
      regulator: sc2731: Constify regulators
      regulator: tps65217: Fix off-by-one for latest seletor of tps65217_uv1_ranges
      regulator: act8865: Convert to regulator core's simplified DT parsing code
      regulator: act8865: Constify regulator_ops
      regulator: rc5t583: Get rid of struct rc5t583_regulator
      regulator: vctrl: Remove unneeded continue statement
      regulator: tps6507x: Constify tps6507x_pmic_ops
      regulator: tps6507x: Remove unused *rdev[] from struct tps6507x_pmic
      regulator: tps6507x: Convert to regulator core's simplified DT parsing code
      regulator: as3722: Convert to use regulator_set/get_current_limit_regmap
      regulator: as3722: Slightly improve readability
      regulator: bcm590xx: Convert to use simplified DT parsing
      regulator: lm363x: Use proper data type for regmap_read arguments
      regulator: lm363x: Constify regulator_ops
      regulator: twl: Constify regulator_ops
      regulator: bd718x7: Use rdev_get_id() to get regulator id
      regulator: s2mpa01: Convert to use simplified DT parsing
      regulator: hi655x: Constify regulators array
      regulator: hi655x: Remove ctrl_mask field from struct hi655x_regulator
      regulator: s2mpa01: Remove unused define for S2MPA01_REGULATOR_CNT
      regulator: anatop: Remove unneeded fields from struct anatop_regulator
      regulator: hi6421: Convert to use simplified DT parsing
      regulator: vexpress: Constify regulator_ops
      regulator: mcp16502: Remove unneeded fields from struct mcp16502
      regulator: mcp16502: Remove setup_regulators function
      regulator: db8500-prcmu: Constify regulator_ops
      regulator: db8500-prcmu: Convert to use simplified DT parsing
      regulator: dbx500-prcmu: Remove unused fields from struct dbx500_regulator_info
      regulator: ab8500-ext: Remove *rdev from struct ab8500_ext_regulator_info
      regulator: ab8500-ext: Convert to use simplified DT parsing
      regulator: ab8500-ext: Constify ab8500_ext_regulator_ops
      regulator: ab8500: Constify regulator_ops
      regulator: ab8500: Remove *regulator from struct ab8500_regulator_info
      regulator: tps65218: Convert to use regulator_get_current_limit_regmap
      regulator: tps6524x: Constify regulator_ops
      regulator: tps6524x: Remove *rdev[N_REGULATORS] from struct tps6524x
      regulator: max8998: Constify regulator_ops
      regulator: max8998: Factor out struct voltage_map_desc
      regulator: tps80031: Remove unused *rdev from struct tps80031_regulator
      regulator: tps80031: Constify regulator_ops and tps80031_dcdc_voltages array
      regulator: tps80031: Switch to SPDX identifier
      regulator: wm8994: Switch to SPDX identifier
      regulator: arizona: Switch to SPDX identifier
      regulator: wm831x: Switch to SPDX identifier
      regulator: wm8350: Switch to SPDX identifier
      regulator: wm8400: Switch to SPDX identifier
      regulator: max77620: Fix regulator info setting for max20024
      regulator: ltc3589: Convert to use simplified DT parsing
      regulator: ltc3589: Get rid of struct ltc3589_regulator
      regulator: ltc3589: Switch to SPDX identifier
      regulator: fan53555: Clean up unneeded fields from struct fan53555_device_info
      regulator: fan53555: Switch to SPDX identifier
      regulator: mt63xx: Switch to SPDX identifier
      regulator: sy8106a: Get rid of struct sy8106a
      regulator: sky81452: Constify sky81452_reg_ops
      regulator: sky81452: Switch to SPDX identifier
      regulator: vexpress: Get rid of struct vexpress_regulator
      regulator: vexpress: Switch to SPDX identifier
      regulator: hi6xxx: Switch to SPDX identifier
      regulator: pv880x0: Switch to SPDX identifier
      regulator: ab3100: Constify regulator_ops and ab3100_regulator_desc
      regulator: ab3100: Set fixed_uV instead of min_uV for fixed regulators
      regulator: stm32-pwr: Remove unneeded *desc from struct stm32_pwr_reg
      regulator: stm32-pwr: Remove unneeded .min_uV and .list_volage
      regulator: da9xxx: Switch to SPDX identifier

Charles Keepax (1):
      regulator: core: Avoid potential deadlock on regulator_unregister

Gustavo A. R. Silva (1):
      regulator: axp20x: Mark expected switch fall-throughs

Jorge Ramirez-Ortiz (2):
      regulator: core: do not report EPROBE_DEFER as error but as debug
      regulator: core: simplify return value on suported_voltage

Linus Walleij (1):
      regulator: core: Actually put the gpiod after use

Marek Vasut (1):
      regulator: gpio: Reword the binding document

Mark Brown (4):
      regulator: core: Fix application of "drop lockdep annotation in drms_uA_update()"
      Merge tag 'v5.1-rc1' into regulator-5.2
      Merge branch 'regulator-5.1' into regulator-linus
      Merge branch 'regulator-5.2' into regulator-next

Nicholas Mc Guire (1):
      ASoC: ab8500: add range to usleep_range

Pascal PAILLET-LME (2):
      dt-bindings: regulator: Add stm32mp1 pwr regulators
      regulator: Add support for stm32 power regulators

Steve Twiss (14):
      regulator: da9055: Fix notifier mutex lock warning
      regulator: da9062: Fix notifier mutex lock warning
      regulator: pv88080: Fix notifier mutex lock warning
      regulator: pv88090: Fix notifier mutex lock warning
      regulator: wm831x: Fix notifier mutex lock warning
      regulator: da9063: Fix notifier mutex lock warning
      regulator: da9211: Fix notifier mutex lock warning
      regulator: lp8755: Fix notifier mutex lock warning
      regulator: ltc3589: Fix notifier mutex lock warning
      regulator: ltc3676: Fix notifier mutex lock warning
      regulator: pv88060: Fix notifier mutex lock warning
      regulator: wm831x isink: Fix notifier mutex lock warning
      regulator: wm831x ldo: Fix notifier mutex lock warning
      regulator: core: fix error path for regulator_set_voltage_unlocked

Wei Yongjun (1):
      regulator: stm32-pwr: Fix return value check in stm32_pwr_regulator_probe()

Wolfram Sang (1):
      regulator: da9063: convert header to SPDX

YueHaibing (1):
      regulator: of: Make regulator_of_get_init_node static

kbuild test robot (1):
      regulator: ready_mask_table[] can be static

 .../bindings/regulator/gpio-regulator.txt          |  30 ++-
 .../bindings/regulator/st,stm32mp1-pwr-reg.txt     |  43 +++
 drivers/mfd/wm831x-core.c                          |   2 +-
 drivers/mfd/wm8400-core.c                          |   6 -
 drivers/regulator/88pm800.c                        |  18 +-
 drivers/regulator/88pm8607.c                       |  43 +--
 drivers/regulator/Kconfig                          |  11 +-
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/ab3100.c                         |  45 +---
 drivers/regulator/ab8500-ext.c                     |  49 +---
 drivers/regulator/ab8500.c                         |  20 +-
 drivers/regulator/act8865-regulator.c              | 147 ++--------
 drivers/regulator/anatop-regulator.c               |  63 ++---
 drivers/regulator/arizona-ldo1.c                   |  19 +-
 drivers/regulator/arizona-micsupp.c                |  19 +-
 drivers/regulator/as3711-regulator.c               |  37 +--
 drivers/regulator/as3722-regulator.c               | 287 ++++++--------------
 drivers/regulator/axp20x-regulator.c               |  23 +-
 drivers/regulator/bcm590xx-regulator.c             | 105 +-------
 drivers/regulator/bd718x7-regulator.c              |   4 +-
 drivers/regulator/core.c                           |  30 ++-
 drivers/regulator/cpcap-regulator.c                |  15 +-
 drivers/regulator/da903x.c                         |  16 +-
 drivers/regulator/da9052-regulator.c               |  55 +---
 drivers/regulator/da9055-regulator.c               |  89 ++----
 drivers/regulator/da9062-regulator.c               | 146 +++-------
 drivers/regulator/da9063-regulator.c               | 134 +++------
 drivers/regulator/da9210-regulator.c               |  23 +-
 drivers/regulator/da9210-regulator.h               |  17 +-
 drivers/regulator/da9211-regulator.c               |  24 +-
 drivers/regulator/da9211-regulator.h               |  11 +-
 drivers/regulator/db8500-prcmu.c                   | 143 +++-------
 drivers/regulator/dbx500-prcmu.h                   |   4 -
 drivers/regulator/fan53555.c                       |  60 ++---
 drivers/regulator/gpio-regulator.c                 |  22 +-
 drivers/regulator/hi6421-regulator.c               | 232 ++++++----------
 drivers/regulator/hi6421v530-regulator.c           |  26 +-
 drivers/regulator/hi655x-regulator.c               |  37 +--
 drivers/regulator/lm363x-regulator.c               |   8 +-
 drivers/regulator/lp8755.c                         |  15 +-
 drivers/regulator/lp87565-regulator.c              |  49 +---
 drivers/regulator/ltc3589.c                        | 269 ++++++------------
 drivers/regulator/ltc3676.c                        |  10 +-
 drivers/regulator/max14577-regulator.c             |  55 ----
 drivers/regulator/max77620-regulator.c             |   2 +-
 drivers/regulator/max77650-regulator.c             |   2 +-
 drivers/regulator/max8925-regulator.c              |  76 +-----
 drivers/regulator/max8998.c                        | 300 ++++-----------------
 drivers/regulator/mcp16502.c                       |  67 ++---
 drivers/regulator/mt6311-regulator.c               |  17 +-
 drivers/regulator/mt6311-regulator.h               |  10 +-
 drivers/regulator/mt6323-regulator.c               |  32 +--
 drivers/regulator/mt6380-regulator.c               |  25 +-
 drivers/regulator/mt6397-regulator.c               |  33 +--
 drivers/regulator/of_regulator.c                   |   5 +-
 drivers/regulator/palmas-regulator.c               |  12 -
 drivers/regulator/pv88060-regulator.c              |  22 +-
 drivers/regulator/pv88060-regulator.h              |  11 +-
 drivers/regulator/pv88080-regulator.c              |  22 +-
 drivers/regulator/pv88080-regulator.h              |  11 +-
 drivers/regulator/pv88090-regulator.c              |  22 +-
 drivers/regulator/pv88090-regulator.h              |  11 +-
 drivers/regulator/rc5t583-regulator.c              |  25 +-
 drivers/regulator/rn5t618-regulator.c              |   8 +-
 drivers/regulator/s2mpa01.c                        |  41 +--
 drivers/regulator/sc2731-regulator.c               |   2 +-
 drivers/regulator/sky81452-regulator.c             |  26 +-
 drivers/regulator/stm32-pwr.c                      | 186 +++++++++++++
 drivers/regulator/sy8106a-regulator.c              |  40 +--
 drivers/regulator/tps6507x-regulator.c             | 113 ++------
 drivers/regulator/tps65086-regulator.c             |   4 +-
 drivers/regulator/tps65132-regulator.c             |  29 +-
 drivers/regulator/tps65217-regulator.c             |   9 +-
 drivers/regulator/tps65218-regulator.c             |  56 ++--
 drivers/regulator/tps6524x-regulator.c             |  11 +-
 drivers/regulator/tps80031-regulator.c             |  48 ++--
 drivers/regulator/twl-regulator.c                  |   6 +-
 drivers/regulator/vctrl-regulator.c                |   4 +-
 drivers/regulator/vexpress-regulator.c             |  72 ++---
 drivers/regulator/wm831x-dcdc.c                    |  23 +-
 drivers/regulator/wm831x-isink.c                   |  66 ++---
 drivers/regulator/wm831x-ldo.c                     |  21 +-
 drivers/regulator/wm8350-regulator.c               | 102 ++-----
 drivers/regulator/wm8400-regulator.c               |  39 ++-
 drivers/regulator/wm8994-regulator.c               |  19 +-
 include/linux/mfd/palmas.h                         |   1 -
 include/linux/mfd/wm831x/regulator.h               |   2 +-
 include/linux/mfd/wm8400-private.h                 |   8 -
 include/linux/regulator/consumer.h                 |   5 +
 sound/soc/codecs/ab8500-codec.c                    |   4 +-
 90 files changed, 1332 insertions(+), 2780 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
 create mode 100644 drivers/regulator/stm32-pwr.c

--0+/s3RgBAfRJTJO/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzQQ3gACgkQJNaLcl1U
h9AyEAf/ZcHC1a41DkfClvOptN21hhn1pWuagU6DB8bOooTjL2J9Y1j/feAEVTeI
0v602bzkwGIB3CWEcpg+1DuFX724MvpAFdxVfWAp7jO0gjagrOFcz1Lp4uQwVdut
SC+fM506ZnLfKbH05CpAlhd00Jbr0Gz4oA3I8jGw3gH3lmHN7/FvzK22HofQmr2B
Pvh9aPiy5XxEXFr2Jprv8V1CZCqSNV51EdDdPp/QCb4mqZaajO2sq5xpL9YT+JkJ
bJxT7iFFX3N527oFeMJEupQjLIQGqn+u+Eq9209x3O/BF7wRgHR1vCz9IxdZzvrS
taLJWnKMOoFvXFASWsojn8XksJnQSA==
=NEtw
-----END PGP SIGNATURE-----

--0+/s3RgBAfRJTJO/--
