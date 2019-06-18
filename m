Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393B3C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA4120665
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aIrunKiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfFRMxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:53:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46746 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Bfy77u7tJNTd5J51nX2le6x0ue32vN6S4jsrNSu3u5c=; b=aIrunKiU1UPTSLW50Tzi5wZRH
        q927Au14ksQ497PRuHzG4SV2W/+qi3c0y5C4cJSKV2cEgYdfeHUOWgLjK4PHOA+BRcx5kWxjhjsTb
        jLy57uNFsNWDHEflxu5Qwujj5OJmGddrJAcOF8zt5/hUzAOygg98FDwvKO1XPnbA2WWTstLsVfnCt
        Ivfc681alAIMqYNSxEjffaNk4kqeo4CuWxWyfFmyLoWKdZWbbLMcIIiimRhdy5HOabAi70ERSmMCc
        5dhiZUwfu4SoprcD8Q6hb8XF7NxqhP5VW0Ibm9827qVND8W3SUCqykcD8PqLJvKQLLD1BqJFlPAoQ
        oxM6wLjzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdDbh-0007W9-Qd; Tue, 18 Jun 2019 12:53:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 643D9209C8912; Tue, 18 Jun 2019 14:52:59 +0200 (CEST)
Date:   Tue, 18 Jun 2019 14:52:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Michael Forney <mforney@mforney.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/atomics: Use sed(1) instead of non-standard
 head(1) option
Message-ID: <20190618125259.GI3419@hirez.programming.kicks-ass.net>
References: <20190618053306.730-1-mforney@mforney.org>
 <20190618121625.GC31041@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618121625.GC31041@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 01:16:25PM +0100, Will Deacon wrote:
> On Mon, Jun 17, 2019 at 10:33:06PM -0700, Michael Forney wrote:
> > POSIX says the -n option must be a positive decimal integer. Not all
> > implementations of head(1) support negative numbers meaning offset from
> > the end of the file.
> > 
> > Instead, the sed expression '$d' has the same effect of removing the
> > last line of the file.
> > 
> > Signed-off-by: Michael Forney <mforney@mforney.org>
> > ---
> >  scripts/atomic/check-atomics.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Thanks!
