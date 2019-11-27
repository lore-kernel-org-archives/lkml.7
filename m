Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D78C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B7A20866
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574818214;
	bh=wnIhLn9O2NKDdVCLtrutx7mSOPJrp/maVJMQpfjq6rQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GHyaLzt1BsZXxT7Pu7JUvyIp+h42DIKsGZWcXMuLRFfO2QnZQrUA8pRDZ6mbKZ0Yf
	 5NKPCDOlfO24Cv9C97mNbRu+fdmLoHzC5gzn7D+H4Ldna0nzACA9bEE6Wf4ZyVPgp4
	 MjmjeFEPKeG9QLgji81/awT5jxefaPYp41Ma86H0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfK0BaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:30:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfK0BaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:30:12 -0500
Subject: Re: [GIT PULL] EFI updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574818211;
        bh=wnIhLn9O2NKDdVCLtrutx7mSOPJrp/maVJMQpfjq6rQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OeR5W6ZaKPo+khE5zRYIJ2EgkyIqjNlHKEoxbk4N/ZZH3At9+aCB+JdijykfPmyd/
         Hd1hYWW8K7J4QciekYTeuzYgpocIerp2iy/ztKljeJsY8D9kef9w6cJ/HjhTYZ2q3m
         4Z8uW1EtOVlOiKSkKqzCekvMYaaqT/dmbfMXtVbE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125110415.GA37886@gmail.com>
References: <20191125110415.GA37886@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125110415.GA37886@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus
X-PR-Tracked-Commit-Id: 2278f452a12d5b5b01f96441a7a4336710365022
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df28204bb0f29cc475c0a8893c99b46a11a4903f
Message-Id: <157481821181.26353.8841723438521281530.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 01:30:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        linux-efi@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        James Morse <james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 12:04:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df28204bb0f29cc475c0a8893c99b46a11a4903f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
