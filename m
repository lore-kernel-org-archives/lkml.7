Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4B2C00306
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3838720828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567710947;
	bh=p/WXnL93kys4Xsusi5YfOkEr9fenxVutlgLMNmczUH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CVBrq/7lugnZYYKwOORvUTV8GKWQDt6gkSsNUA0f6NRtFZVECfUvbm0w7U8qkFECd
	 eBeeGa0F+c1qChPJ11CfDFCv09TdlUhAIW0Bd6iN2AOqWy5k74gSImp6JfkEFpCHit
	 E6KD6+LCC0Z8dLUBBMyKrkWQHWg6vQnqj9fw0WUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388504AbfIETPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 15:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfIETPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:15:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA4102070C;
        Thu,  5 Sep 2019 19:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567710945;
        bh=p/WXnL93kys4Xsusi5YfOkEr9fenxVutlgLMNmczUH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvvyPTYbbkyZREMPHAwyx0Fkj94ZYu0PnVNivdihPqNea+j/SxcznTdwzJkmE5g1Y
         wrbF93QO15rgcSJvx2To/Rwgf3ERBAEXgK7oRHJblZiNLfAK1bhaZ89+FTmvcru1rj
         PO9pMBdNAfxV4g2SyxcSeRZI2EV+rYqEsPT7OdgQ=
Date:   Thu, 5 Sep 2019 21:15:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.2 000/143] 5.2.12-stable review
Message-ID: <20190905191542.GA15748@kroah.com>
References: <20190904175314.206239922@linuxfoundation.org>
 <20190905165627.GF23158@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905165627.GF23158@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 09:56:27AM -0700, Guenter Roeck wrote:
> On Wed, Sep 04, 2019 at 07:52:23PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.2.12 release.
> > There are 143 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri 06 Sep 2019 05:50:23 PM UTC.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 390 pass: 390 fail: 0

Thanks for testing all of these and letting me know.

greg k-h
