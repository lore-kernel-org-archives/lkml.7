Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09950C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2092075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WrE0+5CZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgAFO5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:57:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgAFO5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vkN1U9NOAVAkb2O91kghg6Ka2eUHgcRziB69Lugg7Pk=; b=WrE0+5CZBk8PGWIA0IeW9eOrM
        MjGyM+i5cSP3FTCEGUaLYwML3qTPBtvaRmWO1xQ8NSRJ1K+zqANcO2OCgfXKKjxDyK3mapDdkOcVY
        +N7TbjoiRWLmWOdXTaA0mY1BvukYMLatCASlvlly1KzUB+rXU10ldbTiAQnwrEIj7Yi0PAQGaBf6x
        JnDZ6+/HHOZh2vrSM7JVJ2Qq12OzT+9kFg7WpcN5s6uiDozegxtDzhvwqIY/pRnLQHlkzuV8qaR9P
        IfGqtRo8ff6WpFixra3HrVQfy/GT4OSpQXTdq90E/e/199GAky9OUEt25VkhCenFdgCO9K0OLwtKW
        7y341UwKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ioToR-0005U7-VK; Mon, 06 Jan 2020 14:57:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 202143012DC;
        Mon,  6 Jan 2020 15:55:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33C2A2B27B124; Mon,  6 Jan 2020 15:56:58 +0100 (CET)
Date:   Mon, 6 Jan 2020 15:56:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     tglx@linutronix.de, heiko.carstens@de.ibm.com,
        mark.rutland@arm.com, paulmck@kernel.org, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stop_machine: Make stop_cpus static
Message-ID: <20200106145658.GR2810@hirez.programming.kicks-ass.net>
References: <20191228161912.24082-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228161912.24082-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 04:19:12PM +0000, Yangtao Li wrote:
> The function stop_cpus() is only used internally by the
> stop_machine for stop multiple cpus.
> 
> Make it static.

Thanks!
