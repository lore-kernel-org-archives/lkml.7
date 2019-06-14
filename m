Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E48C31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED6C21473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560491444;
	bh=BEtt4xgh4ST4Um0DEcMFTvf6xMAgWp1vIUQ4maN0Rfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q4QRd5Y1p9K1g/mAsVEOWZSin4HcGCPH6aTZmrSqSvtlsFsWo6pMOAZvkGKEM6GDg
	 xhnSaFJ5w2pdiSt53AKxc+N60JYrTiUfSN+281HpMw1orNoThrNor58rB0sPo1KJgL
	 kyVRjZPq6NI9wcUIa/TeYvVP1CuI6N+MWLzCSFxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfFNFun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfFNFun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:50:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC9E2133D;
        Fri, 14 Jun 2019 05:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560491442;
        bh=BEtt4xgh4ST4Um0DEcMFTvf6xMAgWp1vIUQ4maN0Rfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZsJ/LQlXV32EfGM+KBLGaWQlzi9Aty9cSmYXu5Gtxe2/DLXLgq3OV20E4YVV8i6Wt
         VODGwA8hIwB4Zn5ecKWi/PlSp0W+Vfwe46d+RynLuhvzgNYHtowBDIOEe0jqPMxtYj
         0pCdiLVRaZEylhhk9jTYWlHgDpfaF4Fw4eW5lcWo=
Date:   Fri, 14 Jun 2019 07:50:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiunn Chang <c0d1n61at3@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.1 000/155] 5.1.10-stable review
Message-ID: <20190614055040.GD27319@kroah.com>
References: <20190613075652.691765927@linuxfoundation.org>
 <20190613200849.veuc5crfejlcepgh@rYz3n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613200849.veuc5crfejlcepgh@rYz3n>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 03:08:49PM -0500, Jiunn Chang wrote:
> On Thu, Jun 13, 2019 at 10:31:52AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.1.10 release.
> > There are 155 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat 15 Jun 2019 07:54:40 AM UTC.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.10-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.1.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > -------------
> Compiled and booted.  No regressions on x86_64.
> 
> This is for 5.1.10-rc2 from git --no-pager log --oneline -1.

What do you mean by 'git --no-pager log --oneline -1' ?

thanks for testing,

greg k-h
