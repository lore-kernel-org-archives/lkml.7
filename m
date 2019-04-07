Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307DEC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 14:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED37920880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 14:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfDGOu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 10:50:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:50460 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbfDGOu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 10:50:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68C86AEE8;
        Sun,  7 Apr 2019 14:50:55 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for 5.1-rc4
Date:   Sun,  7 Apr 2019 16:50:48 +0200
Message-Id: <20190407145048.12116-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.1b-rc4-tag

xen: fixes for 5.1-rc4

It contains one minor fix and a small cleanup for the xen privcmd
driver.


Thanks.

Juergen

 arch/x86/include/asm/xen/hypercall.h | 3 +++
 drivers/xen/privcmd-buf.c            | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

Andrea Righi (1):
      xen: use struct_size() helper in kzalloc()

Dan Carpenter (1):
      xen: Prevent buffer overflow in privcmd ioctl
