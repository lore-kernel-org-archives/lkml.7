Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C781C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF4A2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKLHB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:01:27 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:47148 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725811AbfKLHB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:01:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0ThsYfQa_1573542084;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0ThsYfQa_1573542084)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Nov 2019 15:01:24 +0800
Date:   Tue, 12 Nov 2019 15:01:23 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, sanagi.koki@jp.fujitsu.co, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] net: add missing semicolon in net_dev_template
Message-ID: <20191112070123.GA67139@TonyMac-Alibaba>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20191111141752.31655-1-tonylu@linux.alibaba.com>
 <20191111181228.49396467@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111181228.49396467@gandalf.local.home>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 06:12:28PM -0500, Steven Rostedt wrote:
> On Mon, 11 Nov 2019 22:17:53 +0800
> Tony Lu <tonylu@linux.alibaba.com> wrote:
> 
> > This patch adds missing semicolon in the end of net_dev_template.
> > 
> > Fixes: cf66ba58b5cb ("netdev: Add tracepoints to netdev layer")
> > Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
> > ---
> >  include/trace/events/net.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/trace/events/net.h b/include/trace/events/net.h
> > index 2399073c3afc..3b28843652d2 100644
> > --- a/include/trace/events/net.h
> > +++ b/include/trace/events/net.h
> > @@ -138,7 +138,7 @@ DECLARE_EVENT_CLASS(net_dev_template,
> >  
> >  	TP_printk("dev=%s skbaddr=%p len=%u",
> >  		__get_str(name), __entry->skbaddr, __entry->len)
> > -)
> > +);
> 
> Actually, we are thinking of making a sweeping patch set to remove all
> these semicolons, as they are not needed, and would also allow more
> flexible processing of the trace event macros.
> 
> -- Steve

Thanks for your reply, it's great to take actions to sweep them for a
unified code style. I just found a different place in the code :-)

Cheers
Tony Lu

> 
> >  
> >  DEFINE_EVENT(net_dev_template, net_dev_queue,
> >  
