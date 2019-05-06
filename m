Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFF5C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE1F20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfEFJGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:06:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:38898 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbfEFJGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:06:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DDE41AC5A;
        Mon,  6 May 2019 09:06:40 +0000 (UTC)
Date:   Mon, 6 May 2019 11:06:32 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode updates for 5.2
Message-ID: <20190506090632.GC6094@zn.tnic>
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

please pull

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-microcode-for-linus

to receive a nice Intel microcode blob loading cleanup which gets rid
of the ugly memcpy wrappers and switches the driver to use the iov_iter
API. By Jann Horn.

In addition, the /dev/cpu/microcode interface is finally deprecated as it is
inadequate for the same reasons the late microcode loading is.

Thx.

---
The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-microcode-for-linus

for you to fetch changes up to c02f48e070bde326f55bd94544ca82291f7396e3:

  x86/microcode: Deprecate MICROCODE_OLD_INTERFACE (2019-04-10 22:43:24 +0200)

----------------------------------------------------------------
Borislav Petkov (2):
      x86/microcode: Fix the ancient deprecated microcode loading method
      x86/microcode: Deprecate MICROCODE_OLD_INTERFACE

Jann Horn (1):
      x86/microcode/intel: Refactor Intel microcode blob loading

 arch/x86/Kconfig                      | 10 ++++-
 arch/x86/kernel/cpu/microcode/core.c  |  3 +-
 arch/x86/kernel/cpu/microcode/intel.c | 71 ++++++++++++++++++-----------------
 3 files changed, 47 insertions(+), 37 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Mary Higgins, Sri Rasiah, HRB 21284 (AG Nürnberg)
