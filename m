Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C900C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F395F212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556304015;
	bh=/dT0KatIm2qeu9TL3/hi4F/YkNdgRSu028ugvnbXL5Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=B/4XCefJOFngryet2EySQ5+67Gw1D6HBBzOt+VgYDh8fibdjEuLa2DjFtJW8IvNWd
	 S2+rLzoB1DdgvuW0OLsnL22VGndMy3O3woPhdaJae6urNvv8R4lRC/f7G97kgeTv9w
	 7yItELTZ5knem1R6WeoGGzLN8Uezm/VSpVLsfPS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfDZSkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDZSkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:40:03 -0400
Subject: Re: [GIT PULL] tracing: Minor fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556304003;
        bh=/dT0KatIm2qeu9TL3/hi4F/YkNdgRSu028ugvnbXL5Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gs5k8eN1bVxt1FmotWf9XPP1Y4gTxxOhut/TcElDTLNnyh8TCX9Fjk5VV8hAo5ktf
         TWKHlJXfq/c4izmgmBDBgs5RW2qc18Uu//9tSBWpc2ajvcSon5fEqhQxfcPH+Lg2kU
         eo2zI8InhdwMLpJY9IDiRxYbj1n+jMSOHAWRQgxg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190426115357.3ef86b4a@gandalf.local.home>
References: <20190426115357.3ef86b4a@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190426115357.3ef86b4a@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.1-rc6
X-PR-Tracked-Commit-Id: d6097c9e4454adf1f8f2c9547c2fa6060d55d952
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9e1a2e7b486e3940badb6d743c8841ed94517b6
Message-Id: <155630400327.7251.13635658683745564163.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Apr 2019 18:40:03 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Apr 2019 11:53:57 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9e1a2e7b486e3940badb6d743c8841ed94517b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
