Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B7FC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A58B21783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563449636;
	bh=WPhvEjgESiuygEpB/DftI4TTGrjJpMdsKyZDeI+W3lg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=nKe9sl7Hjsov+izGZ4NmRjjPjJ8tCi1sfsG0ghUjva0QiOUc/wFRyKdoyP459UGTa
	 +jOKD7FD2aMp0w+8VpQz1SGE2cGQ4TY1xpXNb/ZHo1iyFt3dpkx8h50TZwgwD1xFyl
	 2GQEQlrVmkW+Y3AVOP7aM5mKTTCRg9CsTmJdX9uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfGRLdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 07:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbfGRLdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:33:54 -0400
Received: from linux-8ccs (ip5f5ade87.dynamic.kabel-deutschland.de [95.90.222.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77AC321783;
        Thu, 18 Jul 2019 11:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563449633;
        bh=WPhvEjgESiuygEpB/DftI4TTGrjJpMdsKyZDeI+W3lg=;
        h=Date:From:To:Cc:Subject:From;
        b=ZUgnYuj2bewUXgApSGXhIvzz6GNG5d75s/ZNaGO3uNUWZjBv70p6tiAtIbA/T6AtZ
         taUMpwFeQoHkD3z/y/d53MMXucO2lxm1Kc2BtJ/vDkC+K2aelgbLUCBltC+x4Ywkzh
         CjqJb5EaanmdG2wG8N/OvAA9YTU2Xudc4zdfDtbc=
Date:   Thu, 18 Jul 2019 13:33:49 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v5.3
Message-ID: <20190718113346.GA19574@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull below to receive modules updates for the 5.3 merge window.
Details can be found in the signed tag.

Thanks!

Jessica

---
The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.3

for you to fetch changes up to 93651f80dcb616b8c9115cdafc8e57a781af22d0:

  modules: fix compile error if don't have strict module rwx (2019-06-26 19:27:59 +0200)

----------------------------------------------------------------
Modules updates for v5.3

Summary of modules changes for the 5.3 merge window:

- Code fixes and cleanups

- Fix bug where set_memory_x() wasn't being called when rodata=n

- Fix bug where -EEXIST was being returned for going modules

- Allow arches to override module_exit_section()

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      kernel: module: Use struct_size() helper

Matthias Schiffer (2):
      module: allow arch overrides for .exit section names
      ARM: module: recognize unwind exit sections

Prarit Bhargava (1):
      kernel/module.c: Only return -EEXIST for modules that have finished loading

Yang Yingliang (2):
      modules: fix BUG when load module with rodata=n
      modules: fix compile error if don't have strict module rwx

YueHaibing (1):
      kernel/module: Fix mem leak in module_add_modinfo_attrs

 arch/arm/kernel/module.c     |  7 ++++++
 include/linux/moduleloader.h |  5 ++++
 kernel/module.c              | 60 ++++++++++++++++++++++++++++++--------------
 3 files changed, 53 insertions(+), 19 deletions(-)
