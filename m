Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37F4C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46C321850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YZjVKFTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfGELrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:47:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34064 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfGELrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fgcIB8dSUev3YqJ1JWPZab5C8w5JtTrTGWHkF5Kw0pI=; b=YZjVKFTASSc+GLe9Qv6UnL4j7
        cYG1jw5rTwdC/ZRDDkwCT3Fj+1sUuAcjccYWXofzwDValDd7MbGN0Uh4U5GqgCgRQ+CdGE+sIFhtb
        /er+/geFJOQZbHcDQ8dZ0Md2gdRN3vSZBvmH3x0jluyjxM1mhCIZhYc5atvgym/L/STb2D36HyIgx
        WhXl4aAGM5Liqs0y5oUsLaPtnqoXiyVatT3me/Vf98cXOPSIV+CYS8b4bxEVw/x10IFZ5CdVy+O8m
        0jaBCPa4h3OrSwoKMoxu0airgMufV/YV0oqgQY2PPTzpuwUaAXLrMxrz1rU1WllbD+QQnlg+dH2qb
        e0cfXt7Aw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjMg0-0001QY-9W; Fri, 05 Jul 2019 11:46:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0FC6E2026E806; Fri,  5 Jul 2019 13:46:51 +0200 (CEST)
Date:   Fri, 5 Jul 2019 13:46:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] Convert get_task_struct to return the task
Message-ID: <20190705114651.GR3402@hirez.programming.kicks-ass.net>
References: <20190704221323.24290-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704221323.24290-1-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 03:13:23PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Returning the pointer that was passed in allows us to write
> slightly more idiomatic code.  Convert a few users.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Sure, thanks!
