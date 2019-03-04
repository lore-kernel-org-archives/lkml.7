Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EEEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C74206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NhbMmZzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfCDSuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:50:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46850 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCDSuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PKC+zoEru7DDViAvU8FoXjcH/vIeePfpxdAwIyY4xL4=; b=NhbMmZzqA/jknNNdiHLVUHGWM
        NZUJU1oPZ9ZZ+couBarfpv32vtuyyIRy881HjrRZgD4PufYH4l979xx8Ka+yQR+waO+rKawjBIRHx
        PgNyoyEdEyQ+Uzpvh56u38w2+e0Yvt/Kpv6fBmrCWDnIFlIhA7oMN1ZKspJOytUTdMM/Dooz8ARPR
        cSOyHD337qXmvh6Kg9zf+wriECAOJEWzS8TDmCh0g5+vQWk7kS8nsUYttyHnjUGoUsNMJdyM48viz
        eNRaQVBhMk8k1e1APo6MliCl71FTgbuWoNX9E0w0g9E6j733K7OWdAFC4R5TVdhHQdxI4ljBoD2Kh
        k6844x8yA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0sf1-0007xK-U4; Mon, 04 Mar 2019 18:50:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2FE620288BA3; Mon,  4 Mar 2019 19:49:58 +0100 (CET)
Date:   Mon, 4 Mar 2019 19:49:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     mathieu.desnoyers@efficios.com, paulmck@linux.ibm.com,
        boqun.feng@gmail.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftest/rseq: Remove duplicate header
Message-ID: <20190304184958.GR32494@hirez.programming.kicks-ass.net>
References: <20190304183827.GA6809@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304183827.GA6809@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 12:08:27AM +0530, Souptick Joarder wrote:
> Remove duplicate header which is included twice
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

That SoB chain is invalid.
