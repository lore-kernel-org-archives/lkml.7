Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4029C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C8E2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557848272;
	bh=zHaae0mdyUYkoIAyzKfGo5omzgy2QdobwBLjMwVzihE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=EoP2ybm5bCffT/0wmDMiGELRSATYw7yAPPNBv5WDiSQkA27yQSnywtjIkGu02Difo
	 hG4drMpQ4v2rGK5Y5v7PN3aF7xKti62vO32XMtooQbE7N9DDEPz0DjPGPYQYkWKiw6
	 I8CXmvMfJrEb+NzrxZGAMoko9MSI+FhiCHcrFLP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfENPhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 11:37:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfENPhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:37:51 -0400
Received: from linux-8ccs (ip5f5ade5e.dynamic.kabel-deutschland.de [95.90.222.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D2AE2086A;
        Tue, 14 May 2019 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557848270;
        bh=zHaae0mdyUYkoIAyzKfGo5omzgy2QdobwBLjMwVzihE=;
        h=Date:From:To:Cc:Subject:From;
        b=yM/vJZmazDD9HhC+NcfkrwBVGetaTU12X63sogcJx9kXmBU+jXzqwF0uCRA85GppV
         ct+gr0CzZjajpmGzCfdrblszOHoZfEhMd1k4MQgYVId7nZBUOrsadSQzI51OesEaeG
         9jvjdFqFQJ/Ltn1L0pjOgVzCtBMMIdqDBHfXnRPM=
Date:   Tue, 14 May 2019 17:37:46 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v5.2
Message-ID: <20190514153746.GA4533@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull below to receive modules updates for the 5.2 merge window.
Details can be found in the signed tag.

Note that there is a trivial conflict between the modules tree and vfs tree
in include/linux/module.h. 

Commit 007ec26cdc9f ("vfs: Implement logging through fs_context") from the
vfs tree and commit dadec066d8fa ("module: add stubs for within_module
functions") from the modules tree both added the stub for
within_module_core(). The hunk in question is exactly the same for both
commits, so the conflict is trivially resolvable.

Thanks,

Jessica

---
The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.2

for you to fetch changes up to dadec066d8fa7da227f623f632ea114690fecaf8:

  module: add stubs for within_module functions (2019-05-02 16:32:29 +0200)

----------------------------------------------------------------
Modules updates for v5.2

Summary of modules changes for the 5.2 merge window:

- Use a separate table to store symbol types instead of
  hijacking fields in struct Elf_Sym

- Trivial code cleanups

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Eugene Loh (1):
      kallsyms: store type information in its own array

Mathias Krause (1):
      vmlinux.lds.h: drop unused __vermagic

Tri Vo (1):
      module: add stubs for within_module functions

 include/asm-generic/vmlinux.lds.h |  1 -
 include/linux/module.h            | 18 ++++++++++++++++++
 kernel/module-internal.h          |  2 +-
 kernel/module.c                   | 21 ++++++++++++++-------
 4 files changed, 33 insertions(+), 9 deletions(-)
