Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE02AC76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 04:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C170A22BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 04:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfGZEtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 00:49:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfGZEtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 00:49:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 917AD3091761;
        Fri, 26 Jul 2019 04:49:12 +0000 (UTC)
Received: from treble (ovpn-120-166.rdu2.redhat.com [10.10.120.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7743C1001938;
        Fri, 26 Jul 2019 04:49:11 +0000 (UTC)
Date:   Thu, 25 Jul 2019 23:49:09 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the tip tree
Message-ID: <20190726044909.ubf4rhzmsgjd3xgk@treble>
References: <20190726130327.1f707cb3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190726130327.1f707cb3@canb.auug.org.au>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 26 Jul 2019 04:49:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 01:05:49PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
> 
> drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x1c: redundant UACCESS disable
> 
> Presuambly introduced/uncovered by commit
> 
>   882a0db9d143 ("objtool: Improve UACCESS coverage")

This will be fixed by:

  https://lkml.kernel.org/r/51a4155c5bc2ca847a9cbe85c1c11918bb193141.1564086017.git.jpoimboe@redhat.com

-- 
Josh
