Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77FAC072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69AF2081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfE1KkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:40:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:40240 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbfE1KkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:40:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06D2BAF2B;
        Tue, 28 May 2019 10:40:18 +0000 (UTC)
Date:   Tue, 28 May 2019 12:40:18 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] [RFC] Remove bdflush syscall stub
Message-ID: <20190528104017.GA11969@rei>
References: <20190528101012.11402-1-chrubis@suse.cz>
 <mvmr28idgfu.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvmr28idgfu.fsf@linux-m68k.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > I've tested the patch on i386. Before the patch calling bdflush() with
> > attempt to tune a variable returned 0 and after the patch the syscall
> > fails with EINVAL.
> 
> Should be ENOSYS, doesn't it?

My bad, the LTP syscall wrapper handles ENOSYS and produces skipped
results based on that.

EINVAL is what you get for not yet implemented syscalls, i.e. new
syscall on old kernel.

-- 
Cyril Hrubis
chrubis@suse.cz
