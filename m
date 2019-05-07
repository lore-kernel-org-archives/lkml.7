Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70508C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DC920B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557262216;
	bh=PIYPazlUEh0lgoNcgBXhB2SfLAyzO+xIBmhZLMjWV5Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IIyxNEsk7aw9kmzhyI4mmwNCDu5m7CgoiXNLvrMEpxafCPWdzh6sWgMTEQnCRCz1+
	 2ec8dvDByWYQmthEaYiwjBfp98xWLVATazAfynrNK6Fl3pJbZh+PRSyIvFFC56907m
	 0f96oWkgPbPdH/QRl8MqTTXP9zHfN2CGMl6sEU5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfEGUuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfEGUuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:50:13 -0400
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557262212;
        bh=PIYPazlUEh0lgoNcgBXhB2SfLAyzO+xIBmhZLMjWV5Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F7NDGspFlG4SUgBRlo6m+MiV8QHOB9wsK21BJ3OU1XHt+eUjJ+MDLcuks6xZIBX60
         HB07N1hRuXQRxijZHlIdNqDphauw/6/C/vVkCowWZOI18TL1jLDz2UW2J3XBSWFaUW
         wcM/HkcCaDcj37ali9xlRPC+j37kJsDMK7KNbmtE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507175853.GA11568@kroah.com>
References: <20190507175853.GA11568@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507175853.GA11568@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.2-rc1
X-PR-Tracked-Commit-Id: e2a5be107f52cefb9010ccae6f569c3ddaa954cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0dccbdf5ac7ccb9da5612100dedba302f3ebcfe
Message-Id: <155726221265.25781.16397640357875096092.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 20:50:12 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 19:58:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0dccbdf5ac7ccb9da5612100dedba302f3ebcfe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
