Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF04BC606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1CC20644
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562614225;
	bh=w2CX27tgjvoQCdl30T5a6W3yByBnNF6NpH+7WBijvpk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=g6k0CqiczwmOYD2TWapY4bcPDEJ0A4TiUGSqSFq2fVRMON5MjObzbv11ELd7qj051
	 +I580l2hRov/uizJPba9qh1CX9YNVVvNoPFZjVEj3U0/Dl/4iDYbYnVzhDBLGUg5Oe
	 vg8U8g3AXl/l48VFaqWHA0Pw1VlasyA3D1Hev0gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404605AbfGHTaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404570AbfGHTaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:30:09 -0400
Subject: Re: [GIT pull] x86/apic for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562614208;
        bh=w2CX27tgjvoQCdl30T5a6W3yByBnNF6NpH+7WBijvpk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CDdJ7Omxoh4bfg0Df6otIXEKRxxES37rUZd0ujBOEptB7igrJjK+VZvn3zBl40fUX
         NoRD781E6k8mar1y8zeLZelUeKpaVxs5hjQ2wXjjo8jIbw4MokKevCep+Dt9eDwXjo
         ZD8fZODfqoAJxFAZAdDW8APsNI1exOtIKMKW+9X4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156257673796.14831.16250211652466679867.tglx@nanos.tec.linutronix.de>
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
 <156257673796.14831.16250211652466679867.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156257673796.14831.16250211652466679867.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus
X-PR-Tracked-Commit-Id: f8a8fe61fec8006575699559ead88b0b833d5cad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0902d5011cfaabd6a09326299ef77e1c8735fb89
Message-Id: <156261420874.31351.8378774860513805069.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jul 2019 19:30:08 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 08 Jul 2019 09:05:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0902d5011cfaabd6a09326299ef77e1c8735fb89

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
