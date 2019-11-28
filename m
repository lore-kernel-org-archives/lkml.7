Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A24C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6119721771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfK1Omn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:42:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:52693 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfK1Omm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:42:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 06:42:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,253,1571727600"; 
   d="scan'208";a="383840722"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2019 06:42:39 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iaL0A-0007Ts-Tr; Thu, 28 Nov 2019 16:42:38 +0200
Date:   Thu, 28 Nov 2019 16:42:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.5-1
Message-ID: <20191128144238.GA28738@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Luckily this cycle is not a busiest one and I had time to handle it.
This is a bunch of PDx86 updates for v5.5. It has the following duplicates
due to earlier sent fixes during v5.4:

- e3008bf46ce0baf617cfd1b68d35e433dc603e43 platform/x86: classmate-laptop: remove unused variable
- da5fb83fb8dc5f95d4ab3a9f4641821fab34ce58 platform/x86: intel_punit_ipc: Avoid error message when retrieving IRQ
- d17f1bbb3aa9631429fa0fe325ad12661d6b226b platform/x86: i2c-multi-instantiate: Fail the probe if no IRQ provided

During test merge no conflicts were found.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.5-1

for you to fetch changes up to f3e4f3fc8ee9729c4b1b27a478c68b713df53c0c:

  platform/x86: hp-wmi: Fix ACPI errors caused by passing 0 as input size (2019-11-25 12:59:17 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.5-1

* New bootctl driver for Mellanox BlueField SoC.

* New driver to support System76 laptops.

* Temperature monitoring and fan control on Acer Aspire 7551
  is now supported.

* Previously the Huawei driver handled only hotkeys.
  After the conversion to WMI it has been expanded
  to support newer laptop models.

* Big refactoring of intel-speed-select tools allows to
  use it on Intel CascadeLake-N systems.

* Touchscreen support for ezpad 6 m4 and
  Schneider SCT101CTM tablets

* Miscellaneous clean ups and fixes here and there.

The following is an automated git shortlog grouped by driver:

acerhdf:
 -  Add support for Acer Aspire 7551
 -  Rename Peter Feuerer to Peter Kaestle

Add System76 ACPI driver:
 - Add System76 ACPI driver

asus-laptop:
 -  switch to using polled mode of input devices

classmate-laptop:
 -  remove unused variable

dell-laptop:
 -  disable kbd backlight on Inspiron 10xx

hdaps:
 -  switch to using polled mode of input devices

hp-wmi:
 -  Fix ACPI errors caused by passing 0 as input size
 -  Fix ACPI errors caused by too small buffer

huawei-wmi:
 -  Remove unnecessary battery mutex
 -  No need to check for battery name
 -  Stricter battery thresholds set
 -  Fix a precision vs width printf bug
 -  Avoid use of global variable when possible
 -  No need to keep pointer to platform device
 -  Don't leak memory on the exit
 -  huawei_wmi can be static
 -  Add debugfs support
 -  Add fn-lock support
 -  Add battery charging thresholds
 -  Implement huawei wmi management
 -  Add quirks and module parameters
 -  Move to platform driver

i2c-multi-instantiate:
 -  Fail the probe if no IRQ provided

intel_cht_int33fe:
 -  Split code to Micro-B and Type-C

intel_int0002_vgpio:
 -  Pass irqchip when adding gpiochip

intel_pmc_core:
 -  Add Comet Lake (CML) platform support to intel_pmc_core driver
 -  Fix the SoC naming inconsistency

intel_punit_ipc:
 -  Drop useless label
 -  use devm_platform_ioremap_resource() to simplify code
 -  Avoid error message when retrieving IRQ

peaq-wmi:
 -  switch to using polled mode of input devices

platform/mellanox:
 -  Fix Kconfig indentation
 -  Add bootctl driver for Mellanox BlueField Soc

tools/power/x86/intel-speed-select:
 -  Display TRL buckets for just base config level
 -  Ignore missing config level
 -  Increment version
 -  Use core count for base-freq mask
 -  Support platform with limited Intel(R) Speed Select
 -  Use Frequency weight for CLOS
 -  Make CLOS frequency in MHz
 -  Use mailbox for CLOS_PM_QOS_CONFIG
 -  Auto mode for CLX
 -  Correct CLX-N frequency units
 -  Change display of "avx" to "avx2"
 -  Extend command set for perf-profile
 -  Implement base-freq commands on CascadeLake-N
 -  Implement 'perf-profile info' on CascadeLake-N
 -  Implement CascadeLake-N help and command functions structures
 -  Add check for CascadeLake-N models
 -  Make process_command generic
 -  Add int argument to command functions
 -  Refuse to disable core-power when getting used
 -  Turbo-freq feature auto mode
 -  Base-freq feature auto mode
 -  Remove warning for unused result

toshiba_acpi:
 -  do not select INPUT_POLLDEV

touchscreen_dmi:
 -  Add info for the ezpad 6 m4 tablet
 -  Add touchscreen platform data for the Schneider SCT101CTM tablet

----------------------------------------------------------------
Andy Shevchenko (7):
      platform/x86: intel_punit_ipc: Avoid error message when retrieving IRQ
      platform/x86: i2c-multi-instantiate: Fail the probe if no IRQ provided
      platform/x86: huawei-wmi: Don't leak memory on the exit
      platform/x86: huawei-wmi: No need to keep pointer to platform device
      platform/x86: huawei-wmi: Avoid use of global variable when possible
      platform/x86: intel_punit_ipc: use devm_platform_ioremap_resource() to simplify code
      platform/x86: intel_punit_ipc: Drop useless label

Ayman Bagabas (9):
      platform/x86: huawei-wmi: Move to platform driver
      platform/x86: huawei-wmi: Add quirks and module parameters
      platform/x86: huawei-wmi: Implement huawei wmi management
      platform/x86: huawei-wmi: Add battery charging thresholds
      platform/x86: huawei-wmi: Add fn-lock support
      platform/x86: huawei-wmi: Add debugfs support
      platform/x86: huawei-wmi: Stricter battery thresholds set
      platform/x86: huawei-wmi: No need to check for battery name
      platform/x86: huawei-wmi: Remove unnecessary battery mutex

Dan Carpenter (1):
      platform/x86: huawei-wmi: Fix a precision vs width printf bug

Daniel Gorbea Ainz (1):
      Add touchscreen platform data for the Schneider SCT101CTM tablet

Dmitry Torokhov (4):
      platform/x86: asus-laptop: switch to using polled mode of input devices
      platform/x86: hdaps: switch to using polled mode of input devices
      platform/x86: peaq-wmi: switch to using polled mode of input devices
      platform/x86: toshiba_acpi: do not select INPUT_POLLDEV

Gayatri Kammela (2):
      platform/x86: intel_pmc_core: Fix the SoC naming inconsistency
      platform/x86: intel_pmc_core: Add Comet Lake (CML) platform support to intel_pmc_core driver

Hans de Goede (3):
      platform/x86: touchscreen_dmi: Add info for the ezpad 6 m4 tablet
      platform/x86: hp-wmi: Fix ACPI errors caused by too small buffer
      platform/x86: hp-wmi: Fix ACPI errors caused by passing 0 as input size

Jeremy Soller (1):
      platform/x86: Add System76 ACPI driver

Krzysztof Kozlowski (1):
      platform/mellanox: Fix Kconfig indentation

Liming Sun (1):
      platform/mellanox: Add bootctl driver for Mellanox BlueField Soc

Linus Walleij (1):
      platform/x86: intel_int0002_vgpio: Pass irqchip when adding gpiochip

Pacien TRAN-GIRARD (1):
      platform/x86: dell-laptop: disable kbd backlight on Inspiron 10xx

Peter Feuerer (1):
      platform/x86: acerhdf: Add support for Acer Aspire 7551

Peter Kaestle (1):
      treewide: Rename Peter Feuerer to Peter Kaestle

Prarit Bhargava (6):
      tools/power/x86/intel-speed-select: Add int argument to command functions
      tools/power/x86/intel-speed-select: Make process_command generic
      tools/power/x86/intel-speed-select: Add check for CascadeLake-N models
      tools/power/x86/intel-speed-select: Implement CascadeLake-N help and command functions structures
      tools/power/x86/intel-speed-select: Implement 'perf-profile info' on CascadeLake-N
      tools/power/x86/intel-speed-select: Implement base-freq commands on CascadeLake-N

Srinivas Pandruvada (16):
      tools/power/x86/intel-speed-select: Remove warning for unused result
      tools/power/x86/intel-speed-select: Base-freq feature auto mode
      tools/power/x86/intel-speed-select: Turbo-freq feature auto mode
      tools/power/x86/intel-speed-select: Refuse to disable core-power when getting used
      tools/power/x86/intel-speed-select: Extend command set for perf-profile
      tools/power/x86/intel-speed-select: Change display of "avx" to "avx2"
      tools/power/x86/intel-speed-select: Correct CLX-N frequency units
      tools/power/x86/intel-speed-select: Auto mode for CLX
      tools/power/x86/intel-speed-select: Use mailbox for CLOS_PM_QOS_CONFIG
      tools/power/x86/intel-speed-select: Make CLOS frequency in MHz
      tools/power/x86/intel-speed-select: Use Frequency weight for CLOS
      tools/power/x86/intel-speed-select: Support platform with limited Intel(R) Speed Select
      tools/power/x86/intel-speed-select: Use core count for base-freq mask
      tools/power/x86/intel-speed-select: Increment version
      tools/power/x86/intel-speed-select: Ignore missing config level
      tools/power/x86/intel-speed-select: Display TRL buckets for just base config level

Yauhen Kharuzhy (1):
      platform/x86: intel_cht_int33fe: Split code to Micro-B and Type-C

kbuild test robot (1):
      platform/x86: huawei-wmi: huawei_wmi can be static

yu kuai (1):
      platform/x86: classmate-laptop: remove unused variable

 .../ABI/testing/sysfs-platform-mellanox-bootctl    |   58 ++
 MAINTAINERS                                        |   10 +-
 drivers/platform/mellanox/Kconfig                  |   16 +-
 drivers/platform/mellanox/Makefile                 |    1 +
 drivers/platform/mellanox/mlxbf-bootctl.c          |  321 +++++++
 drivers/platform/mellanox/mlxbf-bootctl.h          |  103 ++
 drivers/platform/x86/Kconfig                       |   35 +-
 drivers/platform/x86/Makefile                      |    5 +
 drivers/platform/x86/acerhdf.c                     |    7 +-
 drivers/platform/x86/asus-laptop.c                 |   71 +-
 drivers/platform/x86/classmate-laptop.c            |   12 -
 drivers/platform/x86/dell-laptop.c                 |   26 +
 drivers/platform/x86/hdaps.c                       |   40 +-
 drivers/platform/x86/hp-wmi.c                      |   10 +-
 drivers/platform/x86/huawei-wmi.c                  |  876 +++++++++++++++--
 drivers/platform/x86/i2c-multi-instantiate.c       |    1 +
 drivers/platform/x86/intel_cht_int33fe_common.c    |  147 +++
 drivers/platform/x86/intel_cht_int33fe_common.h    |   41 +
 drivers/platform/x86/intel_cht_int33fe_microb.c    |   57 ++
 ...tel_cht_int33fe.c => intel_cht_int33fe_typec.c} |   78 +-
 drivers/platform/x86/intel_int0002_vgpio.c         |   28 +-
 drivers/platform/x86/intel_pmc_core.c              |   17 +-
 drivers/platform/x86/intel_punit_ipc.c             |   51 +-
 drivers/platform/x86/peaq-wmi.c                    |   66 +-
 drivers/platform/x86/system76_acpi.c               |  384 ++++++++
 drivers/platform/x86/touchscreen_dmi.c             |   52 +
 drivers/thermal/gov_bang_bang.c                    |    2 +-
 tools/power/x86/intel-speed-select/isst-config.c   | 1014 ++++++++++++++++----
 tools/power/x86/intel-speed-select/isst-core.c     |  176 +++-
 tools/power/x86/intel-speed-select/isst-display.c  |  156 ++-
 tools/power/x86/intel-speed-select/isst.h          |    5 +
 31 files changed, 3274 insertions(+), 592 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
 create mode 100644 drivers/platform/mellanox/mlxbf-bootctl.c
 create mode 100644 drivers/platform/mellanox/mlxbf-bootctl.h
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_common.c
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_common.h
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_microb.c
 rename drivers/platform/x86/{intel_cht_int33fe.c => intel_cht_int33fe_typec.c} (82%)
 create mode 100644 drivers/platform/x86/system76_acpi.c

-- 
With Best Regards,
Andy Shevchenko


