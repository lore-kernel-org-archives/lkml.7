Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D84C04AAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 00:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5287220862
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 00:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558052724;
	bh=qH/jYKDYYuG0SN6yqxBilyIgP7RnCizxThvaWYHuv5k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QzA+cM+ycMQc2I6rPf3xhMBycX1DEDxs3RLUq5ELt/tJMsVep8AbUWLTCZAx5qyud
	 eyNTbWVP4RboLqW+CYLklUhtgu0ynt9mKttGT3iYofzqi8iFvM/nGsXIDxgLCHMwtH
	 +DZL4KKV2vbHH0TMuL8M2+R10mseWLPsEIR/AGeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfEQAZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 20:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbfEQAZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 20:25:22 -0400
Subject: Re: [GIT PULL] afs: Miscellaneous fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558052721;
        bh=qH/jYKDYYuG0SN6yqxBilyIgP7RnCizxThvaWYHuv5k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Vcl98VWv5Rp7//8YzH46O/VVvThBFj9AosScjWG4CvWeCr0ipXwKtxZYtMEyScV0V
         PagHby8CS85i1hBIz/uiY6k6xgvLdM/phyDgTSxrNhRAnKQ7rBkAmMllxDuMfSPgqY
         qnWNG0dS8IShSkm02Olpc0yR1A4KzKeg5OKRb/m0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <14411.1558047621@warthog.procyon.org.uk>
References: <14411.1558047621@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <14411.1558047621@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-fixes-20190516
X-PR-Tracked-Commit-Id: fd711586bb7d63f257da5eff234e68c446ac35ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fefb2483dc10c736e4235984fed4f3a61c99e1c2
Message-Id: <155805272165.4154.476286721537774730.pr-tracker-bot@kernel.org>
Date:   Fri, 17 May 2019 00:25:21 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Jonathan Billings <jsbillings@jsbillings.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joe Perches <joe@perches.com>,
        Colin Ian King <colin.king@canonical.com>,
        dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 May 2019 00:00:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20190516

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fefb2483dc10c736e4235984fed4f3a61c99e1c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
