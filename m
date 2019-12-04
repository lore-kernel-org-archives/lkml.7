Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9721C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A178E2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575458981;
	bh=i8PGKJFkZ0p8Bhydo4YK4a99qPDQstolTjL5vPdYd5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sKuqC94f1Ss7gGUw1UgdxZtTCcUPBGQA7sLH7OruGZTfdYrU+a5XbpMNBJFZXU2Os
	 H9j9/lve8ROVkFLB7qkjrI9kDULf5wmNi2y3H74zhcHRJWPWHySu/ZPGRTGYimVP/C
	 oU4A5oZDZcUViSjBO6bzBcPhvFstOIQHHOlIj3SQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfLDL3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:29:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbfLDL3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:29:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0178A20637;
        Wed,  4 Dec 2019 11:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575458979;
        bh=i8PGKJFkZ0p8Bhydo4YK4a99qPDQstolTjL5vPdYd5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7vAley61mEi18IJH+HCmxX/nyifLJpM45HEkhMpmKHcPaP2fJ+6eGejG09hkt6I4
         Ue808TzYLW2FpBrRkO9cgYFMmCC0SHEZoO2NxWJhuhUgYrN+xuD7KKzHIDXtqTF0ZU
         4VaeOKZ3FuhB1UhIeie/ZSn1V9PLw3Bveo9NK18M=
Date:   Wed, 4 Dec 2019 12:29:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.19 000/321] 4.19.88-stable review
Message-ID: <20191204112936.GA3565947@kroah.com>
References: <20191203223427.103571230@linuxfoundation.org>
 <79c636e7-145b-3062-04a3-f03c78d51318@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79c636e7-145b-3062-04a3-f03c78d51318@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 09:45:31AM +0000, Jon Hunter wrote:
> 
> On 03/12/2019 22:31, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.88 release.
> > There are 321 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 05 Dec 2019 22:30:32 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.88-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > -------------
> > Pseudo-Shortlog of commits:
> 
> ...
> 
> > Ding Tao <miyatsu@qq.com>
> >     arm64: dts: marvell: armada-37xx: Enable emmc on espressobin
> 
> The above commit is causing the following build failure for ARM64 ...
> 
>   DTC     arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtb
> arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtb: ERROR
> (phandle_references): /soc/internal-regs@d0000000/sdhci@d0000: Reference
> to non-existent node or label "sdio_pins"
> 
> arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtb: ERROR
> (phandle_references): /soc/internal-regs@d0000000/sdhci@d8000: Reference
> to non-existent node or label "mmc_pins"

Thanks for letting me know, I'll go drop this one and push out a -rc2
with that removed.

greg k-h
