Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78447C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A11217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfI0Iu4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:50:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:65095 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfI0Iu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:50:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 01:50:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,554,1559545200"; 
   d="scan'208";a="193153323"
Received: from unknown (HELO ubuntu) ([10.226.248.117])
  by orsmga003.jf.intel.com with SMTP; 27 Sep 2019 01:50:54 -0700
Received: by ubuntu (sSMTP sendmail emulation); Fri, 27 Sep 2019 16:50:52 +0800
Message-ID: <1569574252.9826.4.camel@intel.com>
Subject: [GIT PULL] arch/nios2 update for v5.4
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "lftan.linux@gmail.com" <lftan.linux@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Date:   Fri, 27 Sep 2019 16:50:52 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Please pull the arch/nios2 update below.

Thanks.

Regards
Ley Foon


The following changes since commit 4d856f72c10ecb060868ed10ff1b1453943fc6c8:

  Linux 5.3 (2019-09-15 14:19:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git tags/nios2-v5.4-rc1

for you to fetch changes up to 91d99a724e9c60e14332c26ab2284bf696b94c8e:

  nios2: force the string buffer NULL-terminated (2019-09-20 14:55:57 +0800)

----------------------------------------------------------------
nios2 update for v5.4-rc1

nios2: force the string buffer NULL-terminated

----------------------------------------------------------------
Wang Xiayang (1):
      nios2: force the string buffer NULL-terminated

 arch/nios2/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
