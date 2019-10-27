Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C258C47E49
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 11:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024DC222BE
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 11:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572175808;
	bh=HaSsw9hH1vGd8/o9HpBBVGAVC+2EIzR1IHg5cpZS55E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mtDQ2bQc6N9b9wmd2TIf16qGMbsLR04rr0QpQMU5kurGEi7XgIU6K+pz6XzaSg6Eb
	 PLzFsVdV/s5UjTsswHahXs1jipY5+lzg1CkGofpo/f+6/NrfivWHlGVe/fIINHmd8K
	 TG0yINDIQUwxFtZgnDR9ySPdjIEZlRAkbTQ2M2sU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfJ0LaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 07:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfJ0LaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 07:30:06 -0400
Subject: Re: [GIT pull] irq/urgent for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572175805;
        bh=HaSsw9hH1vGd8/o9HpBBVGAVC+2EIzR1IHg5cpZS55E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ETeXoa2JUPq+eJiL9RMvrBgxgzLjGV+a10RzFEVdUTVm7POx1lyDBVYmtZD3486F/
         vLSujoj8VBx0k4MgWawVLXQuCUXQCTHQ6cf2TG2REJqSy0Bz8dPvsjsNcob1nJ6r2S
         5t8YnOoF9TTcB/GJ0ztWv5V8Ff2GUqAQf0+2rE1A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <157215878694.13117.16411564430107054752.tglx@nanos.tec.linutronix.de>
References: <157215878694.13117.16411564430107054752.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <157215878694.13117.16411564430107054752.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-for-linus
X-PR-Tracked-Commit-Id: 1486b7b42bd79799cc62aa2c65af03e103802b40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e1ac1cb651ae781ee346cb129e0bdaed0cd7438
Message-Id: <157217580588.15608.9933604692913448861.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Oct 2019 11:30:05 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Oct 2019 06:46:26 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e1ac1cb651ae781ee346cb129e0bdaed0cd7438

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
