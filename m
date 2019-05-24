Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2420BC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4302133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390726AbfEXQLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:11:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:45178 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389588AbfEXQLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:11:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 09:11:21 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga005.jf.intel.com with ESMTP; 24 May 2019 09:11:19 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hUCmt-0005WZ-2E; Fri, 24 May 2019 19:11:19 +0300
Date:   Fri, 24 May 2019 19:11:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.2-2
Message-ID: <20190524161119.GA21220@smile.fi.intel.com>
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

Fixes for v5.2-rc2. This batch is sent now due to dependencies which are landed
in v5.2-rc1.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.2-2

for you to fetch changes up to d6423bd03031c020121da26c41a26bd5cc6d0da3:

  platform/x86: pmc_atom: Add several Beckhoff Automation boards to critclk_systems DMI table (2019-05-20 17:26:40 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v5.2-2

Some of Intel Cherrytrail based platforms depend on PMC clock to be always on.
Here couple of quirks to the driver to support affected hardware.

The following is an automated git shortlog grouped by driver:

pmc_atom:
 -  Add several Beckhoff Automation boards to critclk_systems DMI table
 -  Add Lex 3I380D industrial PC to critclk_systems DMI table

----------------------------------------------------------------
Hans de Goede (1):
      platform/x86: pmc_atom: Add Lex 3I380D industrial PC to critclk_systems DMI table

Steffen Dirkwinkel (1):
      platform/x86: pmc_atom: Add several Beckhoff Automation boards to critclk_systems DMI table

 drivers/platform/x86/pmc_atom.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

-- 
With Best Regards,
Andy Shevchenko


