Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FEBC742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 18:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEF7208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 18:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562870123;
	bh=uLI8XsUrsMivjpRt4GLRCsqFss+e5wuvCE81sVyzSXQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=retCpO2LGzabnY2x/SenqI64u5tZMW3ML63DKP9JbzhEssXQqP3Sb9gkmQweSS2j/
	 ZCGTH9LcXKp9K0yyWPpICbeNUIpQTILq8FP2rlPD5zo1D0bqPMogvoSX5Bu7Kj0WXr
	 NDtYAGap+/3xKrnXyW9czXIMiGAB+75JW9KKUIuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfGKSfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 14:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729071AbfGKSfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 14:35:09 -0400
Subject: Re: [GIT PULL] ACPI fix for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562870108;
        bh=uLI8XsUrsMivjpRt4GLRCsqFss+e5wuvCE81sVyzSXQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pjWk15XfEhaAZYrI0Le8Nv+09mX0zlWVsLN/FsmHAIBfxYmFkI5PPJ9VDvgjYor7C
         d6+Gq+q0dCh9rtU8NrRx80tKrFT/cMBoUxIh0InrrKLiuh4jh/ePFkW6k1xjLLrVze
         01sNQqPWhjy2VIpjP3iiJHwjFnMtRt/rBGliXWDw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jTMK6rMomux6JfmRX_nRxZ+JqA_V8WKt-UJTGus6TfOQ@mail.gmail.com>
References: <CAJZ5v0jTMK6rMomux6JfmRX_nRxZ+JqA_V8WKt-UJTGus6TfOQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jTMK6rMomux6JfmRX_nRxZ+JqA_V8WKt-UJTGus6TfOQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.3-rc1-2
X-PR-Tracked-Commit-Id: 6cf7fb5a95dec9743f4bfd96f9ece580a355cdd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a131c2bf165684315f606fdd88cf80be22ba32f3
Message-Id: <156287010892.13847.8485955181846012272.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 18:35:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jul 2019 14:40:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.3-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a131c2bf165684315f606fdd88cf80be22ba32f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
