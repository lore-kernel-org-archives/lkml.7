Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601EFC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2328C20836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vSztaPJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfGBIgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:36:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44540 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfGBIgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sY0UaQf2BxPnJAS0pHMdl/JmZYTYN6LHhMVkukh8JKc=; b=vSztaPJJffSldQkENZB/P6Otf
        6HhDOoClhCxdbAwH8DRTCI2f+O+oIBOEHPY3en8a04pJ4vsKmsdLqrnHRVmq9gCRj5XJTH3m7RG7J
        TnErkOXxUNaYxL0d9X7pdh/ifr9ho6LBonQlYNTfy3jy7DCsLdZBWUwQd1YQiXaaiAs/pl+zT1qjz
        iL+p9amPlFH7qCkg1RCBT6fAzoo8WPg99VK1yiu60xcKauNcTcnRIA/gEYg1XY1zJbfH3nemQXLEa
        mvXKUWVDuuczK8YvDRBJ14ZLCJ+RGHiWY/I6CkQpLH3IIq6TVReD8t7IVmeLtgpDqUw2RSi9eCcl3
        jUcmyb1Tw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiEHC-0005Zo-2Q; Tue, 02 Jul 2019 08:36:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C22FB20ADAD55; Tue,  2 Jul 2019 10:36:32 +0200 (CEST)
Date:   Tue, 2 Jul 2019 10:36:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Signed-off-by for the fix-late-interrupts patch?
Message-ID: <20190702083632.GZ3419@hirez.programming.kicks-ass.net>
References: <20190701213930.GA25736@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701213930.GA25736@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 02:39:31PM -0700, Paul E. McKenney wrote:
> Hello, Peter,
> 
> The patch below from your earlier email is doing fine in my testing.
> May I please add your Signed-of-by and designate you as author?

Sure, glad it worked :-)
