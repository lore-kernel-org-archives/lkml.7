Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9429C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B55E2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfGQQRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:17:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:21483 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfGQQRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:17:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 09:17:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,274,1559545200"; 
   d="scan'208";a="187585973"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2019 09:17:04 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hnmc3-0001Rq-CK; Wed, 17 Jul 2019 19:17:03 +0300
Date:   Wed, 17 Jul 2019 19:17:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>, yurii.pavlovskyi@gmail.com
Subject: [GIT PULL] platform-drivers-x86 for 5.3-2
Message-ID: <20190717161703.GA5516@smile.fi.intel.com>
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

Last minute (naming) change to ASUS WMI driver.

It won't break any ABI, but has to be done now to avoid confusion in the future.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 0a8ad0ffa4d80a544f6cbff703bf6394339afcdf:

  Merge tag 'for-linus-5.3-ofs1' of git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux (2019-07-16 15:15:29 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.3-2

for you to fetch changes up to 9af93db9e140a4e6e79cdb098919bc928a72cd59:

  platform/x86: asus: Rename "fan mode" to "fan boost mode" (2019-07-17 19:07:58 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v5.3-2

Provide better naming for ABI, i.e. tell that we have fan boost mode.

The following is an automated git shortlog grouped by driver:

asus:
 -  Rename "fan mode" to "fan boost mode"

----------------------------------------------------------------
Daniel Drake (1):
      platform/x86: asus: Rename "fan mode" to "fan boost mode"

 Documentation/ABI/testing/sysfs-platform-asus-wmi |   6 +-
 drivers/platform/x86/asus-wmi.c                   | 118 ++++++++++++----------
 include/linux/platform_data/x86/asus-wmi.h        |   2 +-
 3 files changed, 66 insertions(+), 60 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


