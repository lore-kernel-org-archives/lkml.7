Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6ABC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DDF2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555701032;
	bh=XhYlhuiCOFlGMP2DC/a37OAte6ZolXGK3t4HmzCf3IA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=MF19zuDvoetgH4BilN2pgjRjgwOoJp4f3jvjN7Se0jhcTOjtSnHwpnf7t92l3DnFZ
	 ksB6c4I0sL7a+Q5Qu5OTMyEwGVfhALL9i/BRz+ZRYQUGFDJW0ZSiin8sSw8fTLmL05
	 p3hnMBZetAyKyMSGl0YD7Lo4zsGdG0tSGSnm0m2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfDSTKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728871AbfDSTKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:10:05 -0400
Subject: Re: [GIT PULL] Staging driver fixes for 5.1-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555701004;
        bh=XhYlhuiCOFlGMP2DC/a37OAte6ZolXGK3t4HmzCf3IA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qcs8l3liyIotWlS5JATV8ZQhOwUtp71qlkpoaN55zwVSeGAy7XeJ8wJ91xcKM5ZZ0
         iT8sfXSBLa88R1mR7Q7a67eAdT58SzbLkc+KYpKm3MUK8hafcL1Ir1ofBjVL+hgajR
         CJV4pIv5rPlOK0WrgXKTxjqoyh5W+f7tiWTlj+II=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190419123104.GA4800@kroah.com>
References: <20190419123104.GA4800@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190419123104.GA4800@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.1-rc6
X-PR-Tracked-Commit-Id: af4b54a2e5ba18259ff9aac445bf546dd60d037e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b222e9af0a250141b302d671d2d1e73e9079c544
Message-Id: <155570100463.4805.16252577845867903954.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Apr 2019 19:10:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Apr 2019 14:31:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b222e9af0a250141b302d671d2d1e73e9079c544

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
