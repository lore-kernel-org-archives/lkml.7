Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FD9C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F45321842
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfG2QKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:10:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:23364 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbfG2QKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:10:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 08:38:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,323,1559545200"; 
   d="scan'208";a="179417951"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jul 2019 08:38:17 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hs7j5-0000EB-Kh; Mon, 29 Jul 2019 18:38:15 +0300
Date:   Mon, 29 Jul 2019 18:38:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.3-3
Message-ID: <20190729153815.GA853@smile.fi.intel.com>
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

Business as usual for PDx86, few fixes and new ID
(missed merge window due to dependency).

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.3-3

for you to fetch changes up to f14312a93b34b9350dc33ff0b4215c24f4c82617:

  platform/x86: pcengines-apuv2: use KEY_RESTART for front button (2019-07-29 18:24:59 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v5.3-3

PC Engines APU got one fix for software dependencies to automatically load them
and another fix for mapping of key button in the front to issue restart event.

OLPC driver is now can be probed automatically based on module device table.

Intel PMC core driver supports Intel Ice Lake NNPI processor.

WMI driver missed description of new field in the structure that has been added.

The following is an automated git shortlog grouped by driver:

intel_pmc_core:
 -  Add ICL-NNPI support to PMC Core

pcengines-apuv2:
 -  use KEY_RESTART for front button
 -  Fix softdep statement

OLPC:
 -  add SPI MODULE_DEVICE_TABLE

wmi:
 -  add missing struct parameter description

----------------------------------------------------------------
Enrico Weigelt (1):
      platform/x86: pcengines-apuv2: use KEY_RESTART for front button

Jean Delvare (1):
      platform/x86: pcengines-apuv2: Fix softdep statement

Lubomir Rintel (1):
      Platform: OLPC: add SPI MODULE_DEVICE_TABLE

Mattias Jacobsson (1):
      platform/x86: wmi: add missing struct parameter description

Rajneesh Bhardwaj (1):
      platform/x86: intel_pmc_core: Add ICL-NNPI support to PMC Core

 drivers/platform/olpc/olpc-xo175-ec.c  | 6 ++++++
 drivers/platform/x86/intel_pmc_core.c  | 1 +
 drivers/platform/x86/pcengines-apuv2.c | 6 ++----
 include/linux/mod_devicetable.h        | 1 +
 4 files changed, 10 insertions(+), 4 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


