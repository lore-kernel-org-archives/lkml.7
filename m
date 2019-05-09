Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18418C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5552173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557419135;
	bh=xto6+id0Mi1ewqtcVp1HIIrd38CrS4FIKCZ/SeV5aRU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YrtI5Jai6HeDUuGiGto2T3i3XgCglYkCtwOCBiYeTjpeWrapC2A8yiw5WLLhRgBmG
	 QD6eujejAXR4pXrcDNBHzkRm2lIpIl4MTBTH3VqJ8UdTSSEcHISbkg7dSayShVwDOd
	 CPDeJQ740mNXSGw4Fo3uHqdB7UvQ3Cv5wrClRRLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfEIQZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbfEIQZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:25:15 -0400
Subject: Re: [GIT PULL]: dmaengine updates for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557419115;
        bh=xto6+id0Mi1ewqtcVp1HIIrd38CrS4FIKCZ/SeV5aRU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RJ01z0r5hV8yRJPQqu0moSU/03WIYLne678hMSvMcMSHigwHAFIcwnGupTHDKRPvC
         wpW/Q6Yf2IE1TXMlfVg+e8OdnmMb8CnQRu3/KV8MufZQP1OxI7KeG/GM1QhZTpuZTT
         eU+aOgXUi8y73EAoTtolXWWU1pRTmY/z9H9bMJOw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190509074615.GB16052@vkoul-mobl>
References: <20190509074615.GB16052@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190509074615.GB16052@vkoul-mobl>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-5.2-rc1
X-PR-Tracked-Commit-Id: f33e7bb3eb922618612a90f0a828c790e8880773
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 055128ee008b00fba14e3638e7e84fc2cff8d77d
Message-Id: <155741911494.30533.404952002387503115.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 16:25:14 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 May 2019 13:16:15 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/055128ee008b00fba14e3638e7e84fc2cff8d77d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
