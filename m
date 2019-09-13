Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE2EC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3AF20830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfIMRG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 13:06:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:54859 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfIMRG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 13:06:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 10:06:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="336954836"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 13 Sep 2019 10:06:56 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i8p27-0007jY-K7; Fri, 13 Sep 2019 20:06:55 +0300
Date:   Fri, 13 Sep 2019 20:06:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.4-1
Message-ID: <20190913170655.GA29705@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Set of changes of PDx86 for v5.4. No conflicts with recent origin/master.
Pity, but I have to move the status from Maintained to Odd Fixes.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit f14312a93b34b9350dc33ff0b4215c24f4c82617:

  platform/x86: pcengines-apuv2: use KEY_RESTART for front button (2019-07-29 18:24:59 +0300)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.4-1

for you to fetch changes up to f690790c9da3122dd7ee1b0d64d97973a7c34135:

  MAINTAINERS: Switch PDx86 subsystem status to Odd Fixes (2019-09-12 17:36:42 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v5.4-1

* ASUS WMI driver got couple of worth to mention updates, i.e. support of
  FAN is fixed for recent products and the charge threshold support has been
  added.

* Two uknown key events for Dell laptops are being ignored now to avoid spam
  user with harmless messages.

* HP ZBook 17 G5 and ASUS Zenbook UX430UNR have got accelerometer support.

* Intel CherryTrail platforms got a regression with wake up. Now it's fixed.

* Intel PMC driver got fixed in order to work nicely in Xen environment.

* Intel Speed Select driver provides bucket vs core count relationship.
  Besides that the tools has been updated for better output.

* The PrivacyGuard is enabled on Lenovo ThinkPad laptops.

* Three tablets, i.e. Trekstor Primebook C11B 2-in-1, Irbis TW90 and
  Chuwi Surbook Mini, have got touchscreen support.

The following is an automated git shortlog grouped by driver:

acer-wmi:
 -  Switch to acpi_dev_get_first_match_dev()

asus-nb-wmi:
 -  Support ALS on the Zenbook UX430UNR

asus-wmi:
 -  Refactor charge threshold to use the battery hooking API
 -  Rename CHARGE_THRESHOLD to RSOC
 -  Reorder ASUS_WMI_CHARGE_THRESHOLD
 -  Fix condition in charge_threshold_store()
 -  Remove unnecessary blank lines
 -  Drop indentation level by inverting conditionals
 -  Use clamp_val() instead of open coded variant
 -  Replace sscanf() with kstrtoint()
 -  Refactor charge_threshold_store()
 -  Add support for charge threshold
 -  fix CPU fan control on recent products
 -  add a helper for device presence
 -  cleanup AGFN fan handling
 -  Use kmemdup rather than duplicating its implementation

compal-laptop:
 -  Initialize "value" in ec_read_u8()

dell-wmi:
 -  Use existing defined KBD_LED_* magic values
 -  Ignore keyboard backlight change KBD_LED_AUTO_TOKEN
 -  Ignore keyboard backlight change KBD_LED_ON_TOKEN

hp_accel:
 -  Add support for HP ZBook 17 G5

i2c-multi-instantiate:
 -  Use struct_size() helper

intel_bxtwc_tmu:
 -  Remove dev_err() usage after platform_get_irq()

intel_int0002_vgpio:
 -  Use device_init_wakeup
 -  Fix wakeups not working on Cherry Trail
 -  Remove dev_err() usage after platform_get_irq()

intel_pmc_core:
 -  Do not ioremap RAM

intel_pmc_core_pltdrv:
 -  Module removal warning fix

intel_pmc_ipc:
 -  Remove dev_err() usage after platform_get_irq()

ISST:
 -  Allow additional TRL MSRs
 -  Use dev_get_drvdata

MAINTAINERS:
 -  Switch PDx86 subsystem status to Odd Fixes

pcengines-apuv2:
 -  wire up simswitch gpio as led
 -  add mpcie reset gpio export

platform/mellanox:
 -  mlxreg-hotplug: Remove dev_err() usage after platform_get_irq()

pmc_atom:
 -  Add Siemens SIMATIC IPC227E to critclk_systems DMI table

thinkpad_acpi:
 -  Add ThinkPad PrivacyGuard
 -  Use kmemdup rather than duplicating its implementation

tools/power/x86/intel-speed-select:
 -  Display core count for bucket
 -  Fix memory leak
 -  Output success/failed for command output
 -  Output human readable CPU list
 -  Change turbo ratio output to maximum turbo frequency
 -  Switch output to MHz
 -  Simplify output for turbo-freq and base-freq
 -  Fix cpu-count output
 -  Fix help option typo
 -  Fix package typo
 -  Fix a read overflow in isst_set_tdp_level_msr()

touchscreen_dmi:
 -  Add info for the Trekstor Primebook C11B 2-in-1
 -  Add info for the Irbis TW90 tablet
 -  Add info for the Chuwi Surbook Mini tablet

wmi:
 -  Remove acpi_has_method() call

----------------------------------------------------------------
Alexander Schremmer (1):
      platform/x86: thinkpad_acpi: Add ThinkPad PrivacyGuard

Andy Shevchenko (8):
      platform/x86: acer-wmi: Switch to acpi_dev_get_first_match_dev()
      platform/x86: i2c-multi-instantiate: Use struct_size() helper
      platform/x86: asus-wmi: Refactor charge_threshold_store()
      platform/x86: asus-wmi: Replace sscanf() with kstrtoint()
      platform/x86: asus-wmi: Use clamp_val() instead of open coded variant
      platform/x86: asus-wmi: Drop indentation level by inverting conditionals
      platform/x86: asus-wmi: Remove unnecessary blank lines
      MAINTAINERS: Switch PDx86 subsystem status to Odd Fixes

Chuhong Yuan (1):
      platform/x86: ISST: Use dev_get_drvdata

Dan Carpenter (2):
      platform/x86: asus-wmi: Fix condition in charge_threshold_store()
      tools/power/x86/intel-speed-select: Fix a read overflow in isst_set_tdp_level_msr()

Daniel Drake (3):
      platform/x86: asus-wmi: cleanup AGFN fan handling
      platform/x86: asus-wmi: add a helper for device presence
      platform/x86: asus-wmi: fix CPU fan control on recent products

Enrico Weigelt (1):
      platform/x86: pcengines-apuv2: wire up simswitch gpio as led

Florian Eckert (1):
      platform/x86: pcengines-apuv2: add mpcie reset gpio export

Fuqian Huang (2):
      platform/x86: asus-wmi: Use kmemdup rather than duplicating its implementation
      platform/x86: thinkpad_acpi: Use kmemdup rather than duplicating its implementation

Giang Le (1):
      platform/x86: touchscreen_dmi: Add info for the Chuwi Surbook Mini tablet

Hans de Goede (4):
      platform/x86: touchscreen_dmi: Add info for the Irbis TW90 tablet
      platform/x86: touchscreen_dmi: Add info for the Trekstor Primebook C11B 2-in-1
      platform/x86: intel_int0002_vgpio: Fix wakeups not working on Cherry Trail
      platform/x86: intel_int0002_vgpio: Use device_init_wakeup

Jan Kiszka (1):
      platform/x86: pmc_atom: Add Siemens SIMATIC IPC227E to critclk_systems DMI table

Kai-Heng Feng (1):
      platform/x86: hp_accel: Add support for HP ZBook 17 G5

Kelsey Skunberg (1):
      platform/x86: wmi: Remove acpi_has_method() call

Kristian Klausen (5):
      platform/x86: asus-nb-wmi: Support ALS on the Zenbook UX430UNR
      platform/x86: asus-wmi: Add support for charge threshold
      platform/x86: asus-wmi: Reorder ASUS_WMI_CHARGE_THRESHOLD
      platform/x86: asus-wmi: Rename CHARGE_THRESHOLD to RSOC
      platform/x86: asus-wmi: Refactor charge threshold to use the battery hooking API

M. Vefa Bicakci (2):
      platform/x86: intel_pmc_core: Do not ioremap RAM
      platform/x86: intel_pmc_core_pltdrv: Module removal warning fix

Prarit Bhargava (9):
      tools/power/x86/intel-speed-select: Fix package typo
      tools/power/x86/intel-speed-select: Fix help option typo
      tools/power/x86/intel-speed-select: Fix cpu-count output
      tools/power/x86/intel-speed-select: Simplify output for turbo-freq and base-freq
      tools/power/x86/intel-speed-select: Switch output to MHz
      tools/power/x86/intel-speed-select: Change turbo ratio output to maximum turbo frequency
      tools/power/x86/intel-speed-select: Output human readable CPU list
      tools/power/x86/intel-speed-select: Output success/failed for command output
      tools/power/x86/intel-speed-select: Fix memory leak

Rhys Kidd (3):
      platform/x86: dell-wmi: Ignore keyboard backlight change KBD_LED_ON_TOKEN
      platform/x86: dell-wmi: Ignore keyboard backlight change KBD_LED_AUTO_TOKEN
      platform/x86: dell-wmi: Use existing defined KBD_LED_* magic values

Srinivas Pandruvada (2):
      platform/x86: ISST: Allow additional TRL MSRs
      tools/power/x86/intel-speed-select: Display core count for bucket

Stephen Boyd (4):
      platform/x86: intel_pmc_ipc: Remove dev_err() usage after platform_get_irq()
      platform/mellanox: mlxreg-hotplug: Remove dev_err() usage after platform_get_irq()
      platform/x86: intel_bxtwc_tmu: Remove dev_err() usage after platform_get_irq()
      platform/x86: intel_int0002_vgpio: Remove dev_err() usage after platform_get_irq()

Yizhuo (1):
      platform/x86: compal-laptop: Initialize "value" in ec_read_u8()

 .../admin-guide/laptops/thinkpad-acpi.rst          |  23 +
 MAINTAINERS                                        |   2 +-
 drivers/platform/mellanox/mlxreg-hotplug.c         |   5 +-
 drivers/platform/x86/acer-wmi.c                    |  49 +-
 drivers/platform/x86/asus-nb-wmi.c                 |   9 +
 drivers/platform/x86/asus-wmi.c                    | 534 +++++++++++++--------
 drivers/platform/x86/compal-laptop.c               |   2 +-
 drivers/platform/x86/dell-wmi.c                    |  12 +-
 drivers/platform/x86/hp_accel.c                    |   1 +
 drivers/platform/x86/i2c-multi-instantiate.c       |   4 +-
 drivers/platform/x86/intel_bxtwc_tmu.c             |   5 +-
 drivers/platform/x86/intel_int0002_vgpio.c         |  15 +-
 drivers/platform/x86/intel_pmc_core.c              |   8 +-
 drivers/platform/x86/intel_pmc_core_pltdrv.c       |   8 +
 drivers/platform/x86/intel_pmc_ipc.c               |   4 +-
 .../x86/intel_speed_select_if/isst_if_common.c     |   2 +
 .../x86/intel_speed_select_if/isst_if_mmio.c       |   8 +-
 drivers/platform/x86/pcengines-apuv2.c             |  13 +-
 drivers/platform/x86/pmc_atom.c                    |   7 +
 drivers/platform/x86/thinkpad_acpi.c               | 122 ++++-
 drivers/platform/x86/touchscreen_dmi.c             |  58 +++
 drivers/platform/x86/wmi.c                         |   4 +-
 include/linux/platform_data/x86/asus-wmi.h         |   8 +-
 tools/power/x86/intel-speed-select/isst-config.c   |  21 +-
 tools/power/x86/intel-speed-select/isst-core.c     |  26 +-
 tools/power/x86/intel-speed-select/isst-display.c  | 126 +++--
 tools/power/x86/intel-speed-select/isst.h          |   1 +
 27 files changed, 728 insertions(+), 349 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


