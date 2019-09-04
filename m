Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5564C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845D720449
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfIDKTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbfIDKTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:19:15 -0400
Received: from oasis.local.home (bl11-233-114.dsl.telepac.pt [85.244.233.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F07D920449;
        Wed,  4 Sep 2019 10:19:12 +0000 (UTC)
Date:   Wed, 4 Sep 2019 06:19:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Divya Indi <divya.indi@oracle.com>
Subject: Re: [PATCH v1] tracing: Drop static keyword for exported
 ftrace_set_clr_event()
Message-ID: <20190904061910.4f9462d3@oasis.local.home>
In-Reply-To: <20190902093406.GS2680@smile.fi.intel.com>
References: <20190830193228.65446-1-andriy.shevchenko@linux.intel.com>
        <20190830170424.40c4188a@gandalf.local.home>
        <20190902093406.GS2680@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Sep 2019 12:34:06 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Aug 30, 2019 at 05:04:24PM -0400, Steven Rostedt wrote:
> > On Fri, 30 Aug 2019 22:32:28 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > When we export something, it shan't be static.  
> > 
> > I'm finally getting around to my patch queue (it's unfortunately much
> > bigger than I should be). But my punishment is duplicate patches.
> > 
> > Someone beat you to it...
> > 
> >  http://lkml.kernel.org/r/20190704172110.27041-1-efremov@linux.com  
> 
> Looking to the original patch and taking into account that there is no user for
> it, I guess the best option to simple revert original one (it will clean up
> export table).
> 

Except there will be.

 http://lkml.kernel.org/r/1565805327-579-1-git-send-email-divya.indi@oracle.com


-- Steve
