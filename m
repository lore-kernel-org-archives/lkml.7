Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C57C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26242726A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559583313;
	bh=2oHZAAcEVet9Dl0q7cdZbLhcN/D87+W9xMIk8orH9mg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=z2beNTN8sG8Q/RMvhPrwW1QYjEgYUdv1xubNgGXU1B1H5A9QgSomEEFOkkS1gcy+p
	 v7DR52l6HmHlujXt8eLFAuriuynvbAIsc5TdXzgwmi97vb1J1QkWbvoREApjPPMiIV
	 nWeE+L19g40lXEFt3+hhkahDKVBXRWRtpPPTnNA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfFCRfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfFCRfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:35:12 -0400
Subject: Re: [GIT] Sparc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559583311;
        bh=2oHZAAcEVet9Dl0q7cdZbLhcN/D87+W9xMIk8orH9mg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y70UlKa9SAY3J2mIfUOb8oZOd1VjX+T1xhFUOdne+cNUJszG6siEQElRVgx8Tljm+
         ZG6TyXgotuhqd2tFqK8reB0227uCZdrKWoZEHuMSkqSmrECS7WSNtF6uTdhR9aQofz
         cs3TTLLQOJ4l5q18k/vYKiCqCpeu6ajWSCoRSRL4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190602.222107.923223011133534329.davem@davemloft.net>
References: <20190602.222107.923223011133534329.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190602.222107.923223011133534329.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 56cd0aefa475079e9613085b14a0f05037518fed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01e7a841b4346836f19b40677e1fef4657cc0d0d
Message-Id: <155958331179.6762.4502817821711131059.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Jun 2019 17:35:11 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 02 Jun 2019 22:21:07 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01e7a841b4346836f19b40677e1fef4657cc0d0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
