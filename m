Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C58C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294052075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552326619;
	bh=QEwqF4L1wKCCkyl/jBq1fJj9NvoHvvbaYtpE3Oibgh4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gtHNnn+81aWHpu0m/Fx8wqRW7eqOnfhKUwihieKTba1GCBI2zrMcijLduPM17/mhi
	 5hJYOgvUT4QeH3Oa0pa+rUmqe24JG4agE4F1fzwGSbMb8KRTnFtN+v2wIe5rOCpquk
	 jV88iqgEAk+W2Acm3yrMcOULT4frBU8BUACHr0Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfCKRuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbfCKRuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:50:16 -0400
Subject: Re: [GIT] IDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552326616;
        bh=QEwqF4L1wKCCkyl/jBq1fJj9NvoHvvbaYtpE3Oibgh4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cs6cDVsdQ2aYMQvgsgMQsOUOYILLikWNhnyr74RXoS/W8mcnHN57I8s5N4+1uRAgA
         V7PoF6quRrGuNwZ4mvelhonWL/H1/EjM5mZkHrN2QycLFqwSyylgQ2/iV6Pnyps3ZY
         y8wvCE/tFrW2XTSsmYKdTyMjKJuf6mzeenhcOUlk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190310.220058.191106608509733546.davem@davemloft.net>
References: <20190310.220058.191106608509733546.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190310.220058.191106608509733546.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git refs/heads/master
X-PR-Tracked-Commit-Id: dc5c37736d16ec90559888fb4c974977fc8ed1ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc119dd954ba172554b4cc49db249c4fb62701e6
Message-Id: <155232661599.15626.16449670611049899402.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Mar 2019 17:50:15 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Mar 2019 22:00:58 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc119dd954ba172554b4cc49db249c4fb62701e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
