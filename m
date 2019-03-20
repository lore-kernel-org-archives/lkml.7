Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE38EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64462184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfCTOjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:39:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:35400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbfCTOjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:39:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D63CABD5;
        Wed, 20 Mar 2019 14:39:20 +0000 (UTC)
Date:   Wed, 20 Mar 2019 15:39:19 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: Remove no longer used console_silent().
Message-ID: <20190320143919.6n7az5yi5hbhipk4@pathway.suse.cz>
References: <1552917923-16601-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190318143421.GB29374@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318143421.GB29374@tigerII.localdomain>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-03-18 23:34:21, Sergey Senozhatsky wrote:
> On (03/18/19 23:05), Tetsuo Handa wrote:
> > console_silent() is no longer used after the removal of
> > arch/mn10300/kernel/mn10300-watchdog.c in Linux 4.17-rc1.
> 
> [..]
> 
> > -static inline void console_silent(void)
> > -{
> > -	console_loglevel = CONSOLE_LOGLEVEL_SILENT;
> > -}
> 
> I would keep it, I guess, and would instead covert
> 
> kernel/debug/kdb/kdb_io.c:              console_loglevel = CONSOLE_LOGLEVEL_SILENT
> 
> to use proper API (console_silent()).

I agree with Sergey.

Best Regards,
Petr
