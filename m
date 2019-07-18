Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4D3C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CAD2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbfGRQhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfGRQhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:37:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F33BB217F4;
        Thu, 18 Jul 2019 16:37:44 +0000 (UTC)
Date:   Thu, 18 Jul 2019 12:37:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Eiichi Tsukata <devel@etsukata.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@redhat.com
Subject: Re: [PATCH] tracing: Fix user stack trace "??" output
Message-ID: <20190718123743.3aa5d697@gandalf.local.home>
In-Reply-To: <1789efd4-1108-64e8-a6aa-39ca5d5595dc@etsukata.com>
References: <20190630085438.25545-1-devel@etsukata.com>
        <1789efd4-1108-64e8-a6aa-39ca5d5595dc@etsukata.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2019 10:23:19 +0900
Eiichi Tsukata <devel@etsukata.com> wrote:

> Hello Steven
> 
> Would you review the patch?

Thanks for reminding me. Looks good, I'll apply it now and start
testing it.

-- Steve

