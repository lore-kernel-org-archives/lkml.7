Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9386EC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 21:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC84206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 21:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbfESVfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 17:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729314AbfESVfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 17:35:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF11820578;
        Sun, 19 May 2019 21:35:19 +0000 (UTC)
Date:   Sun, 19 May 2019 17:35:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: silence GCC 9 array bounds warning
Message-ID: <20190519173518.5f40adfb@gandalf.local.home>
In-Reply-To: <CANiq72=hUULnd_oDoGoD2gjE-QvL2Kw2n7hMxke+gkS2_gzCqw@mail.gmail.com>
References: <20190517092502.GA22779@gmail.com>
        <CAHk-=wiNkOU-Ng+9_+tj4-AqJ4Q9JQpVbR4QVVAWLY68yQ62Gw@mail.gmail.com>
        <CANiq72=hUULnd_oDoGoD2gjE-QvL2Kw2n7hMxke+gkS2_gzCqw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019 21:09:21 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> By the way, how do you all feel about moving this as a generic
> facility to zero out the suffix/prefix of an structure? In particular,
> since we won't have the LAT* stuff according to Steven.

Is this done in other places? If so, how many.

Note, the LAT* update doesn't belong in the iterator reset function,
but the pos = -1 still does.

Thanks!

-- Steve
