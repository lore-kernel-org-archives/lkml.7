Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6870C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B60F2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576878912;
	bh=yDZkkNYzD3FWAU/SrWygpNmHhynYzNaJvIqIotWBGXc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CcmhheBYAK1MiWWEwweq4CMOyew7CTgUGBU8wGo9tcKm/tg/ahu/+82j8UjNrlQgd
	 xSuoJwWGZqDe1F4HVxvGb4WDyREMl+cZO1baS/gAYPb+DQgIgKIb4t9s1Io9X1S6V1
	 9uFGCou3ciF8TYx8cz3oDbsahBG0ewyqaSDmYAL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfLTVzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:55:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbfLTVzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:55:11 -0500
Subject: Re: [GIT PULL] Devicetree fixes for v5.5-rc, take 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576878910;
        bh=yDZkkNYzD3FWAU/SrWygpNmHhynYzNaJvIqIotWBGXc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=18cU+GffupsWdRJkIxiR0slE2TNLSK0JRAgAm1AjrcPr6wFE0glStEBkOusfey1H4
         mqtovn4MwPPNc5NQcRuUGNjMqOQmgTtSmDT6a1UltCxYt+otsAcHPwl9ILNzWngksQ
         LQzEMvkGWlqrUGS89iG9vNz+UNkGjt/aaTOpAzXs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191220213832.GA23111@bogus>
References: <20191220213832.GA23111@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191220213832.GA23111@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.5-2
X-PR-Tracked-Commit-Id: dbce0b65046d1735d7054c54ec2387dba84ba258
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1fd1610cbb6655883d1838ac79e53301596685d
Message-Id: <157687891063.23463.16217436355639459996.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Dec 2019 21:55:10 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Dec 2019 14:38:32 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1fd1610cbb6655883d1838ac79e53301596685d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
