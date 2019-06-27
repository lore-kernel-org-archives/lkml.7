Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554AEC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337FB2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfF0W3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbfF0W3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:29:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D364C2063F;
        Thu, 27 Jun 2019 22:29:39 +0000 (UTC)
Date:   Thu, 27 Jun 2019 18:29:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Jiunn Chang <c0d1n61at3@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees][PATCH] doc: RCU callback locks need only
 _bh, not necessarily _irq
Message-ID: <20190627182938.306ab9d9@gandalf.local.home>
In-Reply-To: <20190627221045.GH26519@linux.ibm.com>
References: <20190627210147.19510-1-c0d1n61at3@gmail.com>
        <bc2ce605-56ab-33aa-c94d-d7774e6ce8cd@linuxfoundation.org>
        <20190627221045.GH26519@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 15:10:45 -0700
"Paul E. McKenney" <paulmck@linux.ibm.com> wrote:

> On Thu, Jun 27, 2019 at 04:01:35PM -0600, Shuah Khan wrote:
> > On 6/27/19 3:01 PM, Jiunn Chang wrote:  
> > >The UP.rst file calls for locks acquired within RCU callback functions
> > >to use _irq variants (spin_lock_irqsave() or similar), which does work,
> > >but can be overkill.  This commit therefore instead calls for _bh variants
> > >(spin_lock_bh() or similar), while noting that _irq does work.
> > >
> > >Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>  
> > 
> > Should this by Suggested-by?  
> 
> I wrote it and Jiunn converted my change to .rst, so I believe that
> this is correct as is.

Note, you did send Jiunn an explicit Signed-off-by when you wrote it,
correct? As Signed-off-by is equivalent to a signature.

-- Steve
