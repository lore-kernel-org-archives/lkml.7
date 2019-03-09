Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48B6C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 06:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD1A2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 06:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552114397;
	bh=4EIdBNPUq+7Rii3au8Uv0dQAqXQErAGsmaFUaG+m2h4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2ZCrqXnp1T6S0rO1FPOxcdQZhcLSLkrt1qM74QrRnKCCHl6s9eePgeyiOL1vcSbKW
	 xeA5hZatjacYqhqjO/8QynZlK2rtTFmhEKloQfPyZuEPG4idaA9QxEP+PuiMf6uEG7
	 xgbCIitROCik3JNUgIb88ec33ytxDNoqswhEtwR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfCIGxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 01:53:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfCIGxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 01:53:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F459207E0;
        Sat,  9 Mar 2019 06:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552114391;
        bh=4EIdBNPUq+7Rii3au8Uv0dQAqXQErAGsmaFUaG+m2h4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=le1PhSAs2KcsWXRR/FFe0ieS8BMp716TdjF2+EKRpEH5gg/KtIYZ9+muBeW4/qIrR
         sw+3jOZQv6IpXh9qDDFwF1/EzAr5c07Lrhw7gSLQYCK/MIPhjirkPHITr3nEswjOsz
         07KDuPds/KL/5o2fjBdZnr+p050+guZWBBeH+Xms=
Date:   Sat, 9 Mar 2019 07:53:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/46] 5.0.1-stable review
Message-ID: <20190309065309.GA498@kroah.com>
References: <20190308124902.257040783@linuxfoundation.org>
 <6bdc650c-9f51-2467-aa32-f30c73768d10@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bdc650c-9f51-2467-aa32-f30c73768d10@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 01:58:36PM -0700, shuah wrote:
> On 3/8/19 5:49 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.1 release.
> > There are 46 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar 10 12:48:36 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.1-rc1.gz
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

Thanks for testing all three of these and letting me know.

greg k-h
