Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB14CC7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 00:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BB221874
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563582625;
	bh=1c7B0+Qqk9SCZ5GilmZEzCp+lhLyyQB3B2Nt5Jvl2iI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Id3h55GBCbmMV5eyXlZXmdLr/CJfJnnFS9BF7+d6GMsJpTdsE8aONIJSx5yPQadr/
	 3vZX+gB+0lwVXwwFMK9TMtIUrhNzKgcHruOzZRq74q13FRUaSxixzwPRkVBNDA+8yv
	 Z+OXdxU7noXHMNQbvAjqSdnnOPJYno5gelHRxJIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389325AbfGTAaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 20:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389282AbfGTAaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 20:30:23 -0400
Subject: Re: [GIT PULL 1/4] ARM: SoC platform updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563582622;
        bh=1c7B0+Qqk9SCZ5GilmZEzCp+lhLyyQB3B2Nt5Jvl2iI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VSu72xMQTLNZbyUqmbJOWtOKjn9Qk8vEhNjLPX2pMUGr691esLd0RcSja6gIjF1Gz
         hHhmkhMzuVDEf8cYO5Th19CzOCfBvLPrKAGSItqkbEev8hQ+HNTe23anE/PU6Wb+U0
         JEH+U/k1oH12HhmGs79HWBXKMsHrjoCdfGCX04/U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190719235434.13214-2-olof@lixom.net>
References: <20190719235434.13214-1-olof@lixom.net>
 <20190719235434.13214-2-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190719235434.13214-2-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc
X-PR-Tracked-Commit-Id: 7e8a0f10899075ac2665c78c4e49dbaf32bf3346
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24e44913aa746098349370a0f279733c0cadcba7
Message-Id: <156358262253.21220.10268942999565602929.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jul 2019 00:30:22 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, arm@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jul 2019 16:54:31 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24e44913aa746098349370a0f279733c0cadcba7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
