Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8292C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4E6218D4
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553452819;
	bh=+lxsW0A+a+LlvszErDXGs6toECBchrpW4I4pP2O+/gA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HP1iWNBTEiGJuK7Fk8LB2fbG8yCtThLsgv5o8bgeptWuwxhFHjhXlN88abrVtCGOT
	 JadgddomuZWmlv5V7FFoX48pnYhsISQExpXDFV2OHBZC55m6OHzsEc/545zNAs9P8H
	 qwZBtIfAZkjvukKX/C+tLGvPsMWS6LGu7Wp7viAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfCXSkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729154AbfCXSkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:40:15 -0400
Subject: Re: [GIT pull] perf updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553452815;
        bh=+lxsW0A+a+LlvszErDXGs6toECBchrpW4I4pP2O+/gA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HfTQT5Q27XTsALi41YQ+Rq+jzHJlcLJDdnGPd8UbNfNa7dIESFLeMY6mkR3HtCj9P
         2YTAGU6IbersSOtscDlAFg9DxIYrxRQb2h1+VLiS4BaHor8JnEa/W9YmDvfixrKKyI
         5QpBDTs7qF8GZxspmEkgy2L+sMMReVXNaYqgXC08=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155343674152.28403.2449766826580543141.tglx@nanos.tec.linutronix.de>
References: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
 <155343674152.28403.2449766826580543141.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155343674152.28403.2449766826580543141.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: d8b5297f6d985d785b2d2869102933e81ca51c80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49ef015632ab3fcc19b2cb37b199d6d7ebcfa5f8
Message-Id: <155345281539.5356.9365071772749744282.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Mar 2019 18:40:15 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Mar 2019 14:12:21 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49ef015632ab3fcc19b2cb37b199d6d7ebcfa5f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
