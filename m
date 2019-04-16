Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABB9C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C898B20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555446469;
	bh=BIVxOInWBhvFY+0sBypM8aHx51zctQEPdCdcZsK5o8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=03+FEOoRKkpOohBa0ezkAfBh4sBxopjLkxK07eqxa4AFn7GSYQwC5l3YfWdHmptIn
	 MH1fkaS/xvvQmBQflcJ7xdg1X7CR/IYN/7AxfB31MXgGIosKjRzaxEMMbcyFvbP6bd
	 v3phTytPR3GgixOpOVppx8n/cmaI8AoD3bJmPUyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfDPU1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfDPU1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:27:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C3F720663;
        Tue, 16 Apr 2019 20:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555446467;
        bh=BIVxOInWBhvFY+0sBypM8aHx51zctQEPdCdcZsK5o8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dT3q1uH1X6W60qNWzTxbJzGMf0nuVPZIyPky86e7pPOAWY1vlBsGVo2/M4eZNmkmz
         0b6ipsvXhSDiytYiJKjiT0xZaY9Bdnne63KlFZoqcPb8+9kAZ+VpqykYzWODBA6TVE
         Copg/TEmfKnMTApUOkGvc7qD1qAfmJLK4YTSXQT8=
Date:   Tue, 16 Apr 2019 22:27:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/76] 4.9.169-stable review
Message-ID: <20190416202744.GA12533@kroah.com>
References: <20190415183707.712011689@linuxfoundation.org>
 <20190416162935.GA22656@roeck-us.net>
 <20190416184600.GB6253@kroah.com>
 <20190416201913.GA25517@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416201913.GA25517@roeck-us.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 01:19:13PM -0700, Guenter Roeck wrote:
> On Tue, Apr 16, 2019 at 08:46:00PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Apr 16, 2019 at 09:29:35AM -0700, Guenter Roeck wrote:
> > > On Mon, Apr 15, 2019 at 08:43:24PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.9.169 release.
> > > > There are 76 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Wed Apr 17 18:36:37 UTC 2019.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > Build results:
> > > 	total: 172 pass: 165 fail: 7
> > > Failed builds: 
> > > 	<all parisc>
> > > Qemu test results:
> > > 	total: 320 pass: 304 fail: 16
> > > Failed tests: 
> > > 	<all parisc>
> > > 
> > > Build failures as already reported.
> > 
> > I should have those build failures fixed.
> > 
> 
> I didn't rebuild the other images, but parisc build and boot tests
> are now fine (with v4.9.168-78-g6ecae2ce7b5a).

Wonderful, thanks for testing this, and all of the others.

greg k-h
