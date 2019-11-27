Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DAAC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C80520866
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574880313;
	bh=9Y6urMfo/WtH37ZXWaJG/+YOOHf7aheCluy0mcR+tss=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xkirY3uGZLE73j/ShWUym1ALjGS/HphACOv1jbpsoblSRpGEOolLn4BDCWs9D9XIl
	 h0JTsMvHXPzjbr2jCNtIX3DUA3CuBv2ZgspHxRCoaCr3ZpXLeBnOnIf8JKkfsgv3z3
	 Ep7yqPmwvIocy8PsbRllvXT6HLSPtDM1dfI5cAyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfK0SpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfK0SpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:45:11 -0500
Subject: Re: [GIT PULL] power-supply changes for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574880311;
        bh=9Y6urMfo/WtH37ZXWaJG/+YOOHf7aheCluy0mcR+tss=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2rk+pg5KhVLxjKo8IhLk6tEwJQGdNAJC8D7AQs995hcNypWbgaTk5EQsVQxdsxqj5
         jy4MADYr2fWgIwq9ckPCrj18Uqbt16dulBsIHctjZqrR3Uq9R40ZwJrRif1Z+1TSX1
         Tn61QDFG4c03K2fRNHcfnmSPIXItYYNnlOYdrt6Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191126120940.sjiiqdngnbez2a7x@earth.universe>
References: <20191126120940.sjiiqdngnbez2a7x@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191126120940.sjiiqdngnbez2a7x@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 tags/for-v5.5
X-PR-Tracked-Commit-Id: 9480029fe5c24d482efad38dc631bd555fc7afe2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00074a7007c24f947a9f9baf66bf5db2fe651ee9
Message-Id: <157488031131.21185.10311186896979421766.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 18:45:11 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 13:09:40 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00074a7007c24f947a9f9baf66bf5db2fe651ee9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
