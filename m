Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D190C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9A5218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552686322;
	bh=VL/Cx1eDzt3+/KTMRymoOH6jteQX78pc4wVmDU8pDyg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1xKfNRwTfTWnu9giUPAmrp9CVajbfD/QGghnux9r0kG0c+bExkNL+GR3ji8fWTK/w
	 Et0CqjckjNEzdhQEUERsD8soWjgDlSgklb/rHLdXqIjcjZ+rrvKLQ7SUYpiOSZsv2k
	 ScSvTWXL6ZWLTAWAU4HC4XJkhw+US56ww7dtRTsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfCOVpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbfCOVpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:45:20 -0400
Subject: Re: [GIT PULL] fbdev changes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552686319;
        bh=VL/Cx1eDzt3+/KTMRymoOH6jteQX78pc4wVmDU8pDyg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SPzJjVz3HCoCjdbcJC7jh7gzNb662MwXh6AseyrqUi710TCwG0UHV1H+/89ltP/7V
         OgYsKUWjuYLqB3tYvfk0FAqNX/3ozcUWGs8u4zYtkNGKIYpIaCRwEl8VtvNihi2B2y
         YLRhktMHBBRfUP+9CmBVq6QFi65QrYW9uoa3SqAY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4114bd4f-9c58-a295-c767-47720dcf2c37@samsung.com>
References: <CGME20190315111228eucas1p24628f949b96a13bc3434d36425fa0be0@eucas1p2.samsung.com>
 <4114bd4f-9c58-a295-c767-47720dcf2c37@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4114bd4f-9c58-a295-c767-47720dcf2c37@samsung.com>
X-PR-Tracked-Remote: https://github.com/bzolnier/linux.git tags/fbdev-v5.1
X-PR-Tracked-Commit-Id: 9a9f1d1a81a972513636c333e26c542f8aebae55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b9c272cf5cd81708e51b4ce3e432ce9566cfa47
Message-Id: <155268631966.16247.2067961556776700130.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Mar 2019 21:45:19 +0000
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Mar 2019 12:12:27 +0100:

> https://github.com/bzolnier/linux.git tags/fbdev-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b9c272cf5cd81708e51b4ce3e432ce9566cfa47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
