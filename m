Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02C7C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79256205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569877557;
	bh=q2Aw7oxKyuN+TMragPvuqXluuGNeqPOU2QSjQfBGXc8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EIw2LcsVRy2rnJ+3oSX3K9vvCF6UTrN/obx4up5kg4vun0RCVatzJMDNcj6L6NNQ7
	 JHxcECRanBqqmw0l1pheTU0LHCbLaASK1MmRs7o+b+eZA1eSuA/U6cvVkQxDU+4xPY
	 iWMQhiP+mhdVCRgFVh45qQRTB2N24atVfJbcpKqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbfI3VF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbfI3VFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:05:54 -0400
Subject: Re: [GIT PULL] csky changes for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569864624;
        bh=q2Aw7oxKyuN+TMragPvuqXluuGNeqPOU2QSjQfBGXc8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wpGFPWxQKiim3uMmlV0QbP6OGXmtbhMvvwLJ2LOT6B7+JfnjMhmm+cuQASdCEwjrO
         +YPeMlx4emuXJm33QgwXJzMV9Ot9tm4lPbXb4lyDIXtprJFnYnbCmokkcWOZRXOrON
         Hi0YnTERN6Br7ADE5IVIOINGBl5ZmH34Eh5UXf/c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1569839484-28170-1-git-send-email-guoren@kernel.org>
References: <1569839484-28170-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1569839484-28170-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git
 tags/csky-for-linus-5.4-rc1
X-PR-Tracked-Commit-Id: 9af032a30172e119a5935f802b066631f8ded2d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80b29b6b8cd7479a67f5e338195dbc121b30c879
Message-Id: <156986462410.9141.54549862390206460.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Sep 2019 17:30:24 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Sep 2019 18:31:24 +0800:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80b29b6b8cd7479a67f5e338195dbc121b30c879

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
