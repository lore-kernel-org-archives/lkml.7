Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7AEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B27206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551717263;
	bh=OVKcXKTYnicXf9d2LCkkz2EnBOmglUikru53Kr2sSSQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=b/gN31sUy1l5dpCEP6U7yYecuGlkY7e53lxG/pzVe8QUBkGKwq1kFjKeEZPWC1TKw
	 HZH5S7cBRuhbe95rbehBlD7zL9zHMk6SvNlE061h8E50iW8NaZBG+tL8yboEckN7o9
	 QDMTXQQmqGUhBb8LUlFWvBDBh9mOUWNUSDwMUkyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfCDQeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:34:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46002 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfCDQeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ebaafvfK26IxzxBuJEpZdx2PM0P40LgaaZWQcVU3/Rk=; b=RS3JYd7ZZ3FKuR7Xbp0/ttvQ9
        /RynG66IjZRaOlhTpER/OZAdubjwvV76yeFhkbopM4czPTy549rbYhz+atZI3Gwgf/wWhYfSjLmqa
        Z+oePFbItpN2H7xFnE+kfH1QbPwbh86Njm1cAdW9XQNgLC2dxTHxXOYo70OJQYjtwOPbk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0qXg-00035v-2P; Mon, 04 Mar 2019 16:34:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 914321128814; Mon,  4 Mar 2019 16:34:15 +0000 (GMT)
