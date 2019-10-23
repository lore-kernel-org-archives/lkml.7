Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2677ACA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AAD214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389881AbfJWHau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:30:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:59128 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389351AbfJWHau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:30:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9FF37B16C;
        Wed, 23 Oct 2019 07:30:48 +0000 (UTC)
Date:   Wed, 23 Oct 2019 09:30:47 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC fix for 5.4
Message-ID: <20191023073047.GD12272@zn.tnic>
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

please pull,
thx.

---
The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_5.4

for you to fetch changes up to 1e72e673b9d102ff2e8333e74b3308d012ddf75b:

  EDAC/ghes: Fix Use after free in ghes_edac remove path (2019-10-17 11:27:05 +0200)

----------------------------------------------------------------
Fix ghes_edac UAF case triggered by KASAN and DEBUG_TEST_DRIVER_REMOVE.

Future pending rework of the ghes_edac instances registration will do
away with the single memory controller per system model and that ugly
hackery there.

This is a minimal fix for stable@, courtesy of James Morse.

----------------------------------------------------------------
James Morse (1):
      EDAC/ghes: Fix Use after free in ghes_edac remove path

 drivers/edac/ghes_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
