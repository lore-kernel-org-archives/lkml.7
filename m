Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B79ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9162089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393878AbfJQJzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:55:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:14110 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbfJQJzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:55:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 02:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,307,1566889200"; 
   d="scan'208";a="397481623"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 17 Oct 2019 02:55:20 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iL2V6-0002GT-3D; Thu, 17 Oct 2019 12:55:20 +0300
Date:   Thu, 17 Oct 2019 12:55:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.4-3
Message-ID: <20191017095520.GA8671@smile.fi.intel.com>
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

Few small fixes for v5.4-rc4. The bunch was in linux-next for few days.
No conflicts with current master.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.4-3

for you to fetch changes up to 832392db9747b9c95724d37fc6a5dadd3d4ec514:

  platform/x86: i2c-multi-instantiate: Fail the probe if no IRQ provided (2019-10-14 15:31:50 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v5.4-3

Users of Intel P-Unit IPC driver might be surprised by harmless warning.
Thus, switch to API which doesn't issue a warning at all.

I²C multi-instantiate driver continues to add slave devices even when IRQ
resource is not found. For devices in the market IRQ resource is mandatory,
so, fail the ->probe() of the parent driver to avoid slaves being probed.

Avoid compiler warning due to unused variable in Classmate laptop driver.

The following is an automated git shortlog grouped by driver:

classmate-laptop:
 -  remove unused variable

i2c-multi-instantiate:
 -  Fail the probe if no IRQ provided

intel_punit_ipc:
 -  Avoid error message when retrieving IRQ

----------------------------------------------------------------
Andy Shevchenko (2):
      platform/x86: intel_punit_ipc: Avoid error message when retrieving IRQ
      platform/x86: i2c-multi-instantiate: Fail the probe if no IRQ provided

yu kuai (1):
      platform/x86: classmate-laptop: remove unused variable

 drivers/platform/x86/classmate-laptop.c      | 12 ------------
 drivers/platform/x86/i2c-multi-instantiate.c |  1 +
 drivers/platform/x86/intel_punit_ipc.c       |  3 +--
 3 files changed, 2 insertions(+), 14 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


