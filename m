Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21708C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE20208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565465431;
	bh=/MY7PhLd37YH/wdMTgO6N+ydgTFsKhDO5FePe94NBMg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KzHisANRLXWhvt9IFia3gsHKOzvXcyXEygGzsUZZs/2WXKdx22Og5EZXd0bxvewj+
	 HySoR1NEurVcRe5+v32OfePIgIt54M/T4agL493vbHx3dWUh7n3o0wK9o4CyGOJPBR
	 rfqt3nKIN104DzpN6ryoNE6CMO45zn2ux8i724zI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfHJTa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 15:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfHJTaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 15:30:10 -0400
Subject: Re: [GIT PULL] USB fixes for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565465409;
        bh=/MY7PhLd37YH/wdMTgO6N+ydgTFsKhDO5FePe94NBMg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X5tFqghR7vr0cF4ZqKBhCHkMCCPQtRmJeUe3i5zGPreBxPV2Mfyil1KOl7Glg+p2l
         hzYNAU48BGPe94x8mBgvojVfFnS6KIQluDGSeYzvlmN68UzZ0cG9gZX6LlcmF/U/RO
         ua2ubBnI4JTDj0iETvWBWURiwlGddyF3/nFLEFEQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190810115155.GA5792@kroah.com>
References: <20190810115155.GA5792@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190810115155.GA5792@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc4
X-PR-Tracked-Commit-Id: 27709ae4e2fe6cf7da2ae45e718e190c5433342b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1041f5092179ab3dfb8ceb8f1f54bc07d4ba3399
Message-Id: <156546540951.17840.15634832738313165993.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Aug 2019 19:30:09 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Aug 2019 13:51:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1041f5092179ab3dfb8ceb8f1f54bc07d4ba3399

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
