Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28403C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2BB21851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558719398;
	bh=STPbDAqo5Qaz2aAF57J5Ru0rQPuXT+z6enSD+2RIGzQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ncUqe588mW9P8VwwLh9FH083YWcZAr6WvpjfLcr0aNY5PgE4Gn8kxMAkpuniURDNh
	 wUHzD0RokU5Gz+89/Wag3J4Wrt8W9bPrsf4W1wDFz4amcQVOA0FS9d2iKyCLYw6mmJ
	 Hrg4+XnpI6ej7ZiRLz1HDXXyVnUEsuSg51LTj4RQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404195AbfEXRg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391635AbfEXRfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:19 -0400
Subject: Re: [GIT PULL] Thermal-SoC management fixes for v5.2-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558719318;
        bh=STPbDAqo5Qaz2aAF57J5Ru0rQPuXT+z6enSD+2RIGzQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vvYYJ1A3uAxK9UILBig1aMgX3i/KePWRRFC+SGxd3RFU9liy06URL874AmuHQGPTk
         9QlTGgFqEZa4ljtfPuN82isuaq+QJdjYigJue3XArWIwDDrYabrpKq6CmwBqofMkh8
         nq76OL+FIyQgc9yh+4VRIGbz8t4YOu7De/MaHCF4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190524135457.GB2750@localhost.localdomain>
References: <20190524135457.GB2750@localhost.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190524135457.GB2750@localhost.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
 fixes
X-PR-Tracked-Commit-Id: 6a310f8f97bb8bc2e2bb9db6f49a1b8678c8d144
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49bbd8bb34a48267afb116c3dcfe0cb30b6638cb
Message-Id: <155871931816.20356.9691581192914440240.pr-tracker-bot@kernel.org>
Date:   Fri, 24 May 2019 17:35:18 +0000
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 May 2019 06:54:58 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49bbd8bb34a48267afb116c3dcfe0cb30b6638cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
