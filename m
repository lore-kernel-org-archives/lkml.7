Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE58C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0AD2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553648172;
	bh=SxQEP5LpnnFU1PHlC3JV7DL+8k591IhoUg3PDewelkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vYP6HyzuZW0GKA/fEEybqSj1hHRsSy1kN6ISfuTBW9WSktl7pw2Aao6GyQMNlDbhQ
	 iKrR8SZ+9QHtw46FfgzT1CXxPk4f6b0M3/TGO7A8AulPpcEYCpkcItpucG60XYFsHO
	 NTfujxSqVEb4uZSlykyClogEkl2JDV34eKWbVXns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbfC0A4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfC0A4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:56:11 -0400
Received: from localhost (mobile-166-137-177-030.mycingular.net [166.137.177.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62B792082F;
        Wed, 27 Mar 2019 00:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553648170;
        bh=SxQEP5LpnnFU1PHlC3JV7DL+8k591IhoUg3PDewelkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0REF2E20S6qfp0bBI0oZBaiKu+Rfgy2kA4J6wFom82QGSPq7pytCVX1OEEiu5SnFC
         n+RRjazN2XVNs+n4K8hN/Vt76vYHRrX++3Ou9QBft00j0O43TUUL99eqwRZrpfs6pk
         dUSpj7d+qnY9afC8mtd5PPGhKpMorrMHa0b2ztFo=
Date:   Wed, 27 Mar 2019 09:56:05 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.0 00/52] 5.0.5-stable review
Message-ID: <20190327005605.GB29485@kroah.com>
References: <20190326042700.963224437@linuxfoundation.org>
 <c72ed127-da73-27d5-dd84-259897a3181c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c72ed127-da73-27d5-dd84-259897a3181c@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 03:20:22PM +0000, Jon Hunter wrote:
> 
> On 26/03/2019 06:29, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.5 release.
> > There are 52 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Mar 28 04:26:38 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.5-rc1.gz
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
>     28 tests:	28 pass, 0 fail
> 
> Linux version:	5.0.5-rc1-gebcb1bb
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra194-p2972-0000, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04
> 

Wonderful, thanks for testing all of these and letting me know.

greg k-h
