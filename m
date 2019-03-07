Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F636C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B68120851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551994821;
	bh=aEF3dHxfSC+O8uFI32t0KQ8wXiO/kmMvW6eKVZyNwrU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aS5Wz4ZeMlRr4UUpx8UqLM/+huYnfOdhXA46jqlz/ERHV7En0LegISfaMnJcPfBNd
	 8A0qDNZFaGQcZEVikh6IVFCmrsftiwKyZNhK/Mf7zk+helUacHl4ifXvYSQYzOVetA
	 gSTCuIuJcyNqz8rKi3dJ1PzfM1ACxfG9ulL1s6Os=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfCGVkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:40:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:47582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfCGVkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:40:16 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.1-1 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551994815;
        bh=aEF3dHxfSC+O8uFI32t0KQ8wXiO/kmMvW6eKVZyNwrU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XL61FXCOUQZO4h2aOX2Vfp8VSsAbM/vfKQVqZFJsW4446KSjKU6kdUxoG0gCeo3C5
         ROEKVGQGMUUsDhQ7iDQTIJn3XX0qoVD6+I8WU1BpT1mD2SiBZwc/X8dsRN1Sn2QvUr
         QGHbjPjBot+yUSZJIijGMLAhN7vZe54rpQ4jHiH8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87a7i6x1yk.fsf@concordia.ellerman.id.au>
References: <87a7i6x1yk.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87a7i6x1yk.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.1-1
X-PR-Tracked-Commit-Id: 9580b71b5a7863c24a9bd18bcd2ad759b86b1eff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c3ac1134371b51c9601171af2c32153ccb11100
Message-Id: <155199481542.1630.7251693793029046147.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 21:40:15 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, aik@ozlabs.ru,
        andrew.donnellan@au1.ibm.com, aneesh.kumar@linux.ibm.com,
        arbab@linux.ibm.com, benh@kernel.crashing.org,
        brajeswar.linux@gmail.com, cai@lca.pw, christophe.leroy@c-s.fr,
        chunkeey@gmail.com, clabbe@baylibre.com,
        clombard@linux.vnet.ibm.com, dvyukov@google.com,
        fbarrat@linux.ibm.com, firoz.khan@linaro.org, geoff@infradead.org,
        gustavo@embeddedor.com, hch@lst.de, igor.stoppa@gmail.com,
        j.neuschaefer@gmx.net, jniethe5@gmail.com, joe.lawrence@redhat.com,
        joel@jms.id.au, jrdr.linux@gmail.com, leitao@debian.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, malat@debian.org,
        mark.cave-ayland@ilande.co.uk, mark.rutland@arm.com,
        mcroce@redhat.com, natechancellor@gmail.com,
        nfont@linux.vnet.ibm.com, npiggin@gmail.com, nstange@suse.de,
        oohall@gmail.com, paulus@ozlabs.org, peterx@redhat.com,
        prasannatsmkumar@gmail.com, rashmica.g@gmail.com,
        rpjday@crashcourse.ca, rppt@linux.ibm.com,
        sabyasachi.linux@gmail.com, sandipan@linux.ibm.com,
        sbobroff@linux.ibm.com, sergey.senozhatsky.work@gmail.com,
        tglx@linutronix.de, tyreld@linux.vnet.ibm.com,
        vaibhav@linux.ibm.com, yamada.masahiro@socionext.com,
        yuehaibing@huawei.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 08 Mar 2019 00:12:51 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c3ac1134371b51c9601171af2c32153ccb11100

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
