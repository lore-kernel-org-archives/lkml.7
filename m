Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4507C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06C320811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ng4USdau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfDWLTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:19:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47812 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfDWLTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9dI4Sk2ke72Ib9kZokOQXHR9Plp7vlR5+6E/NjlqO1Y=; b=ng4USdauPZaFq4WaXiN99ZRv+
        6652E/r9ekkoL6w5TD/uDIGEryVj//w8WsHXwibtZEKgmHmQ9gQeBsxVvdYfbyJLeNDBEqiTvX+km
        SVkYdz98E//pJ8aBdD4+cpEW1FfUPqJCKqAxREtVMDgMhYJ7GTz8PaByCiCyMigAWl+36Yk6+X7Wk
        3XwdtonfSeb2u4uwREdE/Y2XbAYfgMwO29VWzL+W3FMPm/tpyHualLKKG3Ru9hJl0v4LlbyDKPeKp
        pEiy/ruvXnPX/GMZvAyzwkmM0r4f965z/LMGoOc/zbt1INkK/XrIKYsrCYxA3anQygQwli3aqIUBs
        Fv0MgcI1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hItSe-0003Fl-Q9; Tue, 23 Apr 2019 11:19:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6DF3F29B59F03; Tue, 23 Apr 2019 13:19:37 +0200 (CEST)
Date:   Tue, 23 Apr 2019 13:19:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 38/79] docs: scheduler: convert docs to ReST and
 rename to *.rst
Message-ID: <20190423111937.GM11158@hirez.programming.kicks-ass.net>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
 <2a3b2b06459e0134a3af4fbf3e6f62e6d42c4d26.1555938376.git.mchehab+samsung@kernel.org>
 <20190423082937.GZ11158@hirez.programming.kicks-ass.net>
 <20190423103202.GA13655@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423103202.GA13655@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 12:32:02PM +0200, Ingo Molnar wrote:

> The .rst files still read like text files, right?

Like a harder to read text file for no gains.
