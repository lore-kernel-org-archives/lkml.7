Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90703C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2ED21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555499041;
	bh=g6/XRdG/GgPhhvIE36wHTN9QEXPDSurZzQp7WEo1+l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lnkVa/s//Unmueo8x3cCiX7/nVxSLE08Ps4B7p0UXxLtMUBNrxL3e8dmjnYwnG4Xr
	 4mP8g8FhNwKJisOqbzIU78DF/l0WC5l1wskRJmsKFIwcUJyzCvR91O/RP/1EgThLge
	 G/fK2qfVohVdWH/NH8M2TZFY4SkkIELUKcvTPNu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbfDQLEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:04:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729091AbfDQLD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:03:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E38F2064A;
        Wed, 17 Apr 2019 11:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555499038;
        bh=g6/XRdG/GgPhhvIE36wHTN9QEXPDSurZzQp7WEo1+l8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jxp0M3EKwESmo/WCEMyInexJ51dkATvbaF8CK83WjnG1QsxXQedpyGS/i/w+5ELwc
         pOBl6mw7Sd/gdlhLhjlycm7G6SZcq/Q09M6OKUmINm9VXeTwDjQblDKv6DvYnX73BM
         siRBD1+5tzEwFZa1IZIMRFu5nNUNq72xRLzrdmN8=
Date:   Wed, 17 Apr 2019 13:03:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.0 000/117] 5.0.8-stable review
Message-ID: <20190417110355.GA6878@kroah.com>
References: <20190415183744.887851196@linuxfoundation.org>
 <c3ff53a4-9d22-47b8-a385-e01229c43a0d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3ff53a4-9d22-47b8-a385-e01229c43a0d@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:34:44AM +0100, Jon Hunter wrote:
> 
> On 15/04/2019 19:59, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.8 release.
> > There are 117 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Apr 17 18:36:42 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.8-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> All tests are passing for Tegra ...
> 
> Test results for stable-v5.0:
>     11 builds:	11 pass, 0 fail
>     22 boots:	22 pass, 0 fail
>     30 tests:	30 pass, 0 fail
> 
> Linux version:	5.0.8-rc1-ge6fdfdb
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra194-p2972-0000, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04

Thanks for testing all of these and letting me know.

greg k-h
