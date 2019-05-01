Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FB1C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 07:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E5521743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 07:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556697326;
	bh=7heAbxShZwPDtiUOHAuKKx6ZF2CbLu54ecVI72nTBTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ezn/H5nci6MkRpHJ3qjc6SrRkCYzcTcuh3ifggX59ihMhHzMMIAcQTQbxsH+ioUZ7
	 hbkqv0J6NvzRnghzEHinCJmAx7qAn/DbbbL2WU3QoShatLLI8YomkOiK5+AAN1VTwp
	 l+xg+BsPYJp9taw1QsrbIjyMY13dwRHFpK6sT3gM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfEAHzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 03:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfEAHzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 03:55:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 115FA21734;
        Wed,  1 May 2019 07:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556697324;
        bh=7heAbxShZwPDtiUOHAuKKx6ZF2CbLu54ecVI72nTBTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FjMgTT4PuyYTyjyFTQ8I2ZDV4UhpKphQEZgAj+nSeCvuHcb6vdu1/QayUx+ldAomO
         dZgzZ9Yk1F2RWfi5deoplBYjDsmBChwvixGWEiizZPMF1nE4+Ae3e6e9Crly6F6Oxv
         AjAbLOCxp8PBf+xuY0+kIZDlN/v1EPi0cYHhpXoc=
Date:   Wed, 1 May 2019 09:55:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/89] 5.0.11-stable review
Message-ID: <20190501075522.GA15344@kroah.com>
References: <20190430113609.741196396@linuxfoundation.org>
 <cc6e90a5-8d67-62cf-8720-fd5cf5af45e2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc6e90a5-8d67-62cf-8720-fd5cf5af45e2@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:33:42PM -0600, shuah wrote:
> On 4/30/19 5:37 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.11 release.
> > There are 89 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu 02 May 2019 11:35:03 AM UTC.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.11-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all four of these and letting me know.

greg k-h
