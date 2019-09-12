Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24303C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE6620830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568283312;
	bh=QoIfUIW2//zSDf/uk/w2ZE+3MttJJNZ75EHcX4w9p2Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zTdMK+bNkOrZbmvs0ynMvs7zePPMjyBnQoMdd8RJT51zBItmkMahT0YgsIIKLAJrN
	 QHMNzp1T3cXQ+o96Nw8V2XMlLZqH5igUnvs3sEUFeTsgFsvaqguxhekncfMvO2+0dR
	 +dY+yDTHMdpVH7C3VJawB0/IW/KAIg8yzyo8O7EI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbfILKPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731060AbfILKPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:15:07 -0400
Subject: Re: [GIT PULL] last pin control fix for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568283306;
        bh=QoIfUIW2//zSDf/uk/w2ZE+3MttJJNZ75EHcX4w9p2Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z+sNysd8DAYG9wUQXd2+w0gkGbE+ymYp8V7XJ8oONO0f82dEbauLy8jIPAdXDtJgw
         5iSIBOPKN6QSMrbykR+MtKyu/lJtigVn1OMyx69vVMhYqr5u1cZp5N47ag/i1lj9ri
         GCNX8rth5ZYiCCJw/n08gG8mGeSMC+oJRngfqomo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdaF8PNXBR2+d7OBWmR7wqRy=iP3OOCJDAFV0rf_e5PaZQ@mail.gmail.com>
References: <CACRpkdaF8PNXBR2+d7OBWmR7wqRy=iP3OOCJDAFV0rf_e5PaZQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdaF8PNXBR2+d7OBWmR7wqRy=iP3OOCJDAFV0rf_e5PaZQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 tags/pinctrl-v5.3-3
X-PR-Tracked-Commit-Id: c1432423a16825ef94e019808ed7330ee33ffc69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 840ce8f8073edb3ff3d2c2c7a6ef211f4176961c
Message-Id: <156828330671.21107.1154397314084653901.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Sep 2019 10:15:06 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Sep 2019 09:28:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/840ce8f8073edb3ff3d2c2c7a6ef211f4176961c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
