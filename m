Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C0FC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4B322BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564165522;
	bh=b/XK1avinO8iWGgjOm5rDg/V6CpYBEJTsRga8ZNstOE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Yf5o/9goay6AXyHP/jKmnGyJbzVOXkDQtTpWYtgMixNoJuNfaWgHB82XM4c8++XgU
	 WROtKUlYAaqIYupu3L5fPWlkxVuQ4+PBGDeHrw6x5oLLW2vXFOkIYaFWca6JFKWEp5
	 h2fC/+EvpGGheAv7eMsgc7JFhnYIingvkRE1LIYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbfGZSZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbfGZSZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:25:21 -0400
Subject: Re: [GIT PULL] hwmon fixes for v5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564165520;
        bh=b/XK1avinO8iWGgjOm5rDg/V6CpYBEJTsRga8ZNstOE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2YyVAch3banE+QIY7oHqFPzytm4sHNJ5AI09dbjFnLf+w0LXy1oyJ/QTQPczWVe2Q
         jtYvMAXHte4E7lsddBtyaEZQ6t4p4Ai3fLscM62iDLQLoYfvHWvYzeAGVhGSruHGHB
         PwW45ioqZTfC/5rQc5DVdBl4v1bmurmOFva8KerI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1564076444-24557-1-git-send-email-linux@roeck-us.net>
References: <1564076444-24557-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1564076444-24557-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.3-rc2
X-PR-Tracked-Commit-Id: 223b2b5030f370f219c23c2c4678b419a72434d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6108cd475ca8323fa9d9b584c44a5229a9a26aa5
Message-Id: <156416552020.19332.135687563371650641.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jul 2019 18:25:20 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 Jul 2019 10:40:44 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6108cd475ca8323fa9d9b584c44a5229a9a26aa5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
