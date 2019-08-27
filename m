Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12649C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44392064A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KamsYMEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfH0Vvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:51:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfH0Vvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q4vKrxlRL7Y7Ibwtn4SEfiSUk0Q/l6PJWhH3yvC0ACQ=; b=KamsYMEo8kQObgNdEuux8L2cx
        6U1Bc9VEtwQK1ZioMgmBHtrXcFcXi7ypCXNm7P2T6JTYjzFTlUTCu9fdI7K6FT7Z1cCyvclDal6ho
        Nfvayq3HtOFGTe9CMx88yvcGlUg1Sn011wa6swcluz42QrqqF1Rjw14Grf5iNS5ijehMOKta7X1Di
        Fyhn8I2E01K+he9eS/fMcIzNoaniyitkwjNuxcu9s6kh72W2MsoQGWkkBOyWgKYnNgdYDbLASKCme
        cbF9zgGGp+vpW6bf+3Sc9iZF0gz7Vj2miPjDwex+vOqpwAsy1TxmZp4JBF1GVufQiew1Lq5U2z+Zl
        KEbIVa3aA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2jNJ-0003L6-Cx; Tue, 27 Aug 2019 21:51:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96ED5307597;
        Tue, 27 Aug 2019 23:51:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 600F3203CEC05; Tue, 27 Aug 2019 23:51:35 +0200 (CEST)
Date:   Tue, 27 Aug 2019 23:51:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -v2 0/5] Further sanitize INTEL_FAM6 naming
Message-ID: <20190827215135.GI2332@hirez.programming.kicks-ass.net>
References: <20190827194820.378516765@infradead.org>
 <3908561D78D1C84285E8C5FCA982C28F7F43EC93@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F43EC93@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 08:44:23PM +0000, Luck, Tony wrote:
> > I'm reposting because the version Ingo applied and partially fixed up still
> > generates build bot failure.
> 
> Looks like this version gets them all. I built my standard config, allmodconfig and allyesconfig.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> 
> What happens next? Will Ingo back out the previous set & his partial fixup and replace
> with this series?  Or just slap one extra patch on top of what is already in tip?
> 
> First option changes a TIP branch

This is uncommon, but not unheard of. I'll talk to Ingo and Thomas
tomorrow to see what would be the best way forward.
