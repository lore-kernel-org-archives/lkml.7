Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C53CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF25A2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sSzZS/8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfDOJRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:17:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOJRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uhpEWH6neJu2QMhSGFrpcqmZfPITg9TWcWrhBjiJ6KY=; b=sSzZS/8rdl/JhAdfqB7Qegkb/
        oyMWDE2YQF8gwtjJE/hpmrZ7Lmf9/wU6gce/MxNlUZ/tDeQOvHupnN6+D3I7949CCbQvh1CLWcxas
        kbN8IfFzUkZ/5nG8YJr1R89QdK3YpKpsMA8XIa/V0VDM7evBtQeziMkCcVECjD6blQ7HSOrDWoKSb
        ZXxMP4pfu+vRxu2N7WKODpgamYAL7y0HNlMEJOwcktyjwY1I7UNHriOGqOHEqVvjkUXcD1xqqDbw7
        RUjlaDKvbLWqM+NATvJN8sXx6i5L9RtV7GkOge3jZ+UhOJ4c+KAYm+UOMQ0dnfBgUULWiw+UENwe+
        UX5XV9WAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFxjV-0006vN-9W; Mon, 15 Apr 2019 09:16:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 718CD29AC5C51; Mon, 15 Apr 2019 11:16:55 +0200 (CEST)
Date:   Mon, 15 Apr 2019 11:16:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ben Gainey <Ben.Gainey@arm.com>
Cc:     "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>
Subject: Re: [PATCH] perf: Fix AUX record suppression
Message-ID: <20190415091655.GH11158@hirez.programming.kicks-ass.net>
References: <20190329091338.29999-1-alexander.shishkin@linux.intel.com>
 <7b073941dd6abfc81773f26573b103adf077bfed.camel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b073941dd6abfc81773f26573b103adf077bfed.camel@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 08:04:33AM +0000, Ben Gainey wrote:
> Hi Alex
> 
> I was just wondering if this was expected to make 5.1? (I could not see
> it in RC5)?

Yikes, I forgot about this again, didn't I ?

At least, they appear to still apply, so I've queued them. Not sure
they'll still make this release, but at least they should not go missing
_again_.
