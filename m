Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EFDC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 21:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCFE20700
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 21:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570916410;
	bh=3oP6+/0+rNNfPfZP75AUY0sO+HAX3rC8+O4Z4holfXE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zgtqGuB8LKOg4V9GGfpKX877WtA+w+WJlm64In6KWdzBeSCfmsuKkyWZMsPQPo7ms
	 k6FB8SGtJ1fSRqpieRgZPnZoGFqRvOSfKfAVsGa5Ox+ctytXGlV80nlK7UJ1VhZNX4
	 vHmr/0CFEWJ5Wy6D8YobZ3Asq4IonBk6WBjOqQj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfJLVkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 17:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729671AbfJLVkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 17:40:06 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.4-3 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570916406;
        bh=3oP6+/0+rNNfPfZP75AUY0sO+HAX3rC8+O4Z4holfXE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VCpt0shdQFi1XqIhY9MAiIUahUjKTlvbZ+04d6YjqlQw5omJrxYivUUZIMru4s2Ek
         fgvjOWdc6JdMDMOsJwQeY2do6tJGoZzj8jWG7gsHU8SsT41fJx1Y8PQj4YHfEJfeGZ
         9M6KgEcrQ/GzLkF81EMjkpSa8D3vhj+uEgUnpXgw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87r23iurdg.fsf@mpe.ellerman.id.au>
References: <87r23iurdg.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87r23iurdg.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.4-3
X-PR-Tracked-Commit-Id: 2272905a4580f26630f7d652cc33935b59f96d4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db60a5a035aa8692dc7cee293356bdcc078fa7b7
Message-Id: <157091640632.3377.10259916414495442367.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 21:40:06 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, arnd@arndb.de,
        desnesn@linux.ibm.com, emmanuel.nicolet@gmail.com,
        jniethe5@gmail.com, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sfr@canb.auug.org.au
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 22:37:15 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db60a5a035aa8692dc7cee293356bdcc078fa7b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
