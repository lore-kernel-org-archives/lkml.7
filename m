Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE272C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB04620896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfFLIP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:15:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:43438 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726406AbfFLIP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:15:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C91FAF21;
        Wed, 12 Jun 2019 08:15:27 +0000 (UTC)
Date:   Wed, 12 Jun 2019 10:15:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, joe.lawrence@redhat.com,
        kamalesh@linux.vnet.ibm.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] Revert "livepatch: Remove reliable stacktrace
 check in klp_try_switch_task()"
Message-ID: <20190612081526.3d443z3lpw45vuhs@pathway.suse.cz>
References: <20190611141320.25359-1-mbenes@suse.cz>
 <20190611141320.25359-3-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611141320.25359-3-mbenes@suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-06-11 16:13:19, Miroslav Benes wrote:
> This reverts commit 1d98a69e5cef3aeb68bcefab0e67e342d6bb4dad. Commit
> 31adf2308f33 ("livepatch: Convert error about unsupported reliable
> stacktrace into a warning") weakened the enforcement for architectures
> to have reliable stack traces support. The system only warns now about
> it.
> 
> It only makes sense to reintroduce the compile time checking in
> klp_try_switch_task() again and bail out early.
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
