Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92458C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A772245D
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570920914;
	bh=+kDNnono7fghKBdBViHtWpIDg48gaQ18KzFvLJjlr5M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mZEsiXUphyqrSV1KYAQwBxX/Z+PsghzNM38/u7LtDQF7Gr62IRSsJgCzskKEvAbV+
	 C20SjXG0YP5PhPuo0O0iCtN8rin3Lxl5umvjxMJvglhHNzd+RPL/G4LVMDtnO3a0rL
	 XGflmv7NFsZApJsd7AExogpALdvtRCdaONF+yq4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfJLWzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 18:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbfJLWzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:55:07 -0400
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570920906;
        bh=+kDNnono7fghKBdBViHtWpIDg48gaQ18KzFvLJjlr5M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qXbdaLC1DParKBYtjxovbMcRWEJRV+WS12Tb5c8brNLFnYtA2pGkKEljB/Fo6ZHNR
         OAH8zwtOm5xDcWbdcHN37mDmcFpFy+O1rku4RHYJ14hjnZriuM/LpPvdC0RdN/WMxc
         8gtD1Gc+vsYojHkcIa4FLlMQkxHQQwyZUak4qHEQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191012161638.GA2191707@kroah.com>
References: <20191012161638.GA2191707@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191012161638.GA2191707@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.4-rc3
X-PR-Tracked-Commit-Id: 3f3d31622a2c18b644328965925110dd7638b376
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cbc63485fd5e25cef5d64c28ca3318364073773
Message-Id: <157092090667.32460.17224656135812760716.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 22:55:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 18:16:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cbc63485fd5e25cef5d64c28ca3318364073773

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
