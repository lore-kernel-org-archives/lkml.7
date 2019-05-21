Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A396C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6C8217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfEUM4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEUM4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:56:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D23AB21773;
        Tue, 21 May 2019 12:56:28 +0000 (UTC)
Date:   Tue, 21 May 2019 08:56:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, srinivas.eeda@oracle.com
Subject: Re: [PATCH v2] doc: kernel-parameters.txt: fix documentation of
 nmi_watchdog parameter
Message-ID: <20190521085627.0b36cd80@gandalf.local.home>
In-Reply-To: <064f1230-be51-37ef-9283-69a7277fdd67@oracle.com>
References: <1557632127-16717-1-git-send-email-zhenzhong.duan@oracle.com>
        <20190514152113.336e6116@oasis.local.home>
        <064f1230-be51-37ef-9283-69a7277fdd67@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 17:42:28 +0800
Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:

> On 2019/5/15 3:21, Steven Rostedt wrote:
> > On Sun, 12 May 2019 11:35:27 +0800
> > Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:
> >  
> >> The default behavior of hardlockup depends on the config of
> >> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC.
> >>
> >> Fix the description of nmi_watchdog to make it clear.
> >>
> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> >> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >> Cc: Steven Rostedt <rostedt@goodmis.org>  
> > Perhaps it should have been:
> >
> >   Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >
> > As the wording is what I suggested ;-)  
> 
> Sure, I should have done that. Just not familiar with which one is better.
> 
> Not clear if I should send a v3 adding Suggested-by and Acked-by?

Yep, it's fine to add both:

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Zhenzhong

