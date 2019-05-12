Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A93C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 11:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4D6216C4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 11:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557659114;
	bh=HkYTfGAgPW2YJ00yz0r5CxOsTO7v3THFF8oQwyDSBto=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=V/dwGD7GPcAz98YCD/0UEns/L00joecAIFAGLbvSeZm/Y/sOI3TX65b68VK59gfnN
	 moQ4SZ6VXarpnu5+6+chRliDJRAuQjxpfkT2BfUhj4eleLdMTN6qx6pp4Oq3MDZ6vp
	 cv8QNXjgr3BwdlKRgeBWGieFgDY3EsXxRTl98PZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfELLFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 07:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfELLFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 07:05:12 -0400
Subject: Re: [GIT PULL] chrome-platform changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557659112;
        bh=HkYTfGAgPW2YJ00yz0r5CxOsTO7v3THFF8oQwyDSBto=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y9ijwJTLT/bX0ewICiHHTOkc4KSLHu8ztmdROPtK6YBjlmdqHLyU1oH69S6c0S7e/
         IJqqa5eE5290A7+oxsxngYhsaPJEJnw0M9uNfslwhvMaUjSB+4WzupSF0HVgCVutfW
         kal6yba1bngPrOmkMSGegDW8KoQ7jl0S88izQCeA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190512041324.GA7523@google.com>
References: <20190512041324.GA7523@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190512041324.GA7523@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-for-v5.2
X-PR-Tracked-Commit-Id: 58a2109f6eb46b2952e2ce3fe776ce02c0c540dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47782361aca21a32ad4198f1b72f1655a7c9f7e5
Message-Id: <155765911209.20287.8535606605448263850.pr-tracker-bot@kernel.org>
Date:   Sun, 12 May 2019 11:05:12 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@chromium.org,
        bleung@google.com, enric.balletbo@collabora.com,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 May 2019 21:13:24 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47782361aca21a32ad4198f1b72f1655a7c9f7e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
