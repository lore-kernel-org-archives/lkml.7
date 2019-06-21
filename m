Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CE7C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF3B206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z8rASQxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfFUNDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:03:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53468 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfFUNDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8voMoB854F0d0ERXQAC40rhDRb6mL2IHOiaUQ+KH42o=; b=z8rASQxg05EpGWK8+LWzS8UKu
        R2t5YFty57rg3tJ+9o5GBkwAFsW238Ziar0WfMCtcJq1L/DAcVT1w/tbaJA4s64uIwHAkmnFyISd4
        4ANrU0r4enmtDhKjihUH0dSv4PnuZ4uUBgt0i5fxsojbqLFtJLRJZk23qdNTYXHIxV16wNZ4pDumI
        /sjfSFSbKJDdeOKwJ3Jnna5pw+NrsuUl4w0QdqE31uGhi36L8x9HNb/RZ2nLEob7bPa3O0kvNi5kb
        qce7MpVKClVlejw/WlIYqVDd8POiUFWKg6VCUmo1w6J3NbQsMuTKB3wsmCpKosmPAI9zG9BJ2bFMr
        HQRgz5mrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heJCI-0000dQ-6O; Fri, 21 Jun 2019 13:03:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF757203C694A; Fri, 21 Jun 2019 15:03:16 +0200 (CEST)
Date:   Fri, 21 Jun 2019 15:03:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     xiaoggchen@tencent.com
Cc:     jasperwang@tencent.com, heddchen@tencent.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        viresh.kumar@linaro.org
Subject: Re: [PATCH 0/5] BT scheduling class
Message-ID: <20190621130316.GK3436@hirez.programming.kicks-ass.net>
References: <1561103157-11246-1-git-send-email-xiaoggchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561103157-11246-1-git-send-email-xiaoggchen@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 03:45:52PM +0800, xiaoggchen@tencent.com wrote:

> First only server application exists in the system and the success
> rate is 99.998% and the average cpu use is only 25%.

Have you guys looked at this series:

  https://lkml.kernel.org/r/cover.1556182964.git.viresh.kumar@linaro.org


