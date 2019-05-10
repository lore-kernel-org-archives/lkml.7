Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D0DC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316892175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfEJPkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:40:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:4613 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbfEJPkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:40:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 08:35:33 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2019 08:35:32 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hP7YZ-00058V-OG; Fri, 10 May 2019 18:35:31 +0300
Date:   Fri, 10 May 2019 18:35:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.2-1
Message-ID: <20190510153531.GA19723@smile.fi.intel.com>
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

Gathered pile of patches for Platform Drivers x86. No surprises and no merge
conflicts. Business as usual.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.2-1

for you to fetch changes up to 6456fd731517f473eac033f898d40ae76b160183:

  platform/x86: Add support for Basin Cove power button (2019-05-09 00:33:03 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v5.2-1

New driver of power button for Basin Cove PMIC.

ASUS WMI driver has got a Fn lock mode switch support.

Resolve a never end story with non working Wi-Fi on newer Lenovo Ideapad
computers. Now the black list is replaced with white list.

New facility to debug S0ix failures on Intel Atom platforms. The Intel PMC
and accompanying drivers are cleaned up.

Mellanox got a new TmFifo driver. Besides tachometer sensor and watchdog
are enabled on Mellanox platforms.

The information of embedded controller is now recognized on new Thinkpads.
Bluetooth driver on Thinkpads is blacklisted for some models.

Touchscreen DMI driver extended to support 'jumper ezpad 6 pro b' and
Myria MY8307 2-in-1.

Additionally few small fixes here and there for WMI and ACPI laptop drivers.

The following is an automated git shortlog grouped by driver:

alienware-wmi:
 -  printing the wrong error code
 -  fix kfree on potentially uninitialized pointer

asus-wmi:
 -  Add fn-lock mode switch support

dell-laptop:
 -  fix rfkill functionality

dell-rbtn:
 -  Add missing #include

ideapad-laptop:
 -  Remove no_hw_rfkill_list

intel_pmc_core:
 -  Allow to dump debug registers on S0ix failure
 -  Convert to a platform_driver
 -  Mark local function static

intel_pmc_ipc:
 -  Don't map non-used optional resources
 -  Apply same width for offset definitions
 -  Use BIT() macro
 -  adding error handling

intel_punit_ipc:
 -  Revert "Fix resource ioremap warning"

mlx-platform:
 -  Add mlx-wdt platform driver activation
 -  Add support for tachometer speed register
 -  Add TmFifo driver for Mellanox BlueField Soc

sony-laptop:
 -  Fix unintentional fall-through

thinkpad_acpi:
 -  cleanup for Thinkpad ACPI led
 -  Mark expected switch fall-throughs
 -  fix spelling mistake "capabilites" -> "capabilities"
 -  Read EC information on newer models
 -  Disable Bluetooth for some machines

touchscreen_dmi:
 -  Add info for 'jumper ezpad 6 pro b' touchscreen
 -  Add info for Myria MY8307 2-in-1

----------------------------------------------------------------
Andy Shevchenko (5):
      platform/x86: intel_pmc_ipc: Use BIT() macro
      platform/x86: intel_pmc_ipc: Apply same width for offset definitions
      platform/x86: intel_pmc_ipc: Don't map non-used optional resources
      platform/x86: intel_punit_ipc: Revert "Fix resource ioremap warning"
      platform/x86: Add support for Basin Cove power button

Benjamin Renz (1):
      platform/x86: touchscreen_dmi: Add info for 'jumper ezpad 6 pro b' touchscreen

Chris Chiu (1):
      platform/x86: asus-wmi: Add fn-lock mode switch support

Colin Ian King (2):
      platform/x86: alienware-wmi: fix kfree on potentially uninitialized pointer
      platform/x86: thinkpad_acpi: fix spelling mistake "capabilites" -> "capabilities"

Dan Carpenter (1):
      platform/x86: alienware-wmi: printing the wrong error code

Gabriel Lazar (1):
      platform/x86: touchscreen_dmi: Add info for Myria MY8307 2-in-1

Guenter Roeck (1):
      platform/x86: intel_pmc_core: Mark local function static

Gustavo A. R. Silva (2):
      platform/x86: sony-laptop: Fix unintentional fall-through
      platform/x86: thinkpad_acpi: Mark expected switch fall-throughs

Hans de Goede (1):
      platform/x86: ideapad-laptop: Remove no_hw_rfkill_list

Jiaxun Yang (2):
      platform/x86: thinkpad_acpi: Disable Bluetooth for some machines
      platform/x86: thinkpad_acpi: Read EC information on newer models

Junxiao Chang (1):
      platform/x86: intel_pmc_ipc: adding error handling

Liming Sun (1):
      platform/mellanox: Add TmFifo driver for Mellanox BlueField Soc

Mario Limonciello (1):
      platform/x86: dell-laptop: fix rfkill functionality

Pavel Machek (1):
      platform/x86: thinkpad_acpi: cleanup for Thinkpad ACPI led

Rajat Jain (2):
      platform/x86: intel_pmc_core: Convert to a platform_driver
      platform/x86: intel_pmc_core: Allow to dump debug registers on S0ix failure

Vadim Pasternak (2):
      platform/x86: mlx-platform: Add support for tachometer speed register
      platform/x86: mlx-platform: Add mlx-wdt platform driver activation

Valdis Kletnieks (1):
      platform/x86: dell-rbtn: Add missing #include

 drivers/platform/mellanox/Kconfig             |   12 +-
 drivers/platform/mellanox/Makefile            |    1 +
 drivers/platform/mellanox/mlxbf-tmfifo-regs.h |   63 ++
 drivers/platform/mellanox/mlxbf-tmfifo.c      | 1281 +++++++++++++++++++++++++
 drivers/platform/x86/Kconfig                  |   11 +
 drivers/platform/x86/Makefile                 |    1 +
 drivers/platform/x86/alienware-wmi.c          |   19 +-
 drivers/platform/x86/asus-wmi.c               |   37 +
 drivers/platform/x86/dell-laptop.c            |    6 +-
 drivers/platform/x86/dell-rbtn.c              |    2 +
 drivers/platform/x86/ideapad-laptop.c         |  321 +------
 drivers/platform/x86/intel_mrfld_pwrbtn.c     |  107 +++
 drivers/platform/x86/intel_pmc_core.c         |  172 +++-
 drivers/platform/x86/intel_pmc_core.h         |    7 +
 drivers/platform/x86/intel_pmc_ipc.c          |   46 +-
 drivers/platform/x86/intel_punit_ipc.c        |    8 +-
 drivers/platform/x86/mlx-platform.c           |  228 ++++-
 drivers/platform/x86/sony-laptop.c            |    8 +-
 drivers/platform/x86/thinkpad_acpi.c          |  146 ++-
 drivers/platform/x86/touchscreen_dmi.c        |   51 +
 include/linux/platform_data/x86/asus-wmi.h    |    1 +
 21 files changed, 2147 insertions(+), 381 deletions(-)
 create mode 100644 drivers/platform/mellanox/mlxbf-tmfifo-regs.h
 create mode 100644 drivers/platform/mellanox/mlxbf-tmfifo.c
 create mode 100644 drivers/platform/x86/intel_mrfld_pwrbtn.c

-- 
With Best Regards,
Andy Shevchenko


