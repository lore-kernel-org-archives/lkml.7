Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C81C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C065321874
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554048012;
	bh=QZOqLxYocUETfuJZ2Nq+1rZUQTZeclyf+zQCT6iDtU8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hu0+u+RRyd7vzSU0QlYuYTEkjCxuUHiFCAkpX8vtR8+2HZmC2GeadCySD6dxANSWz
	 2V4JbR/eKZCcPnHrSM76az1XYmoNB6iWGN+f+4u3kAFos97aLobf/JqffxoglC4DA5
	 TVlzmWF25QQc+YLy0Xg8g837Eco9ZUlcsKvoHQVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbfCaQAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 12:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731162AbfCaQAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 12:00:11 -0400
Subject: Re: [GIT PULL]: dmaengine fixes v5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554048010;
        bh=QZOqLxYocUETfuJZ2Nq+1rZUQTZeclyf+zQCT6iDtU8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=E+kCV+W8jHuhC7iwD7JzKqg2QlYcuQPrwdd+nkhGIHlNf2NoHJRkW5p0/aH2lza+B
         m99fN0+AzZiG3y+v/CoBFdgWZD6TTfswGQT+GyDafZAPukQ/iI1TpT37ft0iWTAOMk
         BR2+xlSKaNfPzCgtEWOl3rKnxRmNVDy/L+RTfvNg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190331024135.GA2937@vkoul-mobl>
References: <20190331024135.GA2937@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190331024135.GA2937@vkoul-mobl>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-fix-5.1-rc3
X-PR-Tracked-Commit-Id: d498bc0ce8acb4a1bb80d6089d1932d919dc2532
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c877b3df8527f010ef068704033acac1d43cbf8c
Message-Id: <155404801029.15219.7805763339926813627.pr-tracker-bot@kernel.org>
Date:   Sun, 31 Mar 2019 16:00:10 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 Mar 2019 08:11:35 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c877b3df8527f010ef068704033acac1d43cbf8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
