Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA11C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 23:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712C320693
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 23:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfINXuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 19:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfINXuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 19:50:50 -0400
Received: from oasis.local.home (unknown [12.156.218.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E5F120693;
        Sat, 14 Sep 2019 23:50:49 +0000 (UTC)
Date:   Sat, 14 Sep 2019 19:50:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2] tracing: Be more clever when dumping hex in
 __print_hex()
Message-ID: <20190914195048.670b645a@oasis.local.home>
In-Reply-To: <20190913122826.GP2680@smile.fi.intel.com>
References: <20190806151543.86061-1-andriy.shevchenko@linux.intel.com>
        <20190806113352.334d81b9@gandalf.local.home>
        <20190913122826.GP2680@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2019 15:28:26 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Aug 06, 2019 at 11:33:52AM -0400, Steven Rostedt wrote:
> > On Tue,  6 Aug 2019 18:15:43 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > Hex dump as many as 16 bytes at once in trace_print_hex_seq()
> > > instead of byte-by-byte approach.  
> 
> > > +	const char *fmt = concatenate ? "%*phN" : "%*ph";
> > >  
> > > +	for (i = 0; i < buf_len; i += 16)
> > > +		trace_seq_printf(p, fmt, min(buf_len - i, 16), &buf[i]);  
> > 
> > Cute.
> > 
> > I'll have to wrap my head around it a bit to make sure it's correct.  
> 
> Anything I need to update here?
> 

Nope, thanks for the ping, I've been traveling quite crazy lately. I'll
try to add this to the next merge window coming up shortly.

-- Steve
