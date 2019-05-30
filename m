Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF3EC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 22:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C4826265
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 22:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfE3WDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 18:03:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:32870 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfE3WDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 18:03:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 090C814DB034D;
        Thu, 30 May 2019 14:26:26 -0700 (PDT)
Date:   Thu, 30 May 2019 14:26:26 -0700 (PDT)
Message-Id: <20190530.142626.1471109804622294121.davem@davemloft.net>
To:     tonylu@linux.alibaba.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        laoar.shao@gmail.com, songliubraving@fb.com
Subject: Re: [PATCH net-next 0/3] introduce two new tracepoints for udp
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190529130656.23979-1-tonylu@linux.alibaba.com>
References: <20190529130656.23979-1-tonylu@linux.alibaba.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 May 2019 14:26:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lu <tonylu@linux.alibaba.com>
Date: Wed, 29 May 2019 21:06:54 +0800

> This series introduces two new tracepoints trace_udp_send and
> trace_udp_queue_rcv, and removes redundant new line from
> tcp_event_sk_skb.

Why?

Is it faster than using kprobes?

Is it more reliable?

Are the events _so_ useful that they warrant a tracepoint and thus
creating a semi-stable interface for tracing and introspection via
ebpf and similar technologies?

Again, you have to say why in your log message(s).
