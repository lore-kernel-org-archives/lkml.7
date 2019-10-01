Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CE3C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 06:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A9C21783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 06:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569910708;
	bh=jbp/MLpwN2lZoF630V6dSMCIA+UTTvZviD1YXwxupzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C73HUkguItOpSMmtZwFRjskHa/KNvW08S0pIfN1fxeudL6LyZ66X3p8OVrNeZPSEy
	 +86/EQPGXaqVMk0tiIb/lPNx966oKbSjbu3KV4UDuOfRDdq5LwzpxteRuE2CjnBuh8
	 ieKWno6dRbzPM/ZVKsQuk4zImcqEIsBTnEiNBpX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbfJAGS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 02:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732622AbfJAGS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 02:18:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6672D215EA;
        Tue,  1 Oct 2019 06:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569910706;
        bh=jbp/MLpwN2lZoF630V6dSMCIA+UTTvZviD1YXwxupzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NzYMQ7pa/tZC1FbAf5C/QkSJO9Zjv7p9fVThAF4nnfhI8ZaSsh8G9G8bF4hYYZzn7
         i0LRRON1uaRoW299rXYCmGVBl1xtLi9CdTGwS/625JcGe5Mapsb+yZowXDVkCemDEF
         H0ZWhx+a0r5aE9+QV1QA+RqMoqMjZsD3WWSK88NE=
Date:   Tue, 1 Oct 2019 08:18:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.3 00/25] 5.3.2-stable review
Message-ID: <20191001061824.GA2815916@kroah.com>
References: <20190929135006.127269625@linuxfoundation.org>
 <519f66ea-9cd5-b151-3383-b1331c710b42@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <519f66ea-9cd5-b151-3383-b1331c710b42@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 04:31:51PM -0600, shuah wrote:
> On 9/29/19 7:56 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.3.2 release.
> > There are 25 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Tue 01 Oct 2019 01:47:47 PM UTC.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.3.2-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.3.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all of these and letting me know.

greg k-h
