Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64B6C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2867208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564245320;
	bh=RPfCAxdyCyZeq9vRoYR0W1zQ5eAzh1TLpM3NSBsFlVg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ALlWxPO8QJDK+g+gVnhqG1txOqcsPq6OZL2t3ItWLr1ge7uSgip2c9/GoRPZvOb/0
	 WnVuuwWvW4ydN02BvQsoNkrHXzXwrdfkMZdGQ3CFog4gSihx3n7pgqaTYClKhLH7q+
	 A9v7d2FeEmrHPhY1A6tJ2FZyeToZsZJcdT9WbTqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbfG0QfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 12:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728995AbfG0QfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 12:35:19 -0400
Subject: Re: [GIT PULL] s390 updates for 5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564245318;
        bh=RPfCAxdyCyZeq9vRoYR0W1zQ5eAzh1TLpM3NSBsFlVg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=McyoIdXRHjHf1Xfd3hAbU3+qnwqp6weLcI4+NzV2JhVUsEVY1GYlg4XOBaCQWjn7N
         +IlHZMoroeQeOI0Y4x4Vdt0P8nu2JzHYlJxtZeDvYht5hsHQroa8RdaLRf7awpHfQ3
         o7X5iVgJjTI+iAWW0tDYxCFqfQJMjQG/nCupg6Z4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190727094517.GA9501@osiris>
References: <20190727094517.GA9501@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190727094517.GA9501@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.3-3
X-PR-Tracked-Commit-Id: 98abe0227827f45cddb21875b2ffa9aeca3848b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43e317c1bbdfe1d4d6d19d28f925f400898d41b9
Message-Id: <156424531889.2399.16706313874729112396.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jul 2019 16:35:18 +0000
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Jul 2019 11:45:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43e317c1bbdfe1d4d6d19d28f925f400898d41b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
