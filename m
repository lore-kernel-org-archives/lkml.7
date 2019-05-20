Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F18C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5295320863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391909AbfETPXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:23:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388127AbfETPXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:23:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48FF42054F;
        Mon, 20 May 2019 15:23:06 +0000 (UTC)
Date:   Mon, 20 May 2019 11:23:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
Subject: Re: [PATCH] tracing: Kernel access to Ftrace instances
Message-ID: <20190520112304.62db2c8c@gandalf.local.home>
In-Reply-To: <F331FDC8-9E63-4042-A933-BDC197C9A031@goodmis.org>
References: <1553106531-3281-1-git-send-email-divya.indi@oracle.com>
        <1553106531-3281-2-git-send-email-divya.indi@oracle.com>
        <20190516090942.75f3a957ceed20201edc91a6@kernel.org>
        <a96e884d-534f-65ef-8f82-85cd52953695@oracle.com>
        <20190516120529.4c1f6e6ddd516185df149625@kernel.org>
        <F331FDC8-9E63-4042-A933-BDC197C9A031@goodmis.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019 20:24:43 -0700
Steven Rostedt <rostedt@goodmis.org> wrote:
>
> >It seems your's already in Steve's ftrace/core branch, so I think you
> >can make
> >additional patch to fix it. Steve, is that OK?
> >  
> 
> Yes. In fact I already sent a pull request to Linus.  Please send a patch on top of my ftrace/core branch.
> 

And now it is in mainline (v5.2-rc1). Please send a patch with a sample
module (as Masami requested). Also, that function not only needs to be
changed to not being static, you need to add it to a header
(include/linux/trace_events.h?)

Thanks!

-- Steve
