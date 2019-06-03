Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EE1C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9615428138
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cu+pcNR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfFCL0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:26:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51800 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbfFCL0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FO4mNdqO7GRtKaO6OguaIlOImO7ms4I9GTOCT+qHrDo=; b=cu+pcNR3+UPiQFO+3nWRYZ1I7
        sR2gRqyAh5SMwmf7ZEerRTc4tKfCsvf5qxpo/yrPxf2dsas4xqK7EvPIO2zakJWeCOe3ZXt8i8aDH
        vpims27c/ETrbcMSbr42ddCOVOgwDlsq0GfSWkVqOpTia5K01pXB5jg0/a+gRB+pznJVO6y1w/BIM
        Gm37Ju8AXSG3OAS2YMzVV01J7q+yRfB2w4bvCcDv3KVqSzg+yxheMtkInYrlhAZBCP3Khlrg7lArU
        rudGVGSYl1Eo+OftMh+S7C6J184vInPKRh3VHPhKnHUpEQ7l0ZxMo+PAuOwjS672WsemNF/YsZRpi
        iR0vYDb0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hXl6m-0002Tq-Gw; Mon, 03 Jun 2019 11:26:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DEE5B2025480A; Mon,  3 Jun 2019 13:26:29 +0200 (CEST)
Date:   Mon, 3 Jun 2019 13:26:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] sched/fair: Cleanup definition of NOHZ blocked load
 functions
Message-ID: <20190603112629.GH3436@hirez.programming.kicks-ass.net>
References: <090C3AE4-55E4-45F3-AEAB-3E7F26FB7D6D@lca.pw>
 <20190602164110.23231-1-valentin.schneider@arm.com>
 <20190603093835.GF3436@hirez.programming.kicks-ass.net>
 <17c51655-19a0-e15d-5e14-611171f3cc8d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17c51655-19a0-e15d-5e14-611171f3cc8d@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 11:22:40AM +0100, Valentin Schneider wrote:
> On 03/06/2019 10:38, Peter Zijlstra wrote:
> [...]
> > 
> > I'm thinking the below can go on top to further clean up?
> > 
> 
> Yep, that's even better indeed! Want me to resend with that extra diff?

Yes please, I didn't even get it near a compiler, so who konws what it
will actually do ;-)
