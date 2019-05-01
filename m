Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192E2C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17DE2085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556730861;
	bh=bIys+josMoWSS35pZLTP5GuoNAmMkIfOp7dfq30+0GY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dwgWy+RnhaBQCQB6MhX+5hHuBNfqHx2e86dLIsWOjahGsj+Lrc4t2Us4JtmlKL3M4
	 r5MTlWVBeSsm78WVvx9ZwtB3ZtVcFrVm1d7v191w0K2IsI0whCN9KCyHg28s1qbhvV
	 mLLeVyLwo2pen6SuWqC0OBYqj8n8VgbqG0+iwO7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEAROU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 13:14:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfEAROU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:14:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1376C20835;
        Wed,  1 May 2019 17:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556730859;
        bh=bIys+josMoWSS35pZLTP5GuoNAmMkIfOp7dfq30+0GY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUbdmv7J4NyFhY9XZ0Lak3kFKY9BOeyx+dXdJ9/hPCHOYGXgiSiSQHQsx72F2LLmj
         11pVkX9RNzIjp9zWaoC3g/EB4XmRwr0EIewP4MWh2+fgljiqOZaZDS36bLmPVRrcpr
         xr/5UuB0+XxkPZiTKyf6oJmifX/wrvDgBHVpllrM=
Date:   Wed, 1 May 2019 19:14:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/89] 5.0.11-stable review
Message-ID: <20190501171416.GA28949@kroah.com>
References: <20190430113609.741196396@linuxfoundation.org>
 <20190501164452.GD16175@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501164452.GD16175@roeck-us.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 09:44:52AM -0700, Guenter Roeck wrote:
> On Tue, Apr 30, 2019 at 01:37:51PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.11 release.
> > There are 89 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu 02 May 2019 11:35:03 AM UTC.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 349 pass: 349 fail: 0

Wonderful, thanks for testing all of these and letting me know.

greg k-h
