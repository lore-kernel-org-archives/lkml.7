Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D79CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D40217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfDJCsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726577AbfDJCsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:48:30 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 823A520857;
        Wed, 10 Apr 2019 02:48:28 +0000 (UTC)
Date:   Tue, 9 Apr 2019 22:48:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org
Subject: Re: [PATCH 2/2] module: Make srcu_struct ptr array as read-only
 post init
Message-ID: <20190409224826.308b12a4@oasis.local.home>
In-Reply-To: <20190410024103.GA104423@google.com>
References: <20190410011418.76408-1-joel@joelfernandes.org>
        <20190410011418.76408-2-joel@joelfernandes.org>
        <20190409223820.511e3671@oasis.local.home>
        <20190410024103.GA104423@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019 22:41:03 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> > Other than that, the two patches look fine to me.  
> 
> Could I add your Reviewed-by in the respin?

You can add an Acked-by, as I haven't spent enough time to offer a
Reviewed-by tag. ;-)

Maybe I'll get some time to vet it a bit more tomorrow, and then
upgrade the ack to a review.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
