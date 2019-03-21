Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7256C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB76205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfCUNOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbfCUNN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:13:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA4E52083D;
        Thu, 21 Mar 2019 13:13:58 +0000 (UTC)
Date:   Thu, 21 Mar 2019 09:13:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        diamon-discuss@lists.linuxfoundation.org,
        lttng-dev <lttng-dev@lists.lttng.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [diamon-discuss] [RELEASE] LTTng-modules 2.9.11, 2.10.8,
 2.11.0-rc2 (Linux kernel tracer)
Message-ID: <20190321091356.38a6988d@gandalf.local.home>
In-Reply-To: <20190321124122.GA30542@google.com>
References: <60988959.4070.1541112982406.JavaMail.zimbra@efficios.com>
        <CAJWu+ooEbjOXgVeq+g4MGEve9PTo7p7UUKjYYHhq-Wz6UbUhfg@mail.gmail.com>
        <1199524058.2398.1553016874435.JavaMail.zimbra@efficios.com>
        <20190321124122.GA30542@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 08:41:22 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> Also does it also make sense for lttng ring buffer to use the ftrace code for
> ring buffer, or make the ftrace ring buffer better and have lttng use it? Or
> is the lttng ring buffer design too radically different?

We tried in the past and never actually got something that we both
could agree on. Now I believe the user space tools depend on the way
each one is, so to change one will break the tools that read it.

-- Steve
