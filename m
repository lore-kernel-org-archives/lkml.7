Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65732C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428FA2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfKYIok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 03:44:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:51492 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfKYIoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 03:44:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38224AFF3;
        Mon, 25 Nov 2019 08:44:38 +0000 (UTC)
Date:   Mon, 25 Nov 2019 09:44:28 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode updates for 5.5
Message-ID: <20191125084428.GC12432@zn.tnic>
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

please pull the below microcode loader updates for 5.5. It converts the
late loading method to load the microcode in parallel (vs sequentially
currently). The patch remained in linux-next for the maximum amount of
time so that any potential and hard to debug fallout be minimized.

Now cloud folks have their milliseconds back but all the normal people
should use early loading anyway. :-)

* Enable the late loading method to update microcode in parallel on all CPUs
  (Ashok Raj)

Please pull, thanks.

---
The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-microcode-for-linus

for you to fetch changes up to 811ae8ba6dca6b91a3ceccf9d40b98818cc4f400:

  x86/microcode/intel: Issue the revision updated message only on the BSP (2019-10-01 16:06:35 +0200)

----------------------------------------------------------------
Ashok Raj (1):
      x86/microcode: Update late microcode in parallel

Borislav Petkov (2):
      x86/microcode/amd: Fix two -Wunused-but-set-variable warnings
      x86/microcode/intel: Issue the revision updated message only on the BSP

 arch/x86/kernel/cpu/microcode/amd.c   |  4 ++--
 arch/x86/kernel/cpu/microcode/core.c  | 36 ++++++++++++++++++++---------------
 arch/x86/kernel/cpu/microcode/intel.c |  5 +++--
 3 files changed, 26 insertions(+), 19 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
