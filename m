Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC620C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B762146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552997853;
	bh=gALs++vLfXzQJ0kih1kMRpMvCvqrwq/yH6odm6Y200E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ldq+NPLH74q37pmkLKgl3N51EcZ9P8gxn9z4U29Ca2LhZuW5fK89NHWQTK7lGzBQq
	 gdbF1A2zEq1pIgiWGMe051opk2tfOd9AsUOy/oyCBKwdhHdhWlnVXm0m7ePiC1V1u2
	 77k0nVsNBaEioqlvNbFTcnd12sealP9Ac6ShLz8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfCSMRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbfCSMRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:17:31 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9A42133D;
        Tue, 19 Mar 2019 12:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552997850;
        bh=gALs++vLfXzQJ0kih1kMRpMvCvqrwq/yH6odm6Y200E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ll7fQhapJvBF2CknvZRo0EXUKKCT3NoX14usM28WibViix4rA1P3Xw0iSwUDN9wLd
         +raYMDxfCMjAjj03nR6WPSuAvzXb8BMijIOdnDeJ6P6S8WKUc9zvQgVOa42yj5luKk
         Onw6Tkz425P+PHPCZQF27BiiXdQ6Fof8334EOSPA=
Date:   Tue, 19 Mar 2019 13:17:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.0 00/43] 5.0.3-stable review
Message-ID: <20190319121728.GA29446@kroah.com>
References: <20190318083715.877441740@linuxfoundation.org>
 <e52e9d95-2178-c3a0-949f-5397b70276b1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e52e9d95-2178-c3a0-949f-5397b70276b1@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:34:58AM +0000, Jon Hunter wrote:
> 
> On 18/03/2019 09:23, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.3 release.
> > There are 43 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 20 08:36:53 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.3-rc1.gz
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
> Linux version:	5.0.3-rc1-gec6582f
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra194-p2972-0000, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04

Thanks for testing all 5 of these and letting me know.

greg k-h
