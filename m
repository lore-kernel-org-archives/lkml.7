Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528BFC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 02:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0949A21726
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 02:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554000104;
	bh=xX/nxM2m7yJul6QP/aZ0lxQpVnzqLRjcdsb5ygM1v7E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=h8IdlrhaZ+QDlgC5oDsSTQ1CAafUB1HNXgBCd3eFW7ZYr5EpqTJEzvafiV+ny+Osq
	 aC9yH8bwKDUFsqv/QsXL4vd9t83Qz+5hskOo+6QZNE4/+xVk3bz4sVXQrmxFN6OpJB
	 HbnPbrRcpLZD6PfgCG+UiyDbOXERk3BMro9il7Ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbfCaCll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 22:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731062AbfCaCll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 22:41:41 -0400
Received: from localhost (unknown [49.248.228.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 487A521726;
        Sun, 31 Mar 2019 02:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554000100;
        bh=xX/nxM2m7yJul6QP/aZ0lxQpVnzqLRjcdsb5ygM1v7E=;
        h=Date:From:To:Cc:Subject:From;
        b=b4D/0iBwKMLGMxQHexVFdoEtpMl0Ust3yQt55MU7V0Ny6HU7pMojsa6AWRxAgdZwk
         aEC43Zcn3NgkrEf6tiZ1Kjs/a3c/rijKVrjKZjcbZtx50sTOr1l4nxqm1CPzvcqCkP
         u3loZjfQUZi2ARgiVqdl2KeEPLh2E+cX7kEajvmU=
Date:   Sun, 31 Mar 2019 08:11:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes v5.1-rc3
Message-ID: <20190331024135.GA2937@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the pull request fro v5.1-rc3. This includes revery of patch due
to reported regression and fix on MAINTAINER file for uniphier-mdmac.c
file path.

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.1-rc3

for you to fetch changes up to d498bc0ce8acb4a1bb80d6089d1932d919dc2532:

  MAINTAINERS: Fix uniphier-mdmac.c file path (2019-03-26 10:55:47 +0530)

----------------------------------------------------------------
dmaengine-5.10-rc3

dmaengine fixes for v5.10-rc3

 - Revert dmaengine: stm32-mdma: Add a check on read_u32_array as that
   caused regression
 - Fix MAINTAINER file uniphier-mdmac.c file path

----------------------------------------------------------------
Pierre-Yves MORDRET (1):
      dmaengine: stm32-mdma: Revert "dmaengine: stm32-mdma: Add a check on read_u32_array"

Vinod Koul (1):
      MAINTAINERS: Fix uniphier-mdmac.c file path

 MAINTAINERS              | 2 +-
 drivers/dma/stm32-mdma.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

Thanks
-- 
~Vinod
