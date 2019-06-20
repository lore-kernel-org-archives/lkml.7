Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20B2C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7CE206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IC50XXLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbfFTMY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:24:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfFTMY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Unq1od9gBMqSxPx7a5Et+3hxjsns5RGwC7ff0uUVv6Y=; b=IC50XXLtz3H7Bk8IpBlqcAGIX
        fAfZrCi9iLOW77MUhgIvOE2JgLXkaRMBkf0taVefQu8roXWwJeRxjyf+m0fTn53dM4Q6TgxHHN5Q1
        PltJoxvVDO1reqNucXdI98k1Jr+G1buypke5SYWtHlMGgvObWpRFUZ6Z00fDCf/i2lyRG7pklKbjV
        /h1EfFOpCpUeXcwwvMNDC3apg0LYoJ/hcA9TqnCuje879KBjFDw+hmDh2FC9thOqzwPuLU2ToKtlJ
        hkoiLxv4LCuFIwUWpeJhALMXsptzYzzqxGgmmuFgXyKIJ44KUnut0tc0JTTOTAakW40xcuJWT7KU3
        SNrJWa3KA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdw75-0007Y5-Ms; Thu, 20 Jun 2019 12:24:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1313C20292FD3; Thu, 20 Jun 2019 14:24:22 +0200 (CEST)
Date:   Thu, 20 Jun 2019 14:24:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, acme@redhat.com, vincent.weaver@maine.edu,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, jolsa@redhat.com, eranian@google.com
Subject: Re: [PATCH V3 1/5] perf: Disable extended registers for non-support
 PMUs
Message-ID: <20190620122422.GW3436@hirez.programming.kicks-ass.net>
References: <1559081314-9714-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559081314-9714-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 03:08:30PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>

Ok, have them now.
