Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F151EC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA63321D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576592889;
	bh=Q8bVM9pMyGgtsyZSstmA5doFuNh/I7GTxUPZed5Dkz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rroOd3ebfF0Ffv01JOLCuuNN18VEO1XclUnxGLIdlM5xYJCpH/kiFlQR+1wxB1Ntm
	 b4h2gEb9hjOAtsKdltw8w8BB+u2CavvG2IfOFBetLKkXH9atYDOkKlBsfkGDck8mzg
	 xiLkXei7x5K4bG8AlptRNottEh6oVMbupHoFiyOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfLQO2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbfLQO2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:28:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA6712176D;
        Tue, 17 Dec 2019 14:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576592888;
        bh=Q8bVM9pMyGgtsyZSstmA5doFuNh/I7GTxUPZed5Dkz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+c7D8E72V2zI6WXY55H/Guc7uh0dlc/JRJhRcq9VmYuMksYvJYXrSyEj5LFyAfpB
         oY9UTOwLKX8w+0FyQ0M3Sme9KLlQDZoJEgek54o6tHNfk4moQPTR9g1cJcPV76NR/Q
         uTri4/kEWwOfzdGVuwS6IpMVJxMPj9srR1GNXeAc=
Date:   Tue, 17 Dec 2019 15:28:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeffrin Jose <jeffrin@rajagiritech.edu.in>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/177] 5.4.4-stable review
Message-ID: <20191217142806.GA3624327@kroah.com>
References: <20191216174811.158424118@linuxfoundation.org>
 <20191217123732.GA3492@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217123732.GA3492@debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 06:07:32PM +0530, Jeffrin Jose wrote:
> On Mon, Dec 16, 2019 at 06:47:36PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.4 release.
> > There are 177 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 18 Dec 2019 17:41:25 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.4-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> 
> No new errors from "dmesg -l err" on a typical kernel configuration on my laptop.

Great, thanks for testing.

greg k-h
