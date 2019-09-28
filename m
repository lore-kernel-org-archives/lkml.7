Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD87C388F3
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 03:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1394221655
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 03:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569639606;
	bh=jtFKP3EkySB41LzARpvXmneUuAPeP7ujI6kguXSjZzE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=s7MC4o1uXKQmS1kjsrwm2wAt83r4VC87+gwSZpFrPqIxWzuQGTNNB+BQEw3Twrh4q
	 AjvJABOClp+OYpB6brBpteHOVTD34pCCVXugxWnY4Hf3oHbFVQnoZAuq8ItTJ9akFr
	 75+uEJEYBBZRdauAl3jU0/ru/6v+s1vhgL3Ifd4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfI1DAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 23:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfI1DAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 23:00:05 -0400
Subject: Re: [GIT PULL] integrity subsystem updates for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569639604;
        bh=jtFKP3EkySB41LzARpvXmneUuAPeP7ujI6kguXSjZzE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0nknJWqkBgHRjXDoGIYHILxyIfnpb/zEJhc0IL679rjklLpWB8ii3m+z1U9195eYH
         9heY5cspuIbb9r+XVvSBcUY1dnYGy6DCRyuRLhlPmfE0WrPwCYktpfXjseSizGRTP4
         QhK6+DkHw8XGDNXlVgR6XjxEbp8k1hJNqHk9yVik=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1568237365.5783.39.camel@linux.ibm.com>
References: <1568237365.5783.39.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <1568237365.5783.39.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 next-integrity
X-PR-Tracked-Commit-Id: 2a7f0e53daf29ca6dc9fbe2a27158f13474ec1b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1f2f614d535564992f32e720739cb53cf03489f
Message-Id: <156963960435.16958.10604183293405631549.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Sep 2019 03:00:04 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 11 Sep 2019 17:29:25 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1f2f614d535564992f32e720739cb53cf03489f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
