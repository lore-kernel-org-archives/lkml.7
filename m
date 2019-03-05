Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF2EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76529204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551823492;
	bh=iM8SQUojhh1olRXbwXHzZbqKoiHQrnbTGk1r0Mw3fm0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=2QjtRKC/CM1uJwkO8pAe+N47ZqPpLrjpsI14BT0lMWtkhbBKHPLwRBEhNj+H60OH2
	 QVcINvkJw3NnyEwWcUTuHEzmvBkBpbCUxwrLiUu7BdNMDAcbIRurOJEr3+2DzrNeUa
	 cRJzsHIMoJS4knpnzYz7TSJAR1msZ3cRXSk0wHSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfCEWEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:04:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfCEWEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:04:50 -0500
Received: from earth.universe (unknown [185.216.33.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17CFF204EC;
        Tue,  5 Mar 2019 22:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551823489;
        bh=iM8SQUojhh1olRXbwXHzZbqKoiHQrnbTGk1r0Mw3fm0=;
        h=Date:From:To:Cc:Subject:From;
        b=g6IkVOdXCyi2LfT9m7O8NR/gRGKyrBSaL1VShiweYmz2PTA+k+UNvDZHX20CvETz5
         XK+u/p1Hm7+ILDKs8vE57BWisxCdglN2liX1vP1gxQcOqVTFBMU2x6aD0NivMRpjwh
         2yhhirS1Sbho301VrUg2PUc7H8o7+4qW63+1HRqI=
Received: by earth.universe (Postfix, from userid 1000)
        id 137C23C0AE0; Tue,  5 Mar 2019 23:04:47 +0100 (CET)
Date:   Tue, 5 Mar 2019 23:04:47 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.1
Message-ID: <20190305220447.e3rb3yu544kcix7m@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="42u6dioqh4w4nc63"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--42u6dioqh4w4nc63
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Nothing too fancy in the power-supply subsystem this time. There are
less patches than usual, since I did not have enough time to review
them in time. The good news is, that all patches have been in
linux-next for more than two weeks and there are no complicated
cross-subsystem patchsets this time!

-- Sebastian

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/for-v5.1

for you to fetch changes up to 655ab0bc462d1ae2aa344b1ecf35ca1a3ed726dc:

  power: reset: at91-reset: add support for sam9x60 SoC (2019-02-20 00:41:0=
1 +0100)

----------------------------------------------------------------
power supply and reset changes for the v5.1 series

* at91-reset: add sam9x60 support
* sc27xx: improve capacity logic
* goldfish_battery: enhance driver by adding many new properties
* isp1704: drop platform data and migrate to gpiod
* misc. small fixes and improvements

----------------------------------------------------------------
Arthur Demchenkov (1):
      bq27x00: use cached flags

Artur Rojek (2):
      dt-bindings: power: supply: Add voltage-max-design-microvolt property
      power: supply: core: Add a field to support battery max voltage

Baolin Wang (3):
      dt-bindings: power: sc27xx: Add one IIO channel to read charge voltage
      power: supply: sc27xx: Add one property to read charge voltage
      power: supply: sc27xx: Fix the incorrect formula when converting capa=
city to coulomb counter

Kangjie Lu (1):
      power: twl4030: fix a missing check of return value

Krzysztof Kozlowski (1):
      power: supply: charger-manager: Fix trivial language typos

Micha=C5=82 Miros=C5=82aw (1):
      power: supply: bq25890: show max charge current/voltage as configured

Nicolas Ferre (3):
      dt-bindings: arm: atmel: add missing samx7 to reset controller
      dt-bindings: arm: atmel: add new sam9x60 reset controller binding
      power: reset: at91-reset: add support for sam9x60 SoC

Pavel Machek (1):
      cpcap-charger: generate events for userspace

Roman Kiryanov (6):
      drivers: power: supply: goldfish_battery: Put an SPDX tag
      drivers: power: supply: goldfish_battery: Fix "line over 80 character=
s"
      drivers: power: supply: goldfish_battery: Retire a redundant variable
      drivers: power: supply: goldfish_battery: Fix alignment
      drivers: power: supply: goldfish_battery: Use tabs for alignment
      drivers: power: supply: goldfish_battery: Add support for reading mor=
e properties

Sebastian Reichel (1):
      power: supply: isp1704: switch to gpiod API

Sven Van Asbroeck (2):
      power: supply: ds2782: fix possible use-after-free on remove
      max17042_battery: fix potential use-after-free on device remove

Yangtao Li (2):
      power: supply: axp288_fuel_gauge: Change to use DEFINE_SHOW_ATTRIBUTE=
 macro
      power: supply: remove some duplicated includes

Yuanjiang Yu (1):
      power: supply: sc27xx: Fix capacity saving function

 .../devicetree/bindings/arm/atmel-sysregs.txt      |  3 +-
 .../devicetree/bindings/power/supply/battery.txt   |  2 +
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |  8 +-
 drivers/power/reset/at91-reset.c                   | 13 +++
 drivers/power/supply/axp288_fuel_gauge.c           | 14 +---
 drivers/power/supply/bq25890_charger.c             |  4 +-
 drivers/power/supply/bq27xxx_battery.c             | 20 +----
 drivers/power/supply/charger-manager.c             | 18 ++--
 drivers/power/supply/cpcap-charger.c               |  1 +
 drivers/power/supply/ds2782_battery.c              |  8 +-
 drivers/power/supply/goldfish_battery.c            | 88 +++++++++++++-----=
--
 drivers/power/supply/isp1704_charger.c             | 60 +++-----------
 drivers/power/supply/max17042_battery.c            | 10 +++
 drivers/power/supply/power_supply_core.c           |  5 +-
 drivers/power/supply/sc27xx_fuel_gauge.c           | 95 ++++++++++++++++++=
++--
 drivers/power/supply/twl4030_charger.c             |  4 +-
 include/linux/power/isp1704_charger.h              | 30 -------
 include/linux/power_supply.h                       |  1 +
 18 files changed, 221 insertions(+), 163 deletions(-)
 delete mode 100644 include/linux/power/isp1704_charger.h

--42u6dioqh4w4nc63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlx+8n4ACgkQ2O7X88g7
+poNmQ//Rv5dSMf2wGPI2eioEnE4VazCJhEuWtNrhVu490CGbQoQlQjPYvsLc+/v
NxbyWvMhpFfyVxnFnwbuwdrdtdnOhikSkZeoVNyIrRJ//62Z3mjiDa77eOTVWF/V
FS7hSKb8mGm7ws8crTyorzOHsCM7xOBSwhXRRAiYH60jagMDAbvhhjmt3Co0Kgqr
uImyhy7bh7vThJ9U+JSkHNPOz0x6mODeX3J3robv3ac9qApSHg/NAAWQC4Y3c7UY
cOtuS678W3ts0lS0Th6e4Ok4pS6c+K4rm6cszjDLcqFyde4N5i5ZG+pPltUD8u3Z
I/S8IEkqD5ICeOCKE1nDYvr2wDpTk3i6FHb/FuhuBae3dwPR38SpnP0jBVw/3l1b
J1Yable78FctVDlbgei8AwzPhYvXHKLdAHavZ3ARVrU2UMpWo54rhWdHk9W/eqzs
liMEt/u+kHWdzxcGaUGkhQlTTzgp0hpShCMB/SVwrBeEvImCgC2fX4vq6EUw+FSp
Oq/lqbukT2HfrzJKabgWCKeqOLMs2fNag+wJDKHQHqfKsNFXSatX7eKNkgBdJOep
b4dPsWyxCqurujtn+5CbjX3d1fEEITfc6f+qAF1kkkjli9ClAp2VeXEsk92tEky/
Vj2OUQTSAcH4a0NyeIpVM0A0szr9IRsU8j0Vm9PKrFQD1g+2D7Q=
=855+
-----END PGP SIGNATURE-----

--42u6dioqh4w4nc63--