Date:   Mon, 4 Mar 2019 16:34:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] regulator updates for v5.1
Message-ID: <20190304163415.GB8877@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
X-Cookie: Do, or do not
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1c163f4c7b3f621efff9b28a47abb36f7378d783:

  Linux 5.0 (2019-03-03 15:21:29 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.1

for you to fetch changes up to 88f268a5bcc3b0683e6fbaf9973702e5329fc1e3:

  Merge branch 'regulator-5.1' into regulator-next (2019-03-04 15:32:43 +0000)

----------------------------------------------------------------
regulator: Updates for v5.1

The bulk of the standout changes in this release are cleanups, with the
core work being a combination of factoring out common code into helpers
and the completion of the conversion of the core to use GPIO
descriptors.

 - Addition of helper functions for current limits and conversion of
   drivers to use them by Axel Lin.
 - Lots and lots of cleanups from Axel Lin.
 - Conversion of the core to use GPIO descriptors rather than numbers by
   Linus Walleij.
 - New drivers for Maxim MAX77650 and ROHM BD70528.

----------------------------------------------------------------
Axel Lin (78):
      regulator: lochnagar: Set up correct .data field for "cirrus,lochnagar2-mic2vdd"
      regulator: bcm590xx: Fix .enable_reg for BCM590XX_REG_VSR
      regulator: act8945a: Use rdev_get_id() to access id of regulator
      regulator: hi655x: Removed unused ctrl_regs field from struct hi655x_regulator
      regulator: pwm: No need to make a copy of regulator_ops per instance
      regulator: max14577: Remove redundant MODULE_ALIAS
      regulator: twl6030: Use of_device_get_match_data()
      regulator: act8865: Fix act8600_sudcdc_voltage_ranges setting
      regulator: arizona-ldo1: Convert to use regulator_linear_range for ldo1_hc
      regulator: twl: Use of_device_get_match_data()
      regulator: wm831x-dcdc: Convert to use regulator_linear_range for wm831x_buckv
      regulator: stpmic1: Add static const qualifier at peroper places
      regulator: bd70528: Constify regulator_linear_range and regulator_ops
      regulator: bd718x7: Constify regulator_ops
      regulator: bd9571mwv: Constify regulator_ops
      regulator: lp3971: Constify lp3971_ldo_ops and lp3971_dcdc_ops
      regulator: lp3972: Constify lp3972_ldo_ops and lp3972_dcdc_ops
      regulator: lp872x: Constify regulator_ops and regulator_desc
      regulator: lp873x: Constify lp873x_buck01_ops and lp873x_ldo01_ops
      regulator: lp8755: Constify lp8755_regulators
      regulator: lp87565: Constify lp87565_buck_ramp_delay and lp87565_buck_ops
      regulator: lp8788-buck: Constify lp8788_buck_desc
      regulator: lp8788-ldo: Constify lp8788_dldo_desc and lp8788_aldo_desc
      regulator: da9062: Check return value of devm_regmap_field_alloc calls
      regulator: da9063: Check return value of devm_regmap_field_alloc calls
      regulator: mcp16502: Include linux/gpio/consumer.h to fix build error
      regulator: rk808: Constify regulator_ops
      regulator: rk808: Update module description to include RK805
      regulator: isl6271a: Remove *rdev[3] from struct isl_pmic
      regulator: isl6271a: Constify isl_core_ops and isl_fixed_ops
      regulator: axp20x: Fix incorrect vsel_mask settings
      regulator: max77650: Fix include files
      regulator: uniphier: Fix probe error handling
      regulator: uniphier: Constify uniphier_regulator_ops
      regulator: rk808: Convert rk805 buck1/2 to use linear range
      regulator: lochnagar: Fix n_voltages setting for VDDCORE
      regulator: rt5033: Constify rt5033_safe_ldo_ops and rt5033_buck_ops
      regulator: lm363x: Check return value of gpiod_get_index_optional
      regulator: lp8788-buck: Convert to linear range
      regulator: ltc3676: Simplify .readable_reg and .writable_reg callbacks
      regulator: ltc3676: Fix module description
      regulator: pv88060: Fix .ops for PV88060_SW
      regulator: stpmic1: Remove regul_id and *regmap from struct stpmic1_regulator
      regulator: pv88060: Fix array out-of-bounds access
      regulator: pv88080: Fix array out-of-bounds access
      regulator: pv88090: Fix array out-of-bounds access
      regulator: da9062: Select maximum current in specific range for set_current_limit
      regulator: da9063: Select maximum current in specific range for set_current_limit
      regulator: max77620: Add missing .owner field in regulator_desc
      regulator: max77650: Add missing .owner field in regulator_desc
      regulator: twl6030: Use regulator_list_voltage_linear_range for twl6030ldo_ops
      regulator: twl6030: Constify regulator_ops
      regulator: lp873x: Constify lp873x_buck_ramp_delay array
      regulator: s5m8767: Constify s5m8767_opmode_reg
      regulator: s5m8767: Simplify s5m8767_set_voltage_time_sel implementation
      regulator: max77650: Fix set_current_limit implementation
      regulator: mt6311: Use linear instead of linear range for mt6311_buck_ops
      regulator: wm831x-dcdc: Fix list of wm831x_dcdc_ilim from mA to uA
      regulator: arizona_ldo1: Simplify arizona_ldo1_hc_set/get_voltage_sel
      regulator: fan53555: Check pdata->slew_rate setting
      regulator: mcp16502: Remove module version
      regulator: cpcap: Remove unused vsel_shift from struct cpcap_regulator
      regulator: cpcap: Constify omap4_regulators and xoom_regulators
      regulator: 88pm8607: Simplify pm8607_list_voltage implementation
      regulator: 88pm8607: Remove unused fields from struct pm8607_regulator_info
      regulator: Fix comment for csel_reg and csel_mask
      regulator: core: Add set/get_current_limit helpers for regmap users
      regulator: da9055: Convert to use regulator_set/get_current_limit_regmap
      regulator: da9210: Convert to use regulator_set/get_current_limit_regmap
      regulator: lp872x: Convert to use regulator_set/get_current_limit_regmap
      regulator: lp873x: Convert to use regulator_set/get_current_limit_regmap
      regulator: max77650: Convert to use regulator_set/get_current_limit_regmap
      regulator: pv88060: Convert to use regulator_set/get_current_limit_regmap
      regulator: pv88080: Convert to use regulator_set/get_current_limit_regmap
      regulator: pv88090: Convert to use regulator_set/get_current_limit_regmap
      regulator: wm831x-dcdc: Convert to use regulator_set/get_current_limit_regmap
      regulator: palmas: Constify palmas_smps_ramp_delay array
      regulator: mc13xxx: Constify regulator_ops variables

Bartosz Golaszewski (3):
      regulator: provide rdev_get_regmap()
      regulator: max77650: add regulator support
      dt-bindings: regulator: add DT bindings for max77650

Bjorn Andersson (2):
      regulator: qcom-smd: Batch up requests for disabled regulators
      regulator: fan53555: Add support for FAN53526

Charles Keepax (2):
      regulator: lochnagar: Add missing MODULE_DEVICE_TABLE
      regulator: as3722: Correct minor typo

Christian Hohnstaedt (4):
      regulator: tps65218.c: fix LS3 issues
      regulator: tps65218: Add support for LS2
      dt-bindings: regulator: add LS2 load switch documentation
      dt-bindings: regulator: tps65218: rectify units of LS3

Colin Ian King (3):
      regulator: axp20x: check rdev is null before dereferencing it
      regulator: max77802-regulator: fix indentation in if statement
      regulator: axp20x: remove a redundant null check on rdev

Fabrice Gasnier (1):
      regulator: stm32-vrefbuf: add power management support

Guennadi Liakhovetski (1):
      regulator: fix device unlinking

Gustavo A. R. Silva (2):
      regulator: da9063: Use struct_size() in devm_kzalloc()
      regulator: da9062: Use struct_size() in devm_kzalloc()

Johan Hovold (1):
      dt-bindings: regulator: update fixed-regulator example

Krzysztof Kozlowski (2):
      regulator: Fix trivial language typos
      regulator: s2mps11: Fix steps for buck7, buck8 and LDO35

Linus Walleij (4):
      regulator: gpio: Convert to use descriptors
      regulator: fixed/gpio: Pull inversion/OD into gpiolib
      regulator: gpio: Simplify probe path
      regulator: core: Only support passing enable GPIO descriptors

Marc Gonzalez (1):
      regulator: core: Log forbidden DRMS operation

Mark Brown (5):
      Merge branch 'regulator-4.21' into regulator-5.0
      Merge branch 'regulator-5.0' into regulator-5.1 stpmic1 const/range
      Merge branch 'for-5.0' of https://git.kernel.org/.../broonie/regulator into regulator-5.1
      Merge branch 'regulator-5.0' into regulator-linus
      Merge branch 'regulator-5.1' into regulator-next

Mark Zhang (1):
      regulator: max77620: Initialize values for DT properties

Masahiro Yamada (1):
      regulator: core: remove unused rdev_get_supply()

Mathieu Othacehe (1):
      .mailmap: Add Mathieu Othacehe

Matti Vaittinen (6):
      regulator: bd70528: Support ROHM BD70528 regulator block
      regulator: bindings: ROHM bd70528 regulator bindings
      regulator: bd70528: drop struct bd70528
      devicetree: bindings: bd718x7: document HW state related ROHM specific properties
      regulator: add regulator_desc_list_voltage_linear_range
      regulator: bd718x7: Support SNVS low power state

Niklas Cassel (2):
      regulator: core: Take lock before applying system load
      regulator: core: Drop lockdep annotation in drms_uA_update()

Ondrej Jirman (1):
      regulator: axp20x: fix DCDCB and BLDO2 definitions for AXP806

Otavio Salvador (1):
      regulator: rk808: Fix BUCK1/2 voltages on rk805

Pascal PAILLET-LME (8):
      regulator: stpmic1: Use regulator mode definition from bindings
      dt-bindings: regulator: remove interrupt-parent description on stpmic1
      regulator: stpmic1: Simplify regulators registration
      dt-bindings: regulator: remove regulator pull-down support for stpmic1
      regulator: stpmic1: Remove support for regulator pull down
      dt-bindings: regulator: Add active discharge support for stpmic1
      regulator: stpmic1: Add active discharge support
      regulator: stpmic1: Change buck1 voltage range

Rob Herring (3):
      regulator: dt-bindings: Convert fixed-regulator to json-schema
      regulator: mc13xxx: Use lowercase regulator names to match the DT
      regulator: da9052: Use lowercase regulator names to match the DT

Stuart Menefy (1):
      regulator: s2mpa01: Fix step values for some LDOs

Vasily Khoruzhick (2):
      regulator: axp20x: fix ALDO2, DLDO2 and ELDO3 definitions for AXP803
      regulator: axp20x: fix ALDO2, DLDO2 and ELDO3 definitions for AXP803

 .mailmap                                           |   1 +
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |  17 +
 .../devicetree/bindings/regulator/fan53555.txt     |   3 +-
 .../bindings/regulator/fixed-regulator.txt         |  35 --
 .../bindings/regulator/fixed-regulator.yaml        |  67 +++
 .../bindings/regulator/max77650-regulator.txt      |  41 ++
 .../devicetree/bindings/regulator/pfuze100.txt     |   2 +-
 .../bindings/regulator/rohm,bd70528-regulator.txt  |  68 +++
 .../bindings/regulator/rohm,bd71837-regulator.txt  |  38 ++
 .../bindings/regulator/st,stpmic1-regulator.txt    |   6 +-
 .../devicetree/bindings/regulator/tps65218.txt     |   9 +-
 arch/arm/mach-imx/mach-mx21ads.c                   |   1 -
 arch/arm/mach-imx/mach-mx27ads.c                   |   2 +-
 arch/arm/mach-mmp/brownstone.c                     |   1 -
 arch/arm/mach-omap1/board-ams-delta.c              |   2 -
 arch/arm/mach-omap2/pdata-quirks.c                 |   1 -
 arch/arm/mach-pxa/em-x270.c                        |   1 -
 arch/arm/mach-pxa/ezx.c                            |   3 +-
 arch/arm/mach-pxa/hx4700.c                         |  23 +-
 arch/arm/mach-pxa/magician.c                       |  23 +-
 arch/arm/mach-pxa/raumfeld.c                       |   1 -
 arch/arm/mach-pxa/zeus.c                           |   3 +-
 arch/arm/mach-sa1100/assabet.c                     |   1 -
 arch/sh/boards/mach-ecovec24/setup.c               |   2 -
 .../intel-mid/device_libs/platform_bcm43xx.c       |   1 -
 drivers/regulator/88pm8607.c                       |  38 +-
 drivers/regulator/Kconfig                          |  27 +-
 drivers/regulator/Makefile                         |   2 +
 drivers/regulator/act8865-regulator.c              |   5 +-
 drivers/regulator/act8945a-regulator.c             |  11 +-
 drivers/regulator/arizona-ldo1.c                   |  56 +--
 drivers/regulator/as3722-regulator.c               |   2 +-
 drivers/regulator/axp20x-regulator.c               |  27 +-
 drivers/regulator/bcm590xx-regulator.c             |   4 +
 drivers/regulator/bd70528-regulator.c              | 289 ++++++++++++
 drivers/regulator/bd718x7-regulator.c              | 215 +++++++--
 drivers/regulator/bd9571mwv-regulator.c            |   8 +-
 drivers/regulator/core.c                           |  88 ++--
 drivers/regulator/cpcap-regulator.c                | 106 +++--
 drivers/regulator/da9052-regulator.c               |  64 +--
 drivers/regulator/da9055-regulator.c               |  46 +-
 drivers/regulator/da9062-regulator.c               |  37 +-
 drivers/regulator/da9063-regulator.c               |  37 +-
 drivers/regulator/da9210-regulator.c               |  53 +--
 drivers/regulator/fan53555.c                       | 109 ++++-
 drivers/regulator/fixed.c                          |  35 +-
 drivers/regulator/gpio-regulator.c                 | 194 +++-----
 drivers/regulator/helpers.c                        | 125 +++++-
 drivers/regulator/hi655x-regulator.c               |   1 -
 drivers/regulator/isl6271a-regulator.c             |  13 +-
 drivers/regulator/lm363x-regulator.c               |   6 +-
 drivers/regulator/lochnagar-regulator.c            |   7 +-
 drivers/regulator/lp3971.c                         |   4 +-
 drivers/regulator/lp3972.c                         |   4 +-
 drivers/regulator/lp872x.c                         |  82 +---
 drivers/regulator/lp873x-regulator.c               |  51 +--
 drivers/regulator/lp8755.c                         |   6 +-
 drivers/regulator/lp87565-regulator.c              |   4 +-
 drivers/regulator/lp8788-buck.c                    |  40 +-
 drivers/regulator/lp8788-ldo.c                     |   4 +-
 drivers/regulator/ltc3676.c                        |  65 +--
 drivers/regulator/max14577-regulator.c             |   1 -
 drivers/regulator/max77620-regulator.c             |  12 +-
 drivers/regulator/max77650-regulator.c             | 498 +++++++++++++++++++++
 drivers/regulator/max77802-regulator.c             |   6 +-
 drivers/regulator/mc13783-regulator.c              |  82 ++--
 drivers/regulator/mc13892-regulator.c              |  72 +--
 drivers/regulator/mc13xxx-regulator-core.c         |   4 +-
 drivers/regulator/mc13xxx.h                        |  24 +-
 drivers/regulator/mcp16502.c                       |   2 +-
 drivers/regulator/mt6311-regulator.c               |  10 +-
 drivers/regulator/of_regulator.c                   |   4 +-
 drivers/regulator/palmas-regulator.c               |   2 +-
 drivers/regulator/pv88060-regulator.c              |  62 +--
 drivers/regulator/pv88080-regulator.c              |  55 +--
 drivers/regulator/pv88090-regulator.c              |  53 +--
 drivers/regulator/pwm-regulator.c                  |  17 +-
 drivers/regulator/qcom_smd-regulator.c             | 104 +++--
 drivers/regulator/rk808-regulator.c                |  64 +--
 drivers/regulator/rt5033-regulator.c               |   4 +-
 drivers/regulator/s2mpa01.c                        |  10 +-
 drivers/regulator/s2mps11.c                        |   6 +-
 drivers/regulator/s5m8767.c                        |   8 +-
 drivers/regulator/stm32-vrefbuf.c                  | 121 ++++-
 drivers/regulator/stpmic1_regulator.c              | 300 ++++++-------
 drivers/regulator/tps65218-regulator.c             |  23 +-
 drivers/regulator/twl-regulator.c                  |   7 +-
 drivers/regulator/twl6030-regulator.c              |  88 ++--
 drivers/regulator/uniphier-regulator.c             |   8 +-
 drivers/regulator/wm831x-dcdc.c                    |  85 +---
 include/linux/mfd/tps65218.h                       |   3 +-
 include/linux/regulator/driver.h                   |  30 +-
 include/linux/regulator/fixed.h                    |  10 -
 include/linux/regulator/gpio-regulator.h           |  18 +-
 94 files changed, 2489 insertions(+), 1521 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/fixed-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
 create mode 100644 drivers/regulator/bd70528-regulator.c
 create mode 100644 drivers/regulator/max77650-regulator.c

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx9U4YACgkQJNaLcl1U
h9CKPwf9Ewk6G3jtAeNQRUsqFjKcb1kDH2M46qgWrWo8lDZWQh3YTu1oVf/kSSBt
UzaNOMlTVMDOCzbIDak8zg/AbmqJ6hmEtVi+33RHRsC52z51aYTsjL0PF80TPkA+
OkpL3koqFHXkVtOkmkOtlTRnXnufegxdHraDRgpdjU4vXbshW8M5ggblFaKDxWdT
5YdP/oluvhLnlehKq8GNGLgOVcBEOzy7YFg7zH52eKroCro/y/PmVBLMCAYturgK
orVkSQrA8fv4QFc34vBMKfKRppfcetlQsTntN+7NIMg7fOYpSVjD3seDSW1R4OKQ
2TOVziA+Sja8v4lEfcw6jUV8PuRQrQ==
=9nec
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
