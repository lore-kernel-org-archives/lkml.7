Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7561C742C7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E4C21019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562945440;
	bh=EVMg5JflGqnCcFb5fXBqaVk6snng9Gznig3mq8zUDME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qKS5WqSd8LgU2RRXnovHhDqBIoXgwagarBZKYC5cD/lM5UdgLzPiwIdhSkcEGlGu1
	 D+d7MtfeDe9qk1BQ7JVHWAQV/wXoE0hBZeJzciR+nie+/qTkDA1UnmEEjgEHzyGvF1
	 jSbVx6c3982mJnByWZ/9d0xuL6RBn1Tf3m+0Rbts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfGLPaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfGLPaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:30:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D267A208E4;
        Fri, 12 Jul 2019 15:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562945438;
        bh=EVMg5JflGqnCcFb5fXBqaVk6snng9Gznig3mq8zUDME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYERrKhiz3y88FQosuRkWix2hlsGWSLbVqu+RS6pj0TU7zcG8OsbQ+D0mzBvVXQFT
         N83AdpmF/DKbGyA6soWvGTtukeODIkDoyKnnKQGbXe9V5zl0DEGp6XvxyeB1X4JQhh
         G1W3Zzz4wosbAxzq6Gj7VgFx5Dj35MaGuz5atC+g=
Date:   Fri, 12 Jul 2019 17:30:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>, j-keerthy@ti.com
Subject: Re: [PATCH 5.1 000/138] 5.1.18-stable review
Message-ID: <20190712153035.GC13940@kroah.com>
References: <20190712121628.731888964@linuxfoundation.org>
 <4dae64c8-046e-3647-52d6-43362e986d21@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dae64c8-046e-3647-52d6-43362e986d21@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 02:26:57PM +0100, Jon Hunter wrote:
> Hi Greg,
> 
> On 12/07/2019 13:17, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.1.18 release.
> > There are 138 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun 14 Jul 2019 12:14:36 PM UTC.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.18-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.1.y
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
> > Keerthy <j-keerthy@ti.com>
> >     ARM: dts: dra71x: Disable usb4_tm target module
> 
> ...
> 
> > Keerthy <j-keerthy@ti.com>
> >     ARM: dts: dra76x: Disable usb4_tm target module
> 
> The above commits are generating the following compilation errors for
> ARM ...
> 
> Error:
> /dvs/git/dirty/git-master_l4t-upstream/kernel/arch/arm/boot/dts/dra71x.dtsi:15.1-9
> Label or path usb4_tm not found
> 
> Error:
> /dvs/git/dirty/git-master_l4t-upstream/kernel/arch/arm/boot/dts/dra76x.dtsi:89.1-9
> Label or path usb4_tm not found
> 
> After reverting these two, I no longer see these errors.

Both are now dropped, thanks.  I'll push out a -rc2 with that changed.

greg k-h
