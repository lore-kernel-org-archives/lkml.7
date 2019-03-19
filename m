Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ECAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462912064A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eTQ3F8s1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfCSQgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:36:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43068 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfCSQgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uiJXh23wIeh7CYR5HuWi5dhCXeQ+OAoWHakHkOf5iuc=; b=eTQ3F8s1jsRgHWTi0rsMNbpcb
        CAM/dlj738vqeeySkjD68djE/jT+O/XiVug7Sp5UqSXOAzpQgjxi9PWOegNWuWjtUoveFtYOVS2UG
        So8GXTLMh1z+5wyBZz02NI32VnGnFdKDMq7AMyuMqzp9iztUMAKKDPpGFAXH2Taufl/IiqzDrlB+s
        PaYJeedvWPM8LEc8M4Z+QS5sYDI3NxOncmqozNzn7DwqUnwRazBOq7w5MNC/FnWaFMQcHd2YFuqzz
        WlJ4LbzczePeGd9XK1K4qjRioAO2zg/aUpCzNqblIaDi8Atzk3hwMZCAmfTGYAaG2nNMmueOidXQ/
        t1d8HP5GA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6HjG-0002CW-50; Tue, 19 Mar 2019 16:36:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B53FC200F9310; Tue, 19 Mar 2019 17:36:38 +0100 (CET)
Date:   Tue, 19 Mar 2019 17:36:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Yuyang Du <duyuyang@gmail.com>, will.deacon@arm.com,
        mingo@kernel.org, ming.lei@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/19] locking/lockdep: Adjust indents for function
 definitions
Message-ID: <20190319163638.GC6058@hirez.programming.kicks-ass.net>
References: <20190318085733.3143-1-duyuyang@gmail.com>
 <20190318085733.3143-6-duyuyang@gmail.com>
 <1553013180.152266.51.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553013180.152266.51.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 09:33:00AM -0700, Bart Van Assche wrote:
> On Mon, 2019-03-18 at 16:57 +0800, Yuyang Du wrote:
> > Being paranoid to see function arguments lines are aligned.
> 
> This patch changes code that conforms to the kernel coding style into
> code that does not conform to the kernel coding style. If you have a
> look at the c-lineup-arglist-tabs-only function in
> Documentation/process/coding-style.rst you will see that only tabs and
> no spaces should be used to indent function arguments.

So while I generally do align things with tabs and spaces, but have no
strong opinions either way as longs as its readable; I do hate pure
whitespaces patches. They make git-blame so much harder to use :/

