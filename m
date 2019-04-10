Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380CCC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141132133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbfDJSYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727583AbfDJSYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:24:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDC2C2077C;
        Wed, 10 Apr 2019 18:24:49 +0000 (UTC)
Date:   Wed, 10 Apr 2019 14:24:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Android Kernel Team <kernel-team@android.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH 1/2] module: Prepare for addition of new ro_after_init
 sections
Message-ID: <20190410142447.7983119a@gandalf.local.home>
In-Reply-To: <CAGXu5jKEek9H0uWyB346mE3MBhhNVGo7qyy=y0qAZFauxQ3iEw@mail.gmail.com>
References: <20190410011418.76408-1-joel@joelfernandes.org>
        <CAGXu5jKs6Ag2L+GYEVYAzPky1pLntZt-Tc5ki-pqjVoyCWgxxg@mail.gmail.com>
        <20190410174800.GA259061@google.com>
        <CAGXu5jKEek9H0uWyB346mE3MBhhNVGo7qyy=y0qAZFauxQ3iEw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 11:21:23 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Wed, Apr 10, 2019 at 10:48 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > Thanks, if you are Ok with it, I will add your Reviewed-by tag as well.  
> 
> With those fixes, absolutely. :) Thanks!
> 

I'll wait for v2 before adding my reviewed-by. ;-)

-- Steve
