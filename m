Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA0FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8BB2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561702612;
	bh=3PH/xddyhHQdlUHI/us8KOgju1FY4VqQ2RrO6hNEAa4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IseIF2pEevihzuDf2eOn7f1HF4O7Y0/CRvYHmG1p4Bno5rvbddc/fMGAFQ5GmQndn
	 0nT2sCLnCa7W+7Yo5FlbpgqIff3GnQoXn+6LNvVrez9TalVxkyWsduCwIpAbCo2F5D
	 SEiZq430w+fTjj1HyqmgRQ3kaO3EfnaFs14GysjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfF1GQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfF1GQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:16:50 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 352CF2070D;
        Fri, 28 Jun 2019 06:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561702609;
        bh=3PH/xddyhHQdlUHI/us8KOgju1FY4VqQ2RrO6hNEAa4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ib43HFtE1oVA5431sbGlIkLE87dWAocSTOXSRP761Nq/wq4CeFDSYN/tLWZsITG2m
         bsR7xGkiqaDIlfNh/AxEnEDB8sRDiLWuAfW42mjTVtXbFh0AvFNkjm4ZHoCB3bC5YE
         njPlulygCehFfQhbIpYgEz8YfiO6nHUCKgxGZkMk=
Date:   Fri, 28 Jun 2019 15:16:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] tracing: Improve error messages for histogram
 sorting
Message-Id: <20190628151645.a81b327d8e0d7c68d521b24e@kernel.org>
In-Reply-To: <cover.1561647046.git.zanussi@kernel.org>
References: <cover.1561647046.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 10:35:15 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi,
> 
> These patches add some improvements for histogram sorting, addressing
> some shortcomings pointed out by Masami.
> 
> In order to address the specific problem pointed out by Masami, as
> well as add additional related error messages, the first patch
> does some simplification of assignment parsing.
> 
> The second patch actually adds the new error messages.
> 
> The fourth patch adds a new testcase for hist trigger parsing, similar
> to the same kind of tests for kprobes and uprobes.  Additional tests
> covering all possible hist trigger errors should/will be added here in
> the future.
> 
> The third patch just adds a missing hist: prefix to the error log so
> that the testcases work properly, and which should have been there
> anyway.
> 
> Thanks,


Hi Tom,

These patches look good to me :)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

for all patches. BTW, if you think there is a bug and the 1st one fixes it,
please add Fixes: tag.

Thank you,
> 
> Tom
> 
> The following changes since commit a124692b698b00026a58d89831ceda2331b2e1d0:
> 
>   ftrace: Enable trampoline when rec count returns back to one (2019-05-25 23:04:43 -0400)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace-hist-sort-err-msgs-v1
> 
> Tom Zanussi (4):
>   tracing: Simplify assignment parsing for hist triggers
>   tracing: Add hist trigger error messages for sort specification
>   tracing: Add 'hist:' to hist trigger error log error string
>   tracing: Add new testcases for hist trigger parsing errors
> 
>  kernel/trace/trace_events_hist.c                   | 94 +++++++++++-----------
>  .../test.d/trigger/trigger-hist-syntax-errors.tc   | 32 ++++++++
>  2 files changed, 78 insertions(+), 48 deletions(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc
> 
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
