Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B61C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859352082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfKYIAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 03:00:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:34008 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbfKYIAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 03:00:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F9A4AEFB;
        Mon, 25 Nov 2019 08:00:44 +0000 (UTC)
Date:   Mon, 25 Nov 2019 09:00:35 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS updates for 5.5
Message-ID: <20191125080035.GB12432@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the below branch to receive the RAS updates this time
around, which are, as follows:

* Fully reworked thermal throttling notifications, there should be no more
  spamming of dmesg (by Srinivas Pandruvada and Benjamin Berg)

* More enablement for the Intel-compatible CPUs Zhaoxin (by Tony W Wang-oc)

* PPIN support for Icelake (by Tony Luck)

Thx.

---
The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

for you to fetch changes up to f6656208f04e5b3804054008eba4bf7170f4c841:

  x86/mce/therm_throt: Optimize notifications of thermal throttle (2019-11-12 15:56:04 +0100)

----------------------------------------------------------------
Benjamin Berg (1):
      x86/mce: Lower throttling MCE messages' priority to warning

Borislav Petkov (1):
      x86/mce/amd: Make disable_err_thresholding() static

Srinivas Pandruvada (1):
      x86/mce/therm_throt: Optimize notifications of thermal throttle

Tony Luck (1):
      x86/mce: Add Xeon Icelake to list of CPUs that support PPIN

Tony W Wang-oc (3):
      x86/mce: Add Zhaoxin MCE support
      x86/mce: Add Zhaoxin CMCI support
      x86/mce: Add Zhaoxin LMCE support

 arch/x86/kernel/cpu/mce/amd.c         |   2 +-
 arch/x86/kernel/cpu/mce/core.c        |  93 +++++++++++--
 arch/x86/kernel/cpu/mce/intel.c       |  11 +-
 arch/x86/kernel/cpu/mce/internal.h    |   6 +
 arch/x86/kernel/cpu/mce/therm_throt.c | 251 ++++++++++++++++++++++++++++++----
 5 files changed, 319 insertions(+), 44 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
