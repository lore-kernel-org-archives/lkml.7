Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAFDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C722147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfCLPBx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfCLPBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:01:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68E592075C;
        Tue, 12 Mar 2019 15:01:52 +0000 (UTC)
Date:   Tue, 12 Mar 2019 11:01:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Valdis =?UTF-8?B?S2zEk3RuaWVrcw==?=" <valdis.kletnieks@vt.edu>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/trace/trace_kprobe.c - fix comment format
Message-ID: <20190312110151.00e0df4d@gandalf.local.home>
In-Reply-To: <2812.1552381112@turing-police>
References: <2812.1552381112@turing-police>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 04:58:32 -0400
"Valdis Klētnieks" <valdis.kletnieks@vt.edu> wrote:

>   CC      kernel/trace/trace_kprobe.o
> kernel/trace/trace_kprobe.c:41: warning: cannot understand function prototype: 'struct trace_kprobe '
> 
> The real problem is that a comment looked like kerneldoc when it shouldn't be...
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 9eaf07f99212..c825c591553a 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -35,7 +35,7 @@ static struct dyn_event_operations trace_kprobe_ops = {
>  	.match = trace_kprobe_match,
>  };
>  
> -/**
> +/*

NACK.

This isn't a kernel doc comment, and I don't want to make it one when
it is not. Just ignore that warning.

-- Steve


>   * Kprobe event core functions
>   */
>  struct trace_kprobe {

