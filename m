Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94ADC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF18215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578079512;
	bh=ZIIpnNOhGOfVukPaU+yrJEdFmIcL23yUaAuJ0HMcew0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=MEJmJ01UUwgiRHlWQMPuUDDsEHIy7AkU1cCPXyyM9qBqyrAQub8/l5DrxlJyfrf9A
	 cmM3o4NcBy9yrhQYXXRXrxUTiiz1AmjplWuhEMKmIOtpPPCkeQx4azJ64JDOBou4tJ
	 CjcxCP1legD2qhR3zgezSz3PUgvNpdnqiE0PuHHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgACTZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 14:25:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:44578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbgACTZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:25:08 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-5 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578079507;
        bh=ZIIpnNOhGOfVukPaU+yrJEdFmIcL23yUaAuJ0HMcew0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eFdGzdKs2QNTRrSuJVhbqQH4Us/7cMibqZpExnPTQlmnZM6h5uZPr2WoGluf3LJd3
         ClnbIAZ7iE+omc+N30ih/TY5lVO3+ludMYdq8iUxY6KrYOH+Cpvy/+uVRr/O5L1r8d
         YZ9dI0lVx7jEWYtZNaL2kB0jR6q3Bsgmt+RRSaWQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87k168lscw.fsf@mpe.ellerman.id.au>
References: <87k168lscw.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87k168lscw.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.5-5
X-PR-Tracked-Commit-Id: 6da3eced8c5f3b03340b0c395bacd552c4d52411
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f2e9c3d28167b0f27d4be68e9101a9ecf397878
Message-Id: <157807950746.16643.17923227568508514575.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jan 2020 19:25:07 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, Jason@zx2c4.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 03 Jan 2020 21:57:51 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.5-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f2e9c3d28167b0f27d4be68e9101a9ecf397878

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
