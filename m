Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA311C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826352171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfCLPAr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfCLPAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:00:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E198A2147C;
        Tue, 12 Mar 2019 15:00:45 +0000 (UTC)
Date:   Tue, 12 Mar 2019 11:00:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Valdis =?UTF-8?B?S2zEk3RuaWVrcw==?=" <valdis.kletnieks@vt.edu>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/trace/trace_probe.c - make variable static
Message-ID: <20190312110044.6fb0e52b@gandalf.local.home>
In-Reply-To: <2478.1552380778@turing-police>
References: <2478.1552380778@turing-police>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 04:52:58 -0400
"Valdis Klētnieks" <valdis.kletnieks@vt.edu> wrote:

> sparse complains:
>   CHECK   kernel/trace/trace_probe.c
> kernel/trace/trace_probe.c:16:12: warning: symbol 'reserved_field_names' was not declared. Should it be static?
> 
> Yes, it should be static.

Thanks, applied.

Note, I changed the subject to:

  tracing/probes: Make reserved_field_names static

To follow the naming convention of the tracing directory.

-- Steve


> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 89da34b326e3..cfcf77e6fb19 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -13,7 +13,7 @@
>  
>  #include "trace_probe.h"
>  
> -const char *reserved_field_names[] = {
> +static const char *reserved_field_names[] = {
>  	"common_type",
>  	"common_flags",
>  	"common_preempt_count",

