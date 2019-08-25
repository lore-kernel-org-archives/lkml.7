Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124D8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC069206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566754823;
	bh=UBapg9IpdFQIpiyPPoLLETWF530pMVxY6svxOZNCzSk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0preN2DMRJtC4Y01soemsKEME6LfhPbUWsFnJlF0NZDB+8S7weXUnZJ0YNSPBcf8u
	 W/OOvKXtrvDT5tWg1GiL1zj5ioLC7ZeVa/W/B8Z2SMQ5xmzOh9V8HV1o4aGNbhkKFl
	 yooGXEFcEjIyUfgwgZ1NMGXdrwKjl51CucKR2k2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfHYRkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 13:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728623AbfHYRkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 13:40:07 -0400
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566754807;
        bh=UBapg9IpdFQIpiyPPoLLETWF530pMVxY6svxOZNCzSk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0jIpcm4RfVhTUNYOahriPNg17xCMRDogMRON+NMFByFDZW9CQIPDLUsEHf+lABezJ
         UXAaln7KdPIFaXlDFALA7X6quVxQI4SQqKdlmy+n/VWk8ojNhweaPOw10VKJLgozuY
         udxsVsJRRXCVnfQaSgWp/AvXBti1ef93VmZSua8A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156672618029.19810.9732807383797358917.tglx@nanos.tec.linutronix.de>
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
 <156672618029.19810.9732807383797358917.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156672618029.19810.9732807383797358917.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: b63f20a778c88b6a04458ed6ffc69da953d3a109
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 146c3d3220e039b5d61bf810e0b42218eb020f39
Message-Id: <156675480736.29384.10420527678817206875.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Aug 2019 17:40:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Aug 2019 09:43:00 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/146c3d3220e039b5d61bf810e0b42218eb020f39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
