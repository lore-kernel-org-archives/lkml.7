Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA14C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2992085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F5vPII2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfCSQJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:09:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfCSQJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VWfA3zV/LSFZvWZI90P08tGisTPw5jKn8duxtPub0IQ=; b=F5vPII2kJ2EdJVj4S1qLWpv6x
        qsifd63p/ILoTbqcUJyWMS2E1i/GWfELwk/9CoMGVhPj6KZFTDylsg/DADh/0cq+5yLETdCrh7/Bs
        1RpebI3aRXClfRuUJZUaYrKeTD9uY3RWkNhNkgbbC2WsbPQ8yzo8T1xSwVbpJAn32zrmDoIUOuuTN
        XfOptQXsfg5lcx+yd0sdFI2sxhmFDjkmdmhbDIm5vMVGeoHuobvxLf5RvFzp5YkldBP0/QKQIpsAG
        DtkPsLbT2iiMMR+p+/pUzaFXgHDQiS3SlM1DN/6IMKomvXDYl/QtiOplNgY12NVjwAfKRF6D+xEfN
        1q/3hmU8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6HIi-0006iz-2z; Tue, 19 Mar 2019 16:09:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42E7923CB6531; Tue, 19 Mar 2019 17:09:14 +0100 (CET)
Date:   Tue, 19 Mar 2019 17:09:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 05/22] perf/x86: Support constraint ranges
Message-ID: <20190319160914.GL5996@hirez.programming.kicks-ass.net>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
 <20190318214144.4639-6-kan.liang@linux.intel.com>
 <20190319145309.GI5996@hirez.programming.kicks-ass.net>
 <20190319155757.GV24002@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319155757.GV24002@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 08:57:57AM -0700, Andi Kleen wrote:
> > >  struct amd_nb {
> > >  	int nb_id;  /* NorthBridge id */
> > 
> > That's all the code, how does that add up to 2k ?
> 
> Because the tables are bigger. There are much more tables than code.

Tables is data, not text.
