Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AE7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8D9218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfCUQhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbfCUQhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:37:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5719218E2;
        Thu, 21 Mar 2019 16:37:16 +0000 (UTC)
Date:   Thu, 21 Mar 2019 12:37:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: Re: [PATCH] usb: gadget: functions: add ftrace export over USB
Message-ID: <20190321123715.027e9369@gandalf.local.home>
In-Reply-To: <87ftrg8t3j.fsf@linux.intel.com>
References: <20170609061327.17899-1-felipe.balbi@linux.intel.com>
        <87ftrg8t3j.fsf@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 11:38:56 +0200
Felipe Balbi <felipe.balbi@linux.intel.com> wrote:

> Hi,
> 
> Felipe Balbi <felipe.balbi@linux.intel.com> writes:
> > Allow for ftrace data to be exported over a USB Gadget
> > Controller. With this, we have a potentially very fast pipe for
> > transmitting ftrace data to a Host PC for further analysis.
> >
> > Note that in order to decode the data, one needs access to kernel
> > symbols in order to convert binary data into function names and what
> > not.
> >
> > Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> > ---
> >
> > I wanted to take this through the gadget tree, but there is a
> > dependency with a previous patch of mine adding and extra argument to
> > the ->write() function. Hoping someone else will take it.  
> 
> This is still not upstream, I'll take it through my tree this time around.
> 

Can you post the latest to the list one more time. At least to make
sure you got the naming correct ;-)

  Not FTrace or f_trace.

-- Steve
