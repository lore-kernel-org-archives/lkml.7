Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F9CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2B120651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfEBVNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfEBVM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:12:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C85F320651;
        Thu,  2 May 2019 21:12:57 +0000 (UTC)
Date:   Thu, 2 May 2019 17:12:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 4/4] ftrace: Add an option for tracing console
 latencies
Message-ID: <20190502171256.0ecd0f20@gandalf.local.home>
In-Reply-To: <20190502183731.9571-1-viktor.rosendahl@gmail.com>
References: <20190501213857.157e3741@oasis.local.home>
        <20190502183731.9571-1-viktor.rosendahl@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 May 2019 20:37:31 +0200
Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:

> > Instead of this being turned into a nop, don't have a kconfig option
> > but instead have this call into the trace_irqsoff.c code, and depending
> > on what the options are, it should stop it. Of course, this would need
> > to be smart enough to pair it. Perhaps return the result of
> > console_stop_critical_timings() and have that passed to
> > console_start_critical_timings(), and only have start do something if
> > stop did something. This way the option only needs to disable the stop
> > part.  
> 
> Something like this?
> 
> I have only compile tested it so far.
> 

Yeah, something like that.

-- Steve
