Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B4ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727A921E6F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XjVGMq9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbfJ1JVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:21:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbfJ1JVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=omUBJeAkZsfdBHKC0beslz+VEerlp44bbMQsy1qRu/w=; b=XjVGMq9/GLcBg/EQjOZiPkdfw
        C754lCosv0nklPNdYpI+eiEBUfIxBzx7aBokqv1LnqMyVNjeee50gsnLkwj08jE9xviLgEK4B2cFm
        //NkJeFrz7jxksMAuwppe9mbMwyN0bBCPaPyUs1xSMjtACb/rp45fh3eoNJxpJ81FsXwJhB3BGKld
        goz2ft3lU3237io2wJh5al7D1+Qi4NK5LX9bgMNqk1ZjsEi8jj5DPFmCVmXFgfMNpAbo38oNqXF2W
        HiBXLHN7/jKAwmkKm/AZ2PPnhu4Z+EmtonUwv253eIe4N3yyo7tFFUCJZfn56ri0pu4C4O3f3nGvs
        MqXvvnVaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP1Cw-0006NO-4I; Mon, 28 Oct 2019 09:21:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A0F6306098;
        Mon, 28 Oct 2019 10:20:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E1E320098AB8; Mon, 28 Oct 2019 10:21:00 +0100 (CET)
Date:   Mon, 28 Oct 2019 10:21:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, walken@google.com, dbueso@suse.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 2/2] lib/rbtree: get successor's color directly
Message-ID: <20191028092100.GD4114@hirez.programming.kicks-ass.net>
References: <20191028021442.5450-1-richardw.yang@linux.intel.com>
 <20191028021442.5450-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028021442.5450-2-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 10:14:42AM +0800, Wei Yang wrote:
> After move parent assignment out, we can check the color directly.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
