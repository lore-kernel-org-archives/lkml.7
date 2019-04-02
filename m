Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253AEC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF430208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554203362;
	bh=21gOgJL31mpwnK0w4o58sKiV0S0wL68al/tOKrbJInY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gX4Nl/a8Dl9ZJ+bfKYE7UyBq3QPFtZrAtgKzdgn3LgqkUcNPkQrehoW5uPTtJ41iP
	 TyLz7bJkk8rC4A/I75DWmKfyIfMwn5lRJVSkwI74lML38FQRURX1fPndPkFdkZtRJq
	 djIBSkMO0tMQzgUsQeGEQd8zAYlRddwTZNEJrOD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfDBLJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:32940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbfDBLJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:09:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822E620857;
        Tue,  2 Apr 2019 11:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554203360;
        bh=21gOgJL31mpwnK0w4o58sKiV0S0wL68al/tOKrbJInY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FgSFE9PuvtHWuVMzlnW+j3ZLehyMVkZmzH1zznTOQP2L4lYuRgmOwnM2ccFEuEDEU
         Vap+1R/Q+ud13nhyJVF25uOI0pXqiQRuHAw5PtyXaFtuee/p5rnkOTvDVDBeCkXciH
         4pye39lhnLSMG0LJ8QFY3/UurVQ/j16ZNflVI7H4=
Date:   Tue, 2 Apr 2019 13:09:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.0 000/146] 5.0.6-stable review
Message-ID: <20190402110917.GA18896@kroah.com>
References: <20190401170048.449559024@linuxfoundation.org>
 <a109b148-2523-dd77-6aa0-35faec9e925c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a109b148-2523-dd77-6aa0-35faec9e925c@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:04:25AM +0100, Jon Hunter wrote:
> 
> On 01/04/2019 18:00, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.6 release.
> > There are 146 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Apr  3 16:59:21 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.6-rc1.gz
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
> Linux version:	5.0.6-rc1-g7505a89
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra194-p2972-0000, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04
> 

Thanks for testing all of these and letting me know.

greg k-h
