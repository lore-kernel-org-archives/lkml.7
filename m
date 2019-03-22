Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEEAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519DD2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553282117;
	bh=2WZdRlqtV6MlHnQ1vcJVJSP2APmcp82USJZGryTmphc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yZkrCLj77wrDNSUIvtlZYndDMh+7pas94geC+gTlIMDgzwIBaKIM6/9BgPNAbV9SV
	 HsaFqetZXOZQ3FhpfK66DVCUH3QWuvC/6CPCu5JpfTlNXhjixQkTUwe75Y5Zo9T2dV
	 EQ3TxWVYcYgI9XoY3gLPXUM5p5A41zwhtOQWPqd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfCVTPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728153AbfCVTPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:15:12 -0400
Subject: Re: [GIT PULL] Device properties framework fix for v5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553282111;
        bh=2WZdRlqtV6MlHnQ1vcJVJSP2APmcp82USJZGryTmphc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=B0CrjLaBDoRK2a5cBQ8FuiYPpmDJFyvfIGF1CC6oWS50wcXmC5UDlX1WU6uvrlZqK
         VcS7Bhg71WZKa8f8EHhUseMz/uHAeizgkEBN+DCkIW9gBMU6pOcFjFG3ojHK/feXh4
         DsYzZ6Qzt7RtJf1J2JEtZGYzdHqyhhveaA7SPZMc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i5Jy9sAXLQX-Wap5qW6_sw+CW9JOx4t8E=hazK39_xHw@mail.gmail.com>
References: <CAJZ5v0i5Jy9sAXLQX-Wap5qW6_sw+CW9JOx4t8E=hazK39_xHw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i5Jy9sAXLQX-Wap5qW6_sw+CW9JOx4t8E=hazK39_xHw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 devprop-5.1-rc2
X-PR-Tracked-Commit-Id: 0e3edd94448001a33ed7f8af2179cd4a280348a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e42091739f649b3caf43ddffa53f0416dc396fdd
Message-Id: <155328211174.18163.7361689231132086507.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Mar 2019 19:15:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Mar 2019 11:28:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e42091739f649b3caf43ddffa53f0416dc396fdd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
