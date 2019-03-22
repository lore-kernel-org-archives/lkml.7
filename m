Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A534C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D172196E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391084AbfCVMW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391072AbfCVMWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:22:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22A5F218A1;
        Fri, 22 Mar 2019 12:22:54 +0000 (UTC)
Date:   Fri, 22 Mar 2019 08:22:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: Re: [PATCH] usb: gadget: functions: add ftrace export over USB
Message-ID: <20190322082252.2d239fbc@gandalf.local.home>
In-Reply-To: <87va0bdt7g.fsf@linux.intel.com>
References: <20170609061327.17899-1-felipe.balbi@linux.intel.com>
        <87ftrg8t3j.fsf@linux.intel.com>
        <20190321123715.027e9369@gandalf.local.home>
        <87va0bdt7g.fsf@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019 13:49:55 +0200
Felipe Balbi <felipe.balbi@linux.intel.com> wrote:

> > Can you post the latest to the list one more time. At least to make
> > sure you got the naming correct ;-)
> >
> >   Not FTrace or f_trace.  
> 
> The reason for the name was discussed already. See [1] and [2]
> 
> [1] https://marc.info/?i=878tl1qmrj.fsf@linux.intel.com
> [2] https://marc.info/?i=20170609110717.3304f6b9@gandalf.local.home

Ah, I forgot (was two years ago) But not doing FTrace still stands!

-- Steve
