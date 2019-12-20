Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F203CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFA521D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfLTRTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:19:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:18823 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfLTRTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 12:19:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 09:19:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,336,1571727600"; 
   d="scan'208";a="267572759"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Dec 2019 09:19:47 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iiLwK-00011M-5W; Fri, 20 Dec 2019 19:19:48 +0200
Date:   Fri, 20 Dec 2019 19:19:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.5-2
Message-ID: <20191220171948.GA3909@smile.fi.intel.com>
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

Bucket of fixes for PDx86. Note, that there is no ABI breakage in Mellanox
driver because it has been introduced in v5.5-rc1, so we can change it.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.5-2

for you to fetch changes up to 02abbda105f25fb634207e7f23a8a4b51fe67ad4:

  platform/x86: pcengines-apuv2: Spelling fixes in the driver (2019-12-20 19:01:59 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.5-2

* Add support of APUv4 and fix an assignment of simswap GPIO.
* Add Siemens CONNECT X300 to DMI table to avoid stuck during boot.
* Correct arguments of WMI call on HP Envy x360 15-cp0xxx model.
* Fix the mlx-bootctl sysfs attributes to be device related.

The following is an automated git shortlog grouped by driver:

hp-wmi:
 -  Make buffer for HPWMI_FEATURE2_QUERY 128 bytes

pcengines-apuv2:
 -  Spelling fixes in the driver
 -  detect apuv4 board
 -  fix simswap GPIO assignment

platform/mellanox:
 -  fix the mlx-bootctl sysfs

pmc_atom:
 -  Add Siemens CONNECT X300 to critclk_systems DMI table

----------------------------------------------------------------
Andy Shevchenko (1):
      platform/x86: pcengines-apuv2: Spelling fixes in the driver

Enrico Weigelt, metux IT consult (2):
      platform/x86: pcengines-apuv2: fix simswap GPIO assignment
      platform/x86: pcengines-apuv2: detect apuv4 board

Hans de Goede (1):
      platform/x86: hp-wmi: Make buffer for HPWMI_FEATURE2_QUERY 128 bytes

Liming Sun (1):
      platform/mellanox: fix the mlx-bootctl sysfs

Michael Haener (1):
      platform/x86: pmc_atom: Add Siemens CONNECT X300 to critclk_systems DMI table

 .../ABI/testing/sysfs-platform-mellanox-bootctl    | 10 ++--
 drivers/platform/mellanox/mlxbf-bootctl.c          |  2 +-
 drivers/platform/x86/hp-wmi.c                      |  2 +-
 drivers/platform/x86/pcengines-apuv2.c             | 63 +++++++++++++++-------
 drivers/platform/x86/pmc_atom.c                    |  8 +++
 5 files changed, 60 insertions(+), 25 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


