Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783B8C73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5083220820
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563150627;
	bh=HGZkToVBMiH0lWom0UqDWMRfoSCaV68CgN12j/lo6EE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vf49ZmA9CqaApyHLKPDPAOYPYLn6KIwFev2LbwzRLJt4tDtc6/Tw6D1G6X55M++Tg
	 IIGVBYfKV0EfJPW8d72GNAbG0sR+WTRmYCFXFjU208iU1vGS9K8nMlyVIA2LuQig6S
	 HlBwCRcMVES0jyQ9TQAXDH4parCFZxdmm6s/ykM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfGOAaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbfGOAaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:30:16 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.3-1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563150616;
        bh=HGZkToVBMiH0lWom0UqDWMRfoSCaV68CgN12j/lo6EE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=x5JkK2dZ6wVyg+/kSWTjhXhfxft4bfeqi0NtvKf2ZQQZiX3VsUGT9OScJgPTU+6WA
         rhJBikuJD3uHTLVs9qwvdNieNfj9A4fByGgxkwetm/ylwoKGH7nduCmpoecmkJ1O3G
         9p38JU9Bfoh+p3qtUV47OoMhACBg9jj36ytiL7fc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190714145337.GA15206@smile.fi.intel.com>
References: <20190714145337.GA15206@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190714145337.GA15206@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.3-1
X-PR-Tracked-Commit-Id: 7d67c8ac25fbc66ee254aa3e33329d1c9bc152ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55167453111d3a1e600e29ba6c8e63906bb4821b
Message-Id: <156315061624.32091.17161337811621093872.pr-tracker-bot@kernel.org>
Date:   Mon, 15 Jul 2019 00:30:16 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Jul 2019 17:53:37 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55167453111d3a1e600e29ba6c8e63906bb4821b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
