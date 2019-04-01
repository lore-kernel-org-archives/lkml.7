Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA6CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBA020693
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZWnpKISp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDAKcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:32:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37618 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfDAKcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ie0lAOSZLlL9G+yYP8lv6B6/abvf+grl900kYhywh/g=; b=ZWnpKISpu7Qo0yy7xkDR/pUcu
        kFUShCPUI2X5JWQHkOtzdiyV8IgY1aOLaxepa7lo/5LVzxpMpGIz0r4UreBeo+W+IGfw2cGbv8p5U
        F7q/fDtMRM35qbZsvC7J9ggyi7eD+igN2NubwMK629Pq7qX3tQlkdyPTn0JJy5f0vlr71S+Wb6dwG
        G6bn5dGAhgH0Ux7jV5TBbbpz/F4YGJJUoIx/Ja60ps1veU/m8a5UbPsSjt2it8HCPWW/Jx/ugGO3A
        /WnWRwxiEX4loevsP4h5OPnZHScVfioNioU6SADN9zkFYWnE7eBl9PeH3GC7aTEhOLGx2V0nUqlA+
        sjhmkfkNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAuEL-0008DK-VN; Mon, 01 Apr 2019 10:31:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 221C92026BE97; Mon,  1 Apr 2019 12:31:52 +0200 (CEST)
Date:   Mon, 1 Apr 2019 12:31:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>, mingo@redhat.com,
        paulmck@linux.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        shaoyafang@didiglobal.com
Subject: Re: [PATCH v2 2/3] sched/fair: do not expose some tracepoints to
 user if CONFIG_SCHEDSTATS is not set
Message-ID: <20190401103152.GJ11158@hirez.programming.kicks-ass.net>
References: <1553602391-11926-1-git-send-email-laoar.shao@gmail.com>
 <1553602391-11926-3-git-send-email-laoar.shao@gmail.com>
 <20190326082157.1d0c01cb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326082157.1d0c01cb@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 08:21:57AM -0400, Steven Rostedt wrote:
> Peter, Ingo,
> 
> Are you OK with this patch? If you ack it, I'll pull it in through my

Sure,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
