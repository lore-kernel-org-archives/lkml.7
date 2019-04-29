Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D89C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3677E2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfD2NNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 09:13:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfD2NNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:13:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76C5C204EC;
        Mon, 29 Apr 2019 13:13:21 +0000 (UTC)
Date:   Mon, 29 Apr 2019 09:13:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Yue Haibing <yuehaibing@huawei.com>, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, geert+renesas@glider.be,
        me@tobin.cc, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -next] lib/vsprintf: Make function pointer_string static
Message-ID: <20190429091320.019e726b@gandalf.local.home>
In-Reply-To: <20190429110801.awvdxawpee3sxujs@pathway.suse.cz>
References: <20190426164630.22104-1-yuehaibing@huawei.com>
        <20190426130204.23a5a05c@gandalf.local.home>
        <20190429110801.awvdxawpee3sxujs@pathway.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019 13:08:01 +0200
Petr Mladek <pmladek@suse.com> wrote:

> > Looks like commit "vsprintf: Do not check address of well-known
> > strings" removed the: "static noinline_for_stack"
> > 
> > Does pointer_string() need that still?  
> 
> Heh, it was removed by mistake and well hidden in the diff.
> 
> I have pushed Yue's fix into printk.git, branch
> for-5.2-vsprintf-hardening
> 
> Thanks for the patch.

But doesn't it still need the "noinline_for_stack", that doesn't look
like it changed.

-- Steve
