Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8002CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D33320663
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554308712;
	bh=cXlZ/7jFVrTauW0aK3xBs7ADlkVRsAY3Omx+bO4mTT0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FHtm+f71qg/vcggmeIQQAa7UQ6sR2C99WyZNhV0OM6HCXbWCuA2LIu/0omH4PP0cR
	 rYmnBBGwfZU81PZYYt1KaIkHWN79XmlM1ZLxAuzX+kQr7AQdu1hKgnvzirCKgfIIUI
	 s6u0MtDTLahQf/6K56pGrjQeouYI8hAcmV+XZ8zQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfDCQZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDCQZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:25:10 -0400
Subject: Re: [GIT PULL] HID fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554308710;
        bh=cXlZ/7jFVrTauW0aK3xBs7ADlkVRsAY3Omx+bO4mTT0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JtkUd3bTQyQVDcR0UEgzmkdPsaPoDG5dSp1+FxfhGcNXoujtVDWCza0BSTomW6TdQ
         h4RnZz5tVAuq8ggs4M98/90k8Zg/pZoat5V9hymvSWVtp/UnDyILVE4eub8nnSJsx5
         70WKnFz6552xS0vTlR4Map+rNMvw4EgOO+G+xcok=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1904031532431.9803@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1904031532431.9803@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1904031532431.9803@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: ce856634af8cda3490947df8ac1ef5843e6356af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ed86627f715eacbd6db6862f9499d6d96ea4ad6
Message-Id: <155430870999.15873.8097661580802499720.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Apr 2019 16:25:09 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Apr 2019 15:39:18 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ed86627f715eacbd6db6862f9499d6d96ea4ad6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
