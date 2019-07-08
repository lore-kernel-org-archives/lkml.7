Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF16CC606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDE120665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562589718;
	bh=XLJ9gyzgPCcgx54klZkoKra3yEOa4Iur9TOCTqRAlA8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=eU82VtbtW3kBWJ1lSz/JHMF8A0Cyuxq8YgDcQ7zw+zn+4PFj+LpCg/evWzvYqD2IC
	 ETKJ8NuuG3nIT8VY+o6PsXh3urj/CQVp9/Un6vHl8g/+dYw1vv9UamGy2nvXikeLA+
	 yLga6O5iBzQasLdmd6Lru29STaRnqN+fVe7f7dk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfGHMl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:41:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42710 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfGHMl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gqwlo/QWRFli7SCZXqLbPGOKGbV7Fnu9bXzKCGI3EjQ=; b=kMU0DvryN43lhok8a67CISGh3
        ESrj8ktAUhi6LFKv1yaw9iattl+FFzubZkgipxv6/kPOnkeWbq75jtHAoZcVftIsmm7v640pFSZpX
        0gdkIEvxmRSwzDYjfQBa9CfvdAZqIeGtRcECfkUhiq8CPAiixQtfPR2Qpez6TL/Jjfhys=;
Received: from [217.140.106.54] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hkSxt-0000S0-Az; Mon, 08 Jul 2019 12:41:53 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 9B36DD02C61; Mon,  8 Jul 2019 13:41:52 +0100 (BST)
Date:   Mon, 8 Jul 2019 13:41:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator updates for v5.3
Message-ID: <20190708124152.GA12731@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
X-Cookie: If anything can go wrong, it will.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6fbc7275c7a9ba97877050335f290341a1fd8dbf:

  Linux 5.2-rc7 (2019-06-30 11:25:36 +0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.3

for you to fetch changes up to 0ed4513c9a32a479b4dc41685be68edf1e99c139:

  Merge remote-tracking branch 'regulator/topic/coupled' into regulator-next (2019-07-04 17:34:34 +0100)

----------------------------------------------------------------
regulator: Updates for v5.3

A couple of new features in the core, the most interesting one
being support for complex regulator coupling configurations
initially targeted at nVidia Tegra SoCs, and some new drivers but
otherwise quite a quiet release.

 - Core support for gradual ramping of voltages for devices that
   can't manage large changes in hardware from Bartosz Golaszewski.
 - Core support for systems that have complex coupling requirements
   best described via code, contributed by Dmitry Osipenko.
 - New drivers for Dialog SLG51000, Qualcomm PM8005 and ST
   Microelectronics STM32-Booster.

----------------------------------------------------------------
Anders Roxell (1):
      regulator: 88pm800: fix warning same module names

Axel Lin (4):
      regulator: core: Slightly improve readability of _regulator_get_enable_time
      regulator: max77650: Convert MAX77651 SBB1 to pickable linear range
      regulator: slg51000: Constify slg51000_regl_ops and slg51000_switch_ops
      regulator: slg51000: Remove unneeded regl_pdata from struct slg51000

Bartosz Golaszewski (3):
      regulator: max77650: add MODULE_ALIAS()
      regulator: implement selector stepping
      regulator: max77650: use vsel_step

Charles Keepax (1):
      regulator: arizona: Update device tree binding to support Madera CODECs

Colin Ian King (1):
      regulator: max77620: remove redundant assignment to variable ret

Dmitry Osipenko (3):
      regulator: max77620: Support Maxim 77663
      regulator: core: Introduce API for regulators coupling customization
      regulator: core: Expose some of core functions needed by couplers

Eric Jeong (3):
      MAINTAINERS: slg51000 updates to the Dialog Semiconductor search terms
      regulator: slg51000: add slg51000 regulator driver
      dt-bindings: regulator: add document bindings for slg51000

Fabrice Gasnier (2):
      regulator: add support for the stm32-booster
      dt-bindings: regulator: add support for the stm32-booster

Felix Riemann (1):
      regulator: da9061/62: Adjust LDO voltage selection minimum value

Geert Uytterhoeven (1):
      regulator: cpcap: Spelling s/configuraion/configuration/

Jeffrey Hugo (6):
      regulator: qcom_spmi: Refactor get_mode/set_mode
      dt-bindings: qcom_spmi: Document PM8005 regulators
      regulator: qcom_spmi: Add support for PM8005
      arm64: dts: msm8998-mtp: Add pm8005_s1 regulator
      regulator: qcom_spmi: Fix math of spmi_regulator_set_voltage_time_sel
      regulator: qcom_spmi: Do NULL check for lvs

Jorge Ramirez (2):
      dt-bindings: qcom_spmi: Document pms405 support
      regulator: qcom_spmi: add PMS405 SPMI regulator

Jorge Ramirez-Ortiz (1):
      regulator: qcom_spmi: enable linear range info

Krzysztof Kozlowski (5):
      regulator: s2mps11: Fix ERR_PTR dereference on GPIO lookup failure
      regulator: s2mps11: Reduce number of rdev_get_id() calls
      regulator: s2mps11: Add support for disabling S2MPS11 regulators in suspend
      regulator: s2mps11: Fix buck7 and buck8 wrong voltages
      regulator: s2mps11: Adjust supported buck voltages to real values

Linus Walleij (6):
      regulator: arizona-micsupp: Delete unused include
      regulator: bd70528: Drop unused include
      regulator: bd718x7: Drop unused include
      regulator: max77802: Drop unused includes
      regulator: wm831x: Convert to use GPIO descriptors
      regulator: max8952: Convert to use GPIO descriptors

Mark Brown (6):
      Merge tag 'v5.2-rc1' into regulator-5.3
      Merge tag 'v5.2-rc4' into regulator-5.3
      regulator: core: Make entire header comment C++ style
      Merge branch 'regulator-5.2' into regulator-linus
      Merge branch 'regulator-5.3' into regulator-next
      Merge remote-tracking branch 'regulator/topic/coupled' into regulator-next

Nathan Chancellor (1):
      regulator: max77650: Move max77651_SBB1_desc's declaration down

Richard Fitzgerald (2):
      regulator: arizona-ldo1: Add support for Cirrus Logic Madera codecs
      regulator: arizona-micsupp: Add support for Cirrus Logic Madera codecs

Rob Herring (3):
      regulator: Convert regulator binding to json-schema
      regulator: Convert gpio-regulator to json-schema
      regulator: Convert max8660 binding to json-schema

Waibel Georg (1):
      gpio: Fix return value mismatch of function gpiod_get_from_of_node()

Wolfram Sang (4):
      regulator: da9063: remove platform_data support
      regulator: da9063: move definitions out of a header into the driver
      regulator: da9063: platform_data is gone, depend on OF
      regulator: max8952: simplify getting the adapter of a client

 .../bindings/regulator/arizona-regulator.txt       |   3 +-
 .../bindings/regulator/fixed-regulator.yaml        |   5 +-
 .../bindings/regulator/gpio-regulator.txt          |  57 ---
 .../bindings/regulator/gpio-regulator.yaml         | 118 +++++
 .../devicetree/bindings/regulator/max8660.txt      |  47 --
 .../devicetree/bindings/regulator/max8660.yaml     |  77 +++
 .../bindings/regulator/qcom,spmi-regulator.txt     |  22 +
 .../devicetree/bindings/regulator/regulator.txt    | 140 +-----
 .../devicetree/bindings/regulator/regulator.yaml   | 200 ++++++++
 .../devicetree/bindings/regulator/slg51000.txt     |  88 ++++
 .../bindings/regulator/st,stm32-booster.txt        |  18 +
 MAINTAINERS                                        |   2 +
 arch/arm/mach-s3c64xx/mach-crag6410.c              |  21 +-
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi          |  17 +
 drivers/gpio/gpiolib.c                             |   6 +-
 .../regulator/{88pm800.c => 88pm800-regulator.c}   |   0
 drivers/regulator/Kconfig                          |  37 +-
 drivers/regulator/Makefile                         |   4 +-
 drivers/regulator/arizona-ldo1.c                   |  83 +++-
 drivers/regulator/arizona-micsupp.c                |  72 ++-
 drivers/regulator/bd70528-regulator.c              |   1 -
 drivers/regulator/bd718x7-regulator.c              |   1 -
 drivers/regulator/core.c                           | 278 ++++++++---
 drivers/regulator/cpcap-regulator.c                |   2 +-
 drivers/regulator/da9062-regulator.c               |  40 +-
 drivers/regulator/da9063-regulator.c               |  61 ++-
 drivers/regulator/da9211-regulator.c               |   2 +
 drivers/regulator/helpers.c                        |  11 +-
 drivers/regulator/max77620-regulator.c             |  28 +-
 drivers/regulator/max77650-regulator.c             | 170 ++-----
 drivers/regulator/max77802-regulator.c             |   2 -
 drivers/regulator/max8952.c                        |  64 ++-
 drivers/regulator/of_regulator.c                   |  63 ++-
 drivers/regulator/qcom_spmi-regulator.c            | 252 +++++++++-
 drivers/regulator/s2mps11.c                        | 255 +++++-----
 drivers/regulator/s5m8767.c                        |   4 +-
 drivers/regulator/slg51000-regulator.c             | 523 +++++++++++++++++++++
 drivers/regulator/slg51000-regulator.h             | 505 ++++++++++++++++++++
 drivers/regulator/stm32-booster.c                  | 132 ++++++
 drivers/regulator/tps65090-regulator.c             |   7 +-
 drivers/regulator/wm831x-dcdc.c                    |  29 +-
 include/linux/mfd/da9062/registers.h               |   3 +
 include/linux/mfd/da9063/pdata.h                   |  49 --
 include/linux/mfd/samsung/core.h                   |   1 +
 include/linux/mfd/samsung/s2mps11.h                |   9 +-
 include/linux/mfd/wm831x/pdata.h                   |   1 -
 include/linux/regulator/coupler.h                  |  97 ++++
 include/linux/regulator/driver.h                   |  12 +-
 include/linux/regulator/machine.h                  |   2 +-
 include/linux/regulator/max8952.h                  |   3 -
 50 files changed, 2862 insertions(+), 762 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/gpio-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/max8660.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/max8660.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/slg51000.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-booster.txt
 rename drivers/regulator/{88pm800.c => 88pm800-regulator.c} (100%)
 create mode 100644 drivers/regulator/slg51000-regulator.c
 create mode 100644 drivers/regulator/slg51000-regulator.h
 create mode 100644 drivers/regulator/stm32-booster.c
 create mode 100644 include/linux/regulator/coupler.h

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0jOg8ACgkQJNaLcl1U
h9DF/Af/dH9ocLBRlgKPgGSEQU0ExJIQQEF4A+129EJtpszXcxdk5n80u8k/orsS
BtK02en1dcuuJfHvcBB4F3/mJWzF+dSpRHDBa3ngSfxDWF/jqKWJWbM/RlnuWzHS
c1Gx/3/I4NxauMEfoemZ3D16Acq9AW07QOSRxgeCR7FbycsJqBDsO/n1UZ7hqhlu
ZUD2Zu7iufzHxWIk2wwhXTpRsCrucZxZYBF8OObR5glILJ1Ka/ZTBOl94IOEnKcr
4jZ+I//5rEyuqordJUV8roZmtFVILiDVWKNZ5dJy4ImRt4ooyzLnosYJgyk89Gtb
OCZIc3QPGXfaTnjoPe8COdtGPKtARA==
=aBbU
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
