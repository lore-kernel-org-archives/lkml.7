Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0636C32750
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5D021926
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564990629;
	bh=nf7pnL6Faketx2jqiRVlMYXPqEJT8NsVWhj2hShnVhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=p/+UkeOJiPs1rJBnwgT9uoz1aqxXQ0IYI25KVkUB21DtM7xfAGEObiIX9r1xXawgQ
	 2s6n8oaJNAlLOhzGb5VT9V8nYvUvCixZUmD34SasOZ3zcypjOPeHMiIzjQCdBtpxZJ
	 SkXVm0Y1cC+87o++SuozD7Xrakg3Jm7tVVKny3OQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfHEHhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbfHEHhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:37:07 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB5F121923;
        Mon,  5 Aug 2019 07:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564990627;
        bh=nf7pnL6Faketx2jqiRVlMYXPqEJT8NsVWhj2hShnVhw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m8UhBy5zhGfyxa0PsvQ9uYdR99xMQHUTxKeSkL/qFmgoH8nBXaGoG8GkqICF1x/9v
         LHYHrOx6jxJ9TygZaEzMqLNvqGfmagptqQcbb+t4yBICoUoIP05UFmW1neQ32Vydfz
         YzL97adKG+c9x4KbfrBJ9ZVW/5Y/LsFUvmgzY318=
Date:   Mon, 5 Aug 2019 16:37:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Will Deacon <will@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the arm64-fixes tree
Message-Id: <20190805163703.da632d5800c15a96ee79bf9d@kernel.org>
In-Reply-To: <20190803101533.GA58477@iMac.local>
References: <20190802074813.73b82a14@canb.auug.org.au>
        <20190803094212.3ff4b1ba33c50c63173c8d31@kernel.org>
        <20190803101533.GA58477@iMac.local>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Aug 2019 11:15:34 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Sat, Aug 03, 2019 at 09:42:12AM +0900, Masami Hiramatsu wrote:
> > On Fri, 2 Aug 2019 07:48:13 +1000
> > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > In commit
> > > 
> > >   72de4a283cb1 ("arm64: kprobes: Recover pstate.D in single-step exception handler")
> > > 
> > > Fixes tag
> > > 
> > >   Fixes: commit 7419333fa15e ("arm64: kprobe: Always clear pstate.D in breakpoint exception handler")
> > > 
> > > has these problem(s):
> > > 
> > >   - leading word 'commit' unexpected
> > 
> > Oops, sorry. It was my mistake to add "commit", it should be removed.
> > Will, should I remove it? or could you modify on your tree?
> 
> No need to. Will fixed it already.

Thank you Will and Catalin!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
