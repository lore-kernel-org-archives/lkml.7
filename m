Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A70CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 18:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB9421726
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 18:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572719711;
	bh=eiZzhL1O6YabUspGhnWYfrC3lKMGuzssP/86xUeYVEc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GFu+7ZX8BIfh68tX3YSTB9tkaxCC8jBPElBSAPn9rI5OVCfHbEA0klfJoqpPyIX4V
	 k+KxUNRkJFn176tX5UO/Z0FwEhhyNzMzkhz/XytBZBHBr0bK1iBCh/aHOKPiUqBH7+
	 6NSdC2pQIPZiJnn4eHCvsyNuacsglu9cRJWXcG0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfKBSfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 14:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfKBSfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 14:35:06 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572719706;
        bh=eiZzhL1O6YabUspGhnWYfrC3lKMGuzssP/86xUeYVEc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LoeUDF08va9u6gGWljUU67yJTMANqVpTtJX3KhMXeASCb2z3C/kOUTj8jhQf9MxJz
         sbFZEbkzUfghZbunZ2ht8+MhkKE5bI+Z10eyF2VltQAARgV3pjjof2j1VvMDJ/Pdk2
         fhr2PIJzIicjJd+SZKpXs8tIdexuaWWvw4d7pS38=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1572656827.19347.17.camel@HansenPartnership.com>
References: <1572656827.19347.17.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1572656827.19347.17.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: d3566abb1a1e7772116e4d50fb6a58d19c9802e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f83e148a410006397f01e96570e73038a3a261fa
Message-Id: <157271970595.32009.17466862093149055769.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Nov 2019 18:35:05 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 01 Nov 2019 18:07:07 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f83e148a410006397f01e96570e73038a3a261fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
