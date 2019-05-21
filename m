Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E43C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005FF21873
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfEUVQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 17:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfEUVQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:16:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AAEB2173E;
        Tue, 21 May 2019 21:16:04 +0000 (UTC)
Date:   Tue, 21 May 2019 17:16:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Michael Jeanson <mjeanson@efficios.com>,
        lttng-dev <lttng-dev@lists.lttng.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH lttng-modules 4/5] fix: mm: move recent_rotated pages
 calculation to shrink_inactive_list() (v5.2)
Message-ID: <20190521171602.09481e99@gandalf.local.home>
In-Reply-To: <1045726286.6695.1558472016130.JavaMail.zimbra@efficios.com>
References: <20190521203314.8577-1-mjeanson@efficios.com>
        <20190521203314.8577-4-mjeanson@efficios.com>
        <1045726286.6695.1558472016130.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 16:53:36 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> So I recommend we do the following in lttng-modules:
> 
> Rename the field nr_activate0 to nr_activate_anon,
> Rename the field nr_activate1 to nr_activate_file.
> 
> So users can make something out of those tracepoints without digging
> into the kernel source code.
> 
> Even if Steven and Kirill end up choosing to change the name of those
> fields upstream in trace-event, it won't have any impact on lttng-modules.
> 
> It would make sense to change those newly introduced exposed names in the
> upstream kernel as well though.

I'm fine with whatever Kirill decides.

-- Steve
