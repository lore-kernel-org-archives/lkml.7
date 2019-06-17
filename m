Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF422C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E282084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nZH+4j8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfFQPAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:00:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfFQPAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZIvFbKZaQLOIuyrJaXmuIvfTXijDUIFmZxmCklVfXEQ=; b=nZH+4j8grLF4KCgE2TqNfy9Yh
        AdwTTjhIRwTAd8hk984TUDrQLZuBcoyBm5pMGIv9BQScgDnx3RxBppokKlRVEtWFPxXfaL8zm8fhG
        7KAnpne8lb0YDNJgi+YEH5KzUJwBYLAXk9i+NRPfpn/dGk8pgj7z5xvP9eAWIOsS2v2ycEIU9aMGF
        FxiAiGeX4474O5UK3bgnWqWso8C5ZhyKP5jdoJ3Wu6WN6fmDFUQA6jvz9WvNntDOv5OcQRMsA78hs
        0tDgweF4V8tszLCDrUe3ru9XQoJA9bZxrdk+2fUi745NAxtwsflQ4I35jULWjPf12IxNx84dbhPdo
        LDmI6Df9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hct7h-0005Ge-6f; Mon, 17 Jun 2019 15:00:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5DA4201D1C98; Mon, 17 Jun 2019 17:00:39 +0200 (CEST)
Date:   Mon, 17 Jun 2019 17:00:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sched: Deduplicate code with do-while
Message-ID: <20190617150039.GR3402@hirez.programming.kicks-ass.net>
References: <43ffea6ee2152b90dedf962eac851609e4197218.1560256112.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ffea6ee2152b90dedf962eac851609e4197218.1560256112.git.asml.silence@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 03:29:07PM +0300, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> Statements in the loop's body and before it are identical.
> Use do-while to not repeat it.
> 

Thanks!
