Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA16CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9599E2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576610427;
	bh=k025urYF9nsxiTFGHlVkFAA5o98IVs0ViWJ5JSiKnCA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DBpWXKP9VaM6TVLkNImi+OHuX/pL5+OxBn4CSxoczy1HWzCIWCcuTmEH9Jxsk98rz
	 oH7lA3Pgklzb5ICepfHSX/LV8aWeXMcH9sGDaB4rGBO1SYcKfKJrYOVIlKP7mchW3D
	 TeSOSTcNrR5K8xNrCnzJy4M9zhLlRhCS/LeNYCEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfLQTU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:20:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbfLQTUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:20:15 -0500
Subject: Re: [GIT PULL] scheduler fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576610414;
        bh=k025urYF9nsxiTFGHlVkFAA5o98IVs0ViWJ5JSiKnCA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=C7HnPHTHGalvLbN76cKPdRQfYZNWdLsbXTe/KNEZ5oHvQLPh6lcnY/5v8ZG1dfaGm
         A5w4iuQ/qxQhNwsNws3x1+ydNfA4lX4JyOvpmzuw397+1N2f6xAoFouaDUHR+Ev+VP
         ynMETJDHTMn8MfWI7k17ff23Rn6DDUYZ09W1EKUw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191217115435.GA28382@gmail.com>
References: <20191217115435.GA28382@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191217115435.GA28382@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: 346da4d2c7ea39de65487b249aaa4733317a40ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4340ebd19ff031fd97a69ea7e7249c898f2d3e06
Message-Id: <157661041482.14288.18368751296627987361.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Dec 2019 19:20:14 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Dec 2019 12:54:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4340ebd19ff031fd97a69ea7e7249c898f2d3e06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
