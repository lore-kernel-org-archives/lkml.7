Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23D6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E24C20652
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552257050;
	bh=4GyLBU06Zke7sjvqqRRQFXgKQo+y04ZRH9YyN+l+3c8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NSkZlPuaRGa0NCbwwUwU4ZnUkpZaxeimGof0J0P5MSPXWKmOsX73xPZgkMTlCfwyS
	 TOKDc22HOsyBevTpPczV/AVdyDNYb2UJQnlolYkBDHTMy3AGrIfoyhfOcbVe6b1NJ1
	 pWq/C4UXI2E+zWmbVGaiInJcve8V8FrucXz8eFGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfCJWaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 18:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfCJWaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 18:30:17 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.1-1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552257016;
        bh=4GyLBU06Zke7sjvqqRRQFXgKQo+y04ZRH9YyN+l+3c8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Rv+5ZUfDxyXpWYzs+wFomaIAojvYZJTWm8aAlWpCdWpd1VY1EUaEx7ooVRyLbTnw+
         imZgVstJAzs/rsRI/DzV7wxAVe2FX/1FtSEPsC/aeWG5Z4e8Ij5WENEksUUHr8WoXB
         kDm+blBBD0PNBmQjwL+ZZ8500dmIs6199/w1QQ1o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190308203326.GA48374@wrath>
References: <20190308203326.GA48374@wrath>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190308203326.GA48374@wrath>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 pdx86-5.1-1-merge
X-PR-Tracked-Commit-Id: 9c22cc020db637850ba47a14a598d09f706f19ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbbdf54c7206bf3f201f9ddaa5f4dd87835271cc
Message-Id: <155225701646.14748.638536831279537127.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Mar 2019 22:30:16 +0000
To:     Darren Hart <dvhart@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Mar 2019 12:33:26 -0800:

> git://git.infradead.org/linux-platform-drivers-x86.git pdx86-5.1-1-merge

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbbdf54c7206bf3f201f9ddaa5f4dd87835271cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
