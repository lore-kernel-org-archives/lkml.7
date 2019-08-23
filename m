Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB46AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A3F20578
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566573140;
	bh=t/5AlJJtmiUbeuZcsxa1fs1TDs8PURgYTsF1IbHIL1Q=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ijUiMaJN02XysI9mtrtzwIEvqeJmtnkTV7pMkOLW+m09swjFxwQKHsTHr8ta312ZZ
	 OY0k+9Fx6KCuvE823MqyTGB71bWirFkO/VBWy8iQyLsuym1nq8WCwsLnszlzDkx/N/
	 ga3hnDFXy7GQGacwUfAaSs/8VCjmZytFrKJSYruA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395509AbfHWPMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfHWPMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:12:19 -0400
Received: from redbean (ip5f5adbf1.dynamic.kabel-deutschland.de [95.90.219.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BE6A20578;
        Fri, 23 Aug 2019 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566573138;
        bh=t/5AlJJtmiUbeuZcsxa1fs1TDs8PURgYTsF1IbHIL1Q=;
        h=Date:From:To:Cc:Subject:From;
        b=100Lhf1pxmh9C/vzMaADa9vQCA6Axmg2l6mIT/iNYjCH/75aBF2wASeIRpvm6gPgN
         K/8hYHaLTl9+vMkf3uNvfMBaEJiBhKucCG96qjpp0oAoUHdA0R/ztnep/vWdpytYjx
         XW1KNyjCbhevB3+yEuFWcwUN5ZEc9GOht59BHfHE=
Date:   Fri, 23 Aug 2019 17:12:13 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] modules fixes for v5.3-rc6
Message-ID: <20190823151213.wdjaslloway6ng4u@redbean>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux redbean 4.18.16-100.fc27.x86_64 x86_64
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.3-rc6

for you to fetch changes up to 3b5be16c7e90a69c93349d210766250fffcb54bd:

  modules: page-align module section allocations only for arches supporting strict module rwx (2019-08-21 10:43:56 +0200)

----------------------------------------------------------------
Modules fixes for v5.3-rc6

- Fix BUG_ON() being triggered in frob_text() due to non-page-aligned module
  sections

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
He Zhe (1):
      modules: page-align module section allocations only for arches supporting strict module rwx

Jessica Yu (1):
      modules: always page-align module section allocations

 kernel/module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
