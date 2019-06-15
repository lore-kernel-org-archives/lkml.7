Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BAFC31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 17:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B5E20861
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 17:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfFORPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 13:15:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:35473 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfFORPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 13:15:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2019 10:15:17 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2019 10:15:16 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hcCGp-0004RC-GY; Sat, 15 Jun 2019 20:15:15 +0300
Date:   Sat, 15 Jun 2019 20:15:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.2-3
Message-ID: <20190615171515.GA17041@smile.fi.intel.com>
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

Bunch of few fixes for v5.2 cycle, no merge conflicts observed.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.2-3

for you to fetch changes up to 8c2eb7b6468ad4aa5600aed01aa0715f921a3f8b:

  platform/mellanox: mlxreg-hotplug: Add devm_free_irq call to remove flow (2019-06-12 11:49:20 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v5.2-3

Couple of driver enumeration issues have been fixed for Mellanox.
ASUS laptops got a regression with backlight, which is fixed now.
Dell computers got a wrong mode (tablet versus laptop) after resume,
that is fixed now.

The following is an automated git shortlog grouped by driver:

asus-wmi:
 -  Only Tell EC the OS will handle display hotkeys from asus_nb_wmi

intel-vbtn:
 -  Report switch events when event wakes device

mlx-platform:
 -  Fix parent device in i2c-mux-reg device registration

platform/mellanox:
 -  mlxreg-hotplug: Add devm_free_irq call to remove flow

----------------------------------------------------------------
Hans de Goede (1):
      platform/x86: asus-wmi: Only Tell EC the OS will handle display hotkeys from asus_nb_wmi

Mathew King (1):
      platform/x86: intel-vbtn: Report switch events when event wakes device

Vadim Pasternak (2):
      platform/x86: mlx-platform: Fix parent device in i2c-mux-reg device registration
      platform/mellanox: mlxreg-hotplug: Add devm_free_irq call to remove flow

 drivers/platform/mellanox/mlxreg-hotplug.c |  1 +
 drivers/platform/x86/asus-nb-wmi.c         |  8 ++++++++
 drivers/platform/x86/asus-wmi.c            |  2 +-
 drivers/platform/x86/asus-wmi.h            |  1 +
 drivers/platform/x86/intel-vbtn.c          | 16 ++++++++++++++--
 drivers/platform/x86/mlx-platform.c        |  2 +-
 6 files changed, 26 insertions(+), 4 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


