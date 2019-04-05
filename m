Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CD2C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A213A206DD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554429309;
	bh=4YBWuakowF3IbNneYISPXSY6Fi3V8Ar/5NvUefw/7Vs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wR5YvmrfcmL73Qbvj+GUCXq0niDMohMoImJ1l14gPIcCo7gp/hIHuhUIcft6BIcHT
	 J8Pdl+GZHqMjbPWx7zV26cN8i2ozCccu5+dysRbUpNQead8/Qeav8eXb8saU8uMHmr
	 3DLm3YFyiyXIb1SyVv9BmVI6W3uMxJMX9kaxRgVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfDEBzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbfDEBzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 21:55:08 -0400
Subject: Re: [GIT PULL] MFD fixes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554429307;
        bh=4YBWuakowF3IbNneYISPXSY6Fi3V8Ar/5NvUefw/7Vs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=k3CJTgDJR7C+Uqu5EamUiS3igHdaDeDMunKNRRRpYQ2DdgTJqU5NpbtaLyAAMVgQv
         EqAkfyMW2754xaFlk20wMDvfRMjojl3u1sd/IghNdxDtIceB40fPwBVhkXymo3md5P
         spVQbhfs8wrNtgmhLEr5nNCw4RE4FlMrN9g4S6Bo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190404093747.GU6830@dell>
References: <20190404093747.GU6830@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190404093747.GU6830@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-5.1
X-PR-Tracked-Commit-Id: a05a2e7998ab1badcf80aed47b5313934fd131fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9db6ce4ecefb03698cb2875c1a46b9513303a9bf
Message-Id: <155442930747.31474.5818866356498302925.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Apr 2019 01:55:07 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Apr 2019 10:37:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9db6ce4ecefb03698cb2875c1a46b9513303a9bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
