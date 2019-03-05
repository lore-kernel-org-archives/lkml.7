Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D52CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB87E2087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551797762;
	bh=saI1egmzJgFr6tffi9eLp9iKPWiufiaMMFkudswxqLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hDbtr9N86f4NML745tNkyXoQX1BUEX7towQCr5xX4VHKNH7A4eyVM0MC3Xr8elQ6x
	 CNWP9q8AgkCGIxFLERGKkV5xDf4GnodSnIHrNhCuR1tZYmnzHrIZF3o8wFLrHdRGri
	 mt8CVw4wukXO8GTAJlMjFEFRc31mwCz0AD+6ncoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfCEO4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:56:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:58838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbfCEO4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:56:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2930F20842;
        Tue,  5 Mar 2019 14:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551797759;
        bh=saI1egmzJgFr6tffi9eLp9iKPWiufiaMMFkudswxqLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnAdfvZSeJr6N3DUa5Fce6ee5lE/FJSwJBYcHxmDq8gonjpiyHm35Sjh5EsiXESmc
         CfOR0zo3R7P16OL2hSDapgBEuweWhm1/78anD36clLR9IYhMpd8CR7uCzvORMsU8fS
         H+K/vkQF/IrYgCed6fgRk41WcGa+QYnUDN0bwb8I=
Date:   Tue, 5 Mar 2019 15:55:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.20 00/88] 4.20.14-stable review
Message-ID: <20190305145557.GC18959@kroah.com>
References: <20190304081630.610632175@linuxfoundation.org>
 <ece0a914-4b84-b832-757a-72583516c1f6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ece0a914-4b84-b832-757a-72583516c1f6@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 02:07:34PM +0000, Jon Hunter wrote:
> 
> On 04/03/2019 08:21, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.14 release.
> > There are 88 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar  6 08:16:03 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.14-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> All tests are passing for Tegra ...
> 
> Test results for stable-v4.20:
>     11 builds:	11 pass, 0 fail
>     22 boots:	22 pass, 0 fail
>     28 tests:	28 pass, 0 fail
> 
> Linux version:	4.20.14-rc1-ge260750
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra194-p2972-0000, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04
> 

Wonderful, glad these are all working for you, thanks for testing and
letting me know.

greg k-h
