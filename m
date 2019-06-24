Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED9FC48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6F0212F5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S0OOWkMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbfFXNdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:33:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbfFXNdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IDDl34/KAi739r3TKIL1925N+WLKsZDgMR4rlC9aiPk=; b=S0OOWkMgsjyTrHyiPveXh3eYt
        daAYZVDsOjPSSyRQrtWqHfcbRFz9vWfX8JiGXMLN+jbwtCDU9rCETU1rfnHRgqiuFirOtLSKR4yiZ
        0uMuMsTfdLHiDiiwQX8/xMjUez5IM+bNuhLXqsQolt4vdcOcRtjmMhIy6BiFeql6SkiZTfejhDenD
        JQ7PnZD6Ju5zi9j679eu48d3uvHIAq5hOOjZ1NsMLA9Ych41KtysiTiWMZCHpUcGFiiCVX7jEY6Oh
        SLCq5nPzJdnhxW6ndrrhgVvE2iGcb6MqW7LoXtmdUOorKJPLA4Tpwb4Wvq19eikliGtDLIBmuoV/1
        4geSQgA7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfP6F-0002xQ-63; Mon, 24 Jun 2019 13:33:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0BE9209C958C; Mon, 24 Jun 2019 15:33:33 +0200 (CEST)
Date:   Mon, 24 Jun 2019 15:33:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] get_maintainer: Add --cc option
Message-ID: <20190624133333.GW3419@hirez.programming.kicks-ass.net>
References: <20190624130323.14137-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624130323.14137-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 03:03:23PM +0200, Sebastian Andrzej Siewior wrote:
> The --cc adds a Cc: prefix infront of the email address so it can be
> used by other Scripts directly instead of adding another wrapper for
> this.

Would it make sense to make '--cc' imply --no-roles --no-rolestats ?

> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks bigeasy!
