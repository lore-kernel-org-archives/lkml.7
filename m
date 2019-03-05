Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6927C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB65620842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551804714;
	bh=CrI+Z6z/uT+7oFYHXyzf3v/JPTdmGUO8rymLYjnaL5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vnXUDZEOugK7UAAYY+3Ywc1hnIp92bbveBx/1oYiuWVmZdFX20r95dBLdpBSTtgzb
	 1BHu6AmzrqqNjAx5J1oVU0euDKoCPEj5vdb4akzO7N0yLkwINsbLVgzIeCGgP3Ajcl
	 txfXPSqtH9Ug1nzIaCbM5kFW4RXw6QIL0JNmyAj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfCEQvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:51:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbfCEQvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:51:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC3B620661;
        Tue,  5 Mar 2019 16:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551804712;
        bh=CrI+Z6z/uT+7oFYHXyzf3v/JPTdmGUO8rymLYjnaL5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d/dAkuUfI6WIOKvIVEfqDC6qdQUgEalInlIIseKLofmtYfgf8k6MDMx1cXOIvSkHf
         ZteMqdtHSRGsQ243gpd3Q/cVR5SPmE21PR/pg7Y/VnoJUgs3lPDDdWtI6pgyHdsTjZ
         ycD7MOpEPPAWKVOZr2eVGQHEUGeLZG/mRKiLBqjg=
Date:   Tue, 5 Mar 2019 17:51:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.20 00/88] 4.20.14-stable review
Message-ID: <20190305165149.GA4502@kroah.com>
References: <20190304081630.610632175@linuxfoundation.org>
 <439e2754-1a8b-5950-78a4-30a3b983d645@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439e2754-1a8b-5950-78a4-30a3b983d645@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 09:20:12AM -0700, shuah wrote:
> On 3/4/19 1:21 AM, Greg Kroah-Hartman wrote:
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
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all of these and letting me know.

greg k-h
