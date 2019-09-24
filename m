Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D18C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90EC207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406602AbfIXH4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:56:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:31542 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388712AbfIXH4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:56:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 00:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="203324096"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2019 00:56:36 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iCfgY-0006Vo-QX; Tue, 24 Sep 2019 10:56:34 +0300
Date:   Tue, 24 Sep 2019 10:56:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.4-2
Message-ID: <20190924075634.GA25010@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Second round of PDx86 patches (last minute fixes that better to get in now than
later), no conflict with current master. The bunch has been boiled few days in
linux-next.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit f690790c9da3122dd7ee1b0d64d97973a7c34135:

  MAINTAINERS: Switch PDx86 subsystem status to Odd Fixes (2019-09-12 17:36:42 +0300)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.4-2

for you to fetch changes up to 24a8d78a9affb63e5ced313ccde6888fe96edc6e:

  platform/x86: i2c-multi-instantiate: Derive the device name from parent (2019-09-20 17:57:07 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v5.4-2

* Fix compilation error of ASUS WMI driver when CONFIG_ACPI_BATTERY=n.
* Fix I²C multi-instantiate driver to work with several USB PD devices.
* Fix boot issue on Siemens SIMATIC IPC277E when PMC critical clock is
  being disabled.
* Plenty of fixes to Intel Speed-Select Technology tools.

The following is an automated git shortlog grouped by driver:

asus-wmi:
 -  Make it depend on ACPI battery API

i2c-multi-instantiate:
 -  Derive the device name from parent

pmc_atom:
 -  Add Siemens SIMATIC IPC277E to critclk_systems DMI table

tools/power/x86/intel-speed-select:
 -  Fix perf-profile command output
 -  Extend core-power command set
 -  Fix some debug prints
 -  Format get-assoc information
 -  Allow online/offline based on tdp
 -  Fix high priority core mask over count

----------------------------------------------------------------
Andy Shevchenko (1):
      platform/x86: asus-wmi: Make it depend on ACPI battery API

Heikki Krogerus (1):
      platform/x86: i2c-multi-instantiate: Derive the device name from parent

Srikanth Krishnakar (1):
      platform/x86: pmc_atom: Add Siemens SIMATIC IPC277E to critclk_systems DMI table

Srinivas Pandruvada (5):
      tools/power/x86/intel-speed-select: Allow online/offline based on tdp
      tools/power/x86/intel-speed-select: Format get-assoc information
      tools/power/x86/intel-speed-select: Fix some debug prints
      tools/power/x86/intel-speed-select: Extend core-power command set
      tools/power/x86/intel-speed-select: Fix perf-profile command output

Youquan Song (1):
      tools/power/x86/intel-speed-select: Fix high priority core mask over count

 drivers/platform/x86/Kconfig                      |   1 +
 drivers/platform/x86/i2c-multi-instantiate.c      |   2 +-
 drivers/platform/x86/pmc_atom.c                   |   7 ++
 tools/power/x86/intel-speed-select/isst-config.c  | 122 +++++++++++++++++++---
 tools/power/x86/intel-speed-select/isst-core.c    |  25 +++++
 tools/power/x86/intel-speed-select/isst-display.c |  71 +++++++++++++
 tools/power/x86/intel-speed-select/isst.h         |  10 +-
 7 files changed, 222 insertions(+), 16 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


