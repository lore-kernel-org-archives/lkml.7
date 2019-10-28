Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC6FCA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971E9208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572274433;
	bh=Qfg8BT4ZtmHuxe41W6DiJHavA4zpxHfzooisC4Hp12E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fYeDOsrkj+oMC4vJ6Baa9sTi/B+DBLO6wWqNufbdxGxR4fs10x7LzKgVN/GDxmqui
	 I87rJtq2O7DXGYL/Q1l+kNXRVVar/LSCNjcNMyHdtmqTaCKqnQocQ9Ore3YBnpxs9i
	 YGS3FpMqKVangs0bO6Hk+Cih22NIu3qe58+QRc+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390378AbfJ1Oxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbfJ1Oxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:53:52 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38293208C0;
        Mon, 28 Oct 2019 14:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572274431;
        bh=Qfg8BT4ZtmHuxe41W6DiJHavA4zpxHfzooisC4Hp12E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zkvko9wWADl+2U9ZfduDj/L6WsRbQTomQU5U+aDPsWqjNqSeB2tlEfKPk2bL1DI6U
         6OYp/kF0xFdtfWfwcrxIfFy3dUwG+G7ia+GcP+QjQ4TxYQ7CAzJno3HFCbeKbDDFVg
         0FMRaDVwMzLge+OEBpAITPNHE+ihWyhr5ZdSnkx4=
Date:   Mon, 28 Oct 2019 23:53:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH V2 0/6] perf/probe: Additional fixes for range
 only functions
Message-Id: <20191028235347.8167bb3b56eeb86be3d93606@kernel.org>
In-Reply-To: <20191028141655.GA4943@kernel.org>
References: <157208041894.16551.2733647209130045685.stgit@devnote2>
        <20191028141655.GA4943@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019 11:16:55 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Sat, Oct 26, 2019 at 06:00:19PM +0900, Masami Hiramatsu escreveu:
> > Hi Arnaldo,
> > 
> > I've updated examples in patch description in this v2.
> > No changes in the code itself. I ran it on Ubuntu 19.04
> > (linux-5.0.0-32-generic).
> > 
> > Please replace previous one with this.
> 
> Can you please take a look at my perf/core branch? I have these already
> there:
> 
> 5e72f4349eff perf probe: Fix to show ranges of variables in functions without entry_pc
> 50fc0fda5f2c perf probe: Fix to show inlined function callsite without entry_pc
> d7bf48229b85 perf probe: Fix to list probe event with correct line number
> 39cee497850a perf probe: Fix to probe an inline function which has no entry pc
> 6150bad27ebd perf probe: Fix to probe a function which has no entry pc
> fdaea9eea92d perf probe: Fix wrong address verification
> 
> And I added committer notes doing the tests.

Yes, I confirmed your comments on the patches. It looks good to me.

Thank you!

> 
> - Arnaldo
>  
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (6):
> >       perf/probe: Fix wrong address verification
> >       perf/probe: Fix to probe a function which has no entry pc
> >       perf/probe: Fix to probe an inline function which has no entry pc
> >       perf/probe: Fix to list probe event with correct line number
> >       perf/probe: Fix to show inlined function callsite without entry_pc
> >       perf/probe: Fix to show ranges of variables in functions without entry_pc
> > 
> > 
> >  tools/perf/util/dwarf-aux.c    |    6 +++---
> >  tools/perf/util/probe-finder.c |   40 ++++++++++++++--------------------------
> >  2 files changed, 17 insertions(+), 29 deletions(-)
> > 
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
