Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D28FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AF52146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552510593;
	bh=bzjXKBlNeC+dzl/y4sCU+vJCxDexCyWHhGBuaK8yupg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RTJU8ZQsLDoQHLm5LGExFvJ3sd6/BvAWkneYEl0DDO6HTw38DD6RIwSFy7DsfJjYr
	 +pq/+49whun1odyEXq89J/yusqCYC+En/I3QlHO6OLD0TutQ7e9SR+tiE1SA81//Iz
	 p5LT+MRVOGogywrV8N/7O1WUvY94iA9SCWlGYPZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfCMU4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfCMU4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:56:31 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71CBA2077B;
        Wed, 13 Mar 2019 20:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552510590;
        bh=bzjXKBlNeC+dzl/y4sCU+vJCxDexCyWHhGBuaK8yupg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hHA7n7NSip27AhPesQFK0VkG2vs1bJ/c6gPaCMVMhEx/2/SjlEvxIP1wE1dJuD2eO
         Ppt1XKLN6LQpI1RNcaTyqlRGc72VxRzEFicuIWLLkU5AzCDWdFUo0+UoLuHysHyppa
         MD2tKHU/edzR9YY6efsSx8JLpE//zEwtfmzyQ0Po=
Date:   Wed, 13 Mar 2019 13:56:30 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.20 000/171] 4.20.16-stable review
Message-ID: <20190313205630.GA5289@kroah.com>
References: <20190312170347.868927101@linuxfoundation.org>
 <d74f9989-6fa5-f8bb-258e-32f6cd2b11d2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d74f9989-6fa5-f8bb-258e-32f6cd2b11d2@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 05:36:36PM +0000, Jon Hunter wrote:
> 
> On 12/03/2019 17:06, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.16 release.
> > There are 171 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Mar 14 17:02:23 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.16-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> All tests passing for Tegra ...
> 
> Test results for stable-v4.20:
>     11 builds:	11 pass, 0 fail
>     22 boots:	22 pass, 0 fail
>     28 tests:	28 pass, 0 fail
> 
> Linux version:	4.20.16-rc1-gdcd2fdc
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra194-p2972-0000, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04
> 

Thanks for testing all of these and letting me know.

greg k-h
