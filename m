Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61399C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 00:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D7B20803
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 00:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573950932;
	bh=n1ne2bx6B9Uogy6WVvkHV8yLTT7+/NmlZGunvMj7cic=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=d48rSf0Co9WdVPktU5aLecGThu8wVVof3XKTxBEkoakHF/Rr7sEknUVpVse2BIAQo
	 Jha+LCMMaUhDFuOwsLF/iTVkBSAsC7MECLM2JbuDvWd15u2Jrj5SedqEDXsNcE4lBB
	 4lB5dMTqXQwLKilF0RRi6FiAeeJnxb2gdEQGbzZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfKQAfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 19:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbfKQAfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 19:35:06 -0500
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573950905;
        bh=n1ne2bx6B9Uogy6WVvkHV8yLTT7+/NmlZGunvMj7cic=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LdsjWm/SFL2CB3S1eLRZPKSAewqm9BkkJU9PcmGUJ1H54EHGnGjiadSMqntiZN5j7
         NryYlU6v1KUCzfgFMmZU2PHfvOOXMuGUZ3cocynRm2JABLq/EWKuiTi9/0WIZ2U340
         Ui4r231JNc5+h5Yt013BGYfeGydL0jp2HvM61IfQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191116213333.GA84250@gmail.com>
References: <20191116213333.GA84250@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191116213333.GA84250@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: d00dbd29814236ad128ff9517e8f7af6b6ef4ba0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ffaf037e776fd5095561c27d879b4484549f7e4
Message-Id: <157395090558.15664.9653672687893480188.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Nov 2019 00:35:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Nov 2019 22:33:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ffaf037e776fd5095561c27d879b4484549f7e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
