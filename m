Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AC9C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4322D20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574688055;
	bh=nS5pH1uixntvQ9oOj648sDAnIBDwE7SVI19fBjULy4o=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=poKoAqkSlNBvlubxcZBT/70OIoaEkASWBljOFTxyXXrop91UreYnX4tkGSN15msof
	 5wYI4Y4x0NoUhCLZ0JgodjWDMIrcWx9Ok8NKF2aNV7HCch9q0pGfEKYjj4URAVFc30
	 iUTi7indL9SjeIq82OoEuOR/1YJkxDft3rhrG8Gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfKYNUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:20:54 -0500
Received: from foss.arm.com ([217.140.110.172]:50378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfKYNUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:20:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 166C131B;
        Mon, 25 Nov 2019 05:20:52 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 869663F68E;
        Mon, 25 Nov 2019 05:20:51 -0800 (PST)
Date:   Mon, 25 Nov 2019 13:20:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator updates for v5.5
Message-ID: <20191125132049.GC4535@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
X-Cookie: -- Owen Meredith
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit af42d3466bdc8f39806b26f593604fdc54140bcb:

  Linux 5.4-rc8 (2019-11-17 14:47:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tag=
s/regulator-v5.5

for you to fetch changes up to a21da94f617bce0771144ea8093b6987184b38d0:

  Merge branch 'regulator-5.5' into regulator-next (2019-11-22 19:56:20 +00=
00)

----------------------------------------------------------------
regulator: Updates for v5.5

Another fairly quiet release for the regulator API, some work all around
including some core work but mostly in specialist or driver specific
code:

 - Fix for powering off boot-on regulators.
 - Enhancements to the coupled regulator support introduced in the last
   release.
 - Conversion of a bunch of drivers to the fwnode API for GPIOs.
 - Mode support for DA9062.
 - New device support for Qualcomm PM1650, PM8004 and PM895 and Silergy
   SR83X.
 - Removal of obsolete AB8505 support.

----------------------------------------------------------------
Andreas Kemnade (1):
      regulator: rn5t618: fix rc5t619 ldo10 enable

Angelo G. Del Regno (3):
      regulator: qcom_spmi: Add PM8950 SPMI regulator
      regulator: qcom_smd: Add PM8950 regulators
      regulator: qcom_spmi: Add support for PM8004 regulators

Axel Lin (9):
      regulator: pbias: Use of_device_get_match_data
      regulator: da9063: Simplify da9063_buck_set_mode for BUCK_MODE_MANUAL=
 case
      regulator: da9062: Simplify the code iterating all regulators
      regulator: pbias: Get rid of struct pbias_regulator_data
      regulator: rk808: Constify rk817 regulator_ops
      regulator: rk808: Fix warning message in rk817_set_ramp_delay
      regulator: rk808: Remove rk817_set_suspend_voltage function
      regulator: da9062: Simplify da9062_buck_set_mode for BUCK_MODE_MANUAL=
 case
      regulator: da9062: Return REGULATOR_MODE_INVALID for invalid mode

Christoph Fritz (3):
      regulator: da9062: refactor buck modes into header
      regulator: da9062: add of_map_mode support for bucks
      dt-bindings: mfd: da9062: describe buck modes

Dmitry Osipenko (2):
      regulator: core: Release coupled_rdevs on regulator_init_coupling() e=
rror
      regulator: core: Allow generic coupling only for always-on regulators

Dmitry Torokhov (9):
      gpiolib: introduce devm_fwnode_gpiod_get_index()
      gpiolib: introduce fwnode_gpiod_get_index()
      regulator: s5m8767: switch to using devm_fwnode_gpiod_get
      regulator: slg51000: switch to using fwnode_gpiod_get_index
      regulator: tps65090: switch to using devm_fwnode_gpiod_get
      regulator: s2mps11: switch to using devm_fwnode_gpiod_get
      regulator: da9211: switch to using devm_fwnode_gpiod_get
      regulator: tps65132: switch to using devm_fwnode_gpiod_get()
      regulator: max77686: switch to using fwnode_gpiod_get_index

Douglas Anderson (1):
      regulator: Document "regulator-boot-on" binding more thoroughly

Guido G=FCnther (1):
      regulator: bd718x7: Add MODULE_ALIAS()

Kiran Gunda (2):
      regulator: dt-bindings: Add PM6150x compatibles
      regulator: qcom-rpmh: add PM6150/PM6150L regulator support

Krzysztof Kozlowski (1):
      regulator: Fix Kconfig indentation

Mark Brown (4):
      Merge branch 'ib-fwnode-gpiod-get-index' of git://git.kernel.org/.../=
linusw/linux-gpio into regulator-5.5
      Merge branch 'regulator-5.4' into regulator-5.5
      Merge branch 'regulator-5.4' into regulator-linus
      Merge branch 'regulator-5.5' into regulator-next

Matti Vaittinen (1):
      regulator: bd70528: Add MODULE_ALIAS to allow module auto loading

Pascal Paillet (2):
      regulator: core: Let boot-on regulators be powered off
      regulator: stpmic1: Set a default ramp delay value

Peng Fan (2):
      dt-bindings: regulator: fixed: add off-on-delay-us property
      regulator: fixed: add off-on-delay

Pragnesh Patel (1):
      fixed-regulator: dt-bindings: Fixed building error for compatible pro=
perty

Saravana Kannan (1):
      regulator: core: Don't try to remove device links if add failed

Stephan Gerhold (2):
      regulator: ab8500: Remove AB8505 USB regulator
      regulator: ab8500: Remove SYSCLKREQ from enum ab8505_regulator_id

Sven Van Asbroeck (2):
      tps6105x: add optional devicetree support
      regulator: tps6105x: add optional devicetree support

Vasily Khoruzhick (1):
      regulator: fan53555: add chip id for Silergy SYR83X

Yizhuo (1):
      regulator: max8907: Fix the usage of uninitialized variable in max890=
7_regulator_probe()

YueHaibing (3):
      regulator: pcap-regulator: remove unused variable 'SW3_table'
      regulator: stm32-vrefbuf: use devm_platform_ioremap_resource() to sim=
plify code
      regulator: uniphier: use devm_platform_ioremap_resource() to simplify=
 code

zhengbin (1):
      regulator: vexpress: Use PTR_ERR_OR_ZERO() to simplify code

 Documentation/devicetree/bindings/mfd/da9062.txt   |  4 +
 .../bindings/regulator/fixed-regulator.yaml        |  4 +
 .../bindings/regulator/qcom,rpmh-regulator.txt     |  4 +
 .../bindings/regulator/qcom,smd-rpm-regulator.txt  | 21 +++++
 .../bindings/regulator/qcom,spmi-regulator.txt     | 25 ++++++
 .../devicetree/bindings/regulator/regulator.yaml   |  7 +-
 drivers/gpio/gpiolib-devres.c                      | 33 +++-----
 drivers/gpio/gpiolib.c                             | 48 +++++++++++
 drivers/mfd/tps6105x.c                             | 34 +++++++-
 drivers/regulator/Kconfig                          |  8 +-
 drivers/regulator/ab8500.c                         | 17 ----
 drivers/regulator/bd70528-regulator.c              |  1 +
 drivers/regulator/bd718x7-regulator.c              |  1 +
 drivers/regulator/core.c                           | 19 ++++-
 drivers/regulator/da9062-regulator.c               | 63 ++++++++-------
 drivers/regulator/da9063-regulator.c               |  9 +--
 drivers/regulator/da9211-regulator.c               | 12 +--
 drivers/regulator/fan53555.c                       |  2 +
 drivers/regulator/fixed.c                          |  2 +
 drivers/regulator/internal.h                       |  1 +
 drivers/regulator/max77686-regulator.c             |  5 +-
 drivers/regulator/max8907-regulator.c              | 15 +++-
 drivers/regulator/pbias-regulator.c                | 75 +++++++-----------
 drivers/regulator/pcap-regulator.c                 |  4 -
 drivers/regulator/qcom-rpmh-regulator.c            | 62 ++++++++++++++-
 drivers/regulator/qcom_smd-regulator.c             | 92 ++++++++++++++++++=
++++
 drivers/regulator/qcom_spmi-regulator.c            | 41 ++++++++++
 drivers/regulator/rk808-regulator.c                | 29 ++-----
 drivers/regulator/rn5t618-regulator.c              |  2 +-
 drivers/regulator/s2mps11.c                        |  7 +-
 drivers/regulator/s5m8767.c                        |  7 +-
 drivers/regulator/slg51000-regulator.c             | 13 ++-
 drivers/regulator/stm32-vrefbuf.c                  |  4 +-
 drivers/regulator/stpmic1_regulator.c              |  6 ++
 drivers/regulator/tps6105x-regulator.c             |  2 +
 drivers/regulator/tps65090-regulator.c             | 26 +++---
 drivers/regulator/tps65132-regulator.c             | 17 ++--
 drivers/regulator/uniphier-regulator.c             |  4 +-
 drivers/regulator/vexpress-regulator.c             |  5 +-
 .../dt-bindings/regulator/dlg,da9063-regulator.h   | 16 ++++
 include/linux/gpio/consumer.h                      | 54 ++++++++++---
 include/linux/regulator/ab8500.h                   |  3 -
 include/linux/regulator/fixed.h                    |  1 +
 43 files changed, 576 insertions(+), 229 deletions(-)
 create mode 100644 include/dt-bindings/regulator/dlg,da9063-regulator.h

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3b1TEACgkQJNaLcl1U
h9CYBQf8DLE6c1Hmi+lDtfE9UwkuRRIBJtjShuQTU5mNDwb5vK8TZufkHfOYBrss
xSVmSW0PChW+QDGqR+e7w37jNHzdHHhEzTjGN9IMSnlEE2pD2L7K1YlywdzGdJ33
+fGMxpBfSsWuAr62d+aPUs1cIHlsjoqy6lU42T9c3i9fzGrMVaCYZWuuY14EmuFB
l165rPShUHhGlVxol5HlPQbKH7NKmvdzj9qJHgKbn4wdGF34gUcUNnn4try+jEK6
Bf7SE9VmmbhlcASjW1m4g0qOJ51J14bdlJPNTGOuHh/7MrZnD3eK/up77ylIOavB
iPZH8FJSRtaJJoWqY+mJKrJAztyNuA==
=AKzk
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
