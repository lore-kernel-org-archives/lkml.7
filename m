Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3911C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7524520731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MuUK2RK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgAFQuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:50:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DA/PEhn/bC49HDh5jCDSJA4tw5UwFNX46Z1N0nzIQNU=; b=MuUK2RK0jwRPbv1ghUu9FMtiA
        BflcHohuyp1tJjLG8A7v5CwhOXsNQVtdgxLmJkVmxoobIXFINZFEs0YIIFVUKYG/mMqdSpJrupHxR
        VwS3VrtSnl3LHfbnkiDz4XewDCUXSHqTY3V1xeYi261KEP+TSCwhQTsXciUk7CTn32qks6qksrrIM
        o1qZeNsZVJiBlIgOgSxvEA/hs7LT9QecrxzuBtB8yZD7ueQymSji7161BsBtGfh3wRaqoXqDJ+389
        eA/XHF1+6k9KJ6Klc+9whtb1OfrOMW+tJAIJ0XAAlSNyxQVN6f7QcWNxWtREst9/WRJUW86WHqocd
        aJRYs26Uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ioVZs-0005VB-0u; Mon, 06 Jan 2020 16:50:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3E573006E0;
        Mon,  6 Jan 2020 17:48:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C17D72B2844FC; Mon,  6 Jan 2020 17:50:01 +0100 (CET)
Date:   Mon, 6 Jan 2020 17:50:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 0/6] locking/lockdep: Reuse zapped chain_hlocks entries
Message-ID: <20200106165001.GO2844@hirez.programming.kicks-ass.net>
References: <20191216151517.7060-1-longman@redhat.com>
 <dfcfc267-1a2f-8070-c08b-662e9fe4798c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfcfc267-1a2f-8070-c08b-662e9fe4798c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 10:54:24AM -0500, Waiman Long wrote:

> Ping! Any comments or suggestion for further improvement?

You got stuck in the xmas pile -- I haven't looked at email in 2 weeks.
I'll try and get to it soon-ish :-)
