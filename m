Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B0AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E0C2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553282113;
	bh=u9TFq3VoG9TRDgj5OilvxgpKnbNGls4trT4RA2sjIPI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZUahg4IIot0XRqVBrVEjSymjGsmwsSXketLC0RwYQJjifzSr7lKaXIaomI1BgWJqf
	 hZYr+S6qOlP+yiy901Xo+kDRCBBkEDQ7GJduj/C+9A0Bw/8pU31/kDExjLVnaFk2SP
	 VEBWNG8dPTtG/nbtr1qNAqkXKcTMIW4zlJeXLhgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfCVTPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbfCVTPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:15:11 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553282110;
        bh=u9TFq3VoG9TRDgj5OilvxgpKnbNGls4trT4RA2sjIPI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=d+XRjeofD2cWjoruxlVVjWvblIRtLfukCGVhZ9GRjXdrkWzF48sTBVb33A6m0SWHh
         ne1FXv8cVVdP8+S3NH53QPT9oH1ROPNQHCikqdOO4Z7vPzU8HFdlXE22gHcD3xrP8z
         tdwiMjFYIMpOIQTpr5+gmvwMY7YmuJtVVt2guUmk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190322101536.25315-1-ulf.hansson@linaro.org>
References: <20190322101536.25315-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190322101536.25315-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.1-rc1
X-PR-Tracked-Commit-Id: c9a9497ccef205ed4ed2e247011382627876d831
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 599beede718182cd85d5e1dc2d4e523c05d5014c
Message-Id: <155328211087.18163.12283095596592676925.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Mar 2019 19:15:10 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Mar 2019 11:15:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/599beede718182cd85d5e1dc2d4e523c05d5014c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
