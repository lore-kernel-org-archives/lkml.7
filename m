Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18651C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28732087F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567183213;
	bh=3w05IZaFw4Zq4OAO+9qmAJjzhQNBpvbzD7cVOf/PzHY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=O32TbFsF/KyL2rWOIO+XOv/tdvFP5KA5e1kksImmi+sZR1nmiWUvUq89TvB4ChYZJ
	 U6OOLfBzINj0sI+zlcpGg4cAMrLSYSZ22OqKasDaD3twdpuunXyPrUK3VjpEB/GfaW
	 oGMDawLDlrx7R/2ezM7acjqoUkghuGqGdalOXBkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfH3QkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbfH3QkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:40:08 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567183208;
        bh=3w05IZaFw4Zq4OAO+9qmAJjzhQNBpvbzD7cVOf/PzHY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nju5dpgjffgzJ0MZZWQSNobgA4vwXIxM75Uk2f6ElF8c7gATNXOVSmnGEaqoLG2rr
         sx4Gbk1YeF49Ikct+gJZaudNm/FGxq48RKx7DDS+aew/fZsXuA8bL4kuZUbahzLLV2
         G6ns5DNVIML74S9F7s1s586kqAVAKJi1Md5d8Ke4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190830074147.3691-1-ulf.hansson@linaro.org>
References: <20190830074147.3691-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190830074147.3691-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc5
X-PR-Tracked-Commit-Id: e73a3896eaca95ea5fc895720502a3f040eb4b39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d70787b65941a8db36fd2c35d25c93178f8b545
Message-Id: <156718320803.32023.885555795131888742.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Aug 2019 16:40:08 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Aug 2019 09:41:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d70787b65941a8db36fd2c35d25c93178f8b545

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
