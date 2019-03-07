Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49972C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182FB20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551994823;
	bh=f25qrloMA+9/PpBZBE0/WtuNy/3vTNc6Qou4Bp44Gto=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=iu1btRMoAKqAuJLwkFttTMc437TsUO6SNebZWCNOe29DrYl3kylYOQIqtLW3B4pmU
	 Ydv0OgKzTAW6kmaEZW11hVDc9ZyNMo/wAEXj5p/kSHA/AQo7aZwTSkgggpwBv1dYPf
	 EWW5iXK2toe1foxohjuGq92uHzTbDLW7cY0ZXUMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfCGVkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:40:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbfCGVkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:40:16 -0500
Subject: Re: [PULL 0/8] xtensa updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551994816;
        bh=f25qrloMA+9/PpBZBE0/WtuNy/3vTNc6Qou4Bp44Gto=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Reik8CWvJg31EhFLDYNqnyDwrWhP2TXmjPV0FvtvqfNzgMiyBPiiXDcplSR1hqeDk
         GbvIhGIp+ctyq35rQy6rppXc30eVJ1+/7RpRcV8N9U//5l0VeiI4LJkS73dd6cpiXx
         +0VYg7z9Yy/N2jc7GJng3LVubHTSWx8Gn54bzUi4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190307155218.26272-1-jcmvbkbc@gmail.com>
References: <20190307155218.26272-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190307155218.26272-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20190307
X-PR-Tracked-Commit-Id: 60deebe6149a3f02fa6a9fa988dda500effda43f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd1c3ed76f26504621b5ce08b894666aafa38e47
Message-Id: <155199481627.1630.10833946468877525092.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 21:40:16 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  7 Mar 2019 07:52:18 -0800:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190307

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd1c3ed76f26504621b5ce08b894666aafa38e47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
