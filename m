Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF248C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D642171F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552064718;
	bh=63gFuTE4rUH1oR9uIA3aLjuc449EDhqBR4zv5igDJ/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=07pChUde1IAlKmJ5aMudKAtHhDI7JcwJnTGgui0CljW+FSeU25nK0V17zNO1G+gKz
	 V7QUjSVfij29OEODYqLGalHLqqdMPG0XNxqsyN23biBPzNKJ6AiVx73bc6xUDqEXzm
	 aQA2ndz/SsAfJ/NTbu36UpaBF5pPNgbZoW8TbiOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfCHRFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:05:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfCHRFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:05:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC782147A;
        Fri,  8 Mar 2019 17:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552064713;
        bh=63gFuTE4rUH1oR9uIA3aLjuc449EDhqBR4zv5igDJ/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BIA3c/qO32JgxGREWV/m0qXt2AQ+WsKNXYXIzDOVxNL3duIe3gIoGDnW1I766L73e
         VMPRYAgVtD4pYq3VL3HwnMMHX3OXkO3/2xLLJQGPAET7L4v1vH7d/H9GPOCp2wiUw2
         kLhcBMWp79eBBKf+aVp0CWoVNC67KMip/w48NIss=
Date:   Fri, 8 Mar 2019 17:35:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.0 00/46] 5.0.1-stable review
Message-ID: <20190308163514.GB12898@kroah.com>
References: <20190308124902.257040783@linuxfoundation.org>
 <e5695788-9ba4-5543-6f68-a99c7b972073@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5695788-9ba4-5543-6f68-a99c7b972073@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 04:06:19PM +0000, Jon Hunter wrote:
> 
> On 08/03/2019 12:49, Greg Kroah-Hartman wrote:
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
> All tests passing for Tegra ...
> 
> Test results for stable-v5.0:
>     11 builds:	11 pass, 0 fail
>     22 boots:	22 pass, 0 fail
>     28 tests:	28 pass, 0 fail
> 
> Linux version:	5.0.1-rc1-gbe3f501
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra194-p2972-0000, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04
> 

Wonderful, thanks for testing all 3 of these and letting me know.

greg k-h
