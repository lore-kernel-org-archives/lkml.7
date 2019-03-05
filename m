Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6111C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E638206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfCEOQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:16:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:45530 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727498AbfCEOQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:16:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86608AF1A;
        Tue,  5 Mar 2019 14:16:49 +0000 (UTC)
Date:   Tue, 5 Mar 2019 15:16:45 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS updates for 5.1
Message-ID: <20190305141645.GF9073@zn.tnic>
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

please pull the latest ras-core-for-linus tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

This time around we have in store:

* Disable MC4_MISC thresholding banks on all AMD family 0x15 models (Shirish S)

* AMD MCE error descriptions update and error decode improvements (Yazen Ghannam)

* The usual smaller conversions and fixes

Thanks,
Boris.

------------------>

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

for you to fetch changes up to 41f035a86b5b72a4f947c38e94239d20d595352a:

  x86/mce: Improve error message when kernel cannot recover, p2 (2019-02-25 23:21:35 +0100)

----------------------------------------------------------------
Andy Shevchenko (2):
      x86/MCE: Switch to use the new generic UUID API
      RAS: Use consistent types for UUIDs

Borislav Petkov (1):
      RAS: Add a MAINTAINERS entry

Shirish S (2):
      x86/MCE/AMD: Turn off MC4_MISC thresholding on all family 0x15 models
      x86/MCE/AMD: Carve out the MC4_MISC thresholding quirk

Tony Luck (1):
      x86/mce: Improve error message when kernel cannot recover, p2

Yazen Ghannam (7):
      x86/MCE/AMD, EDAC/mce_amd: Add new MP5, NBIO, and PCIE SMCA bank types
      x86/MCE/AMD, EDAC/mce_amd: Add new McaTypes for CS, PSP, and SMU units
      x86/MCE/AMD, EDAC/mce_amd: Add new error descriptions for some SMCA bank types
      EDAC, mce_amd: Match error descriptions to latest documentation
      EDAC, mce_amd: Print ExtErrorCode and description on a single line
      EDAC/mce_amd: Decode MCA_STATUS[Scrub] bit
      EDAC/mce_amd: Decode MCA_STATUS in bit definition order

 MAINTAINERS                        |  10 ++
 arch/x86/include/asm/mce.h         |   7 +
 arch/x86/kernel/cpu/mce/amd.c      |  62 +++++++-
 arch/x86/kernel/cpu/mce/apei.c     |  10 +-
 arch/x86/kernel/cpu/mce/core.c     |  30 ----
 arch/x86/kernel/cpu/mce/severity.c |   5 +
 drivers/edac/mce_amd.c             | 291 ++++++++++++++++++++++++-------------
 drivers/ras/ras.c                  |   2 +-
 include/ras/ras_event.h            |   8 +-
 9 files changed, 282 insertions(+), 143 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
