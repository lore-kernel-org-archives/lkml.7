Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A954DC43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 17:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D302068D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 17:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574530570;
	bh=9TaLaPXh34WpmZLm4flETeo+9bKu74xq4C6i+n74E3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ACOe5OmcxzcZWcB1ZtNrDV2LzUY2NBORhPYPE9RpA6kDvhCUzj6DJtR7PJ+OjExTw
	 B9j1E6l390irtn7nRjq73IEy0Idj3SkxOJyVWgt4gq2W+0jV40m2xIe31n2wtpC5Yn
	 gr6mnzZKUBZ2UFJcPPTp14pL8U5FxnpS+9MwrWJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKWRgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 12:36:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:33298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbfKWRgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 12:36:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E0772067D;
        Sat, 23 Nov 2019 17:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574530567;
        bh=9TaLaPXh34WpmZLm4flETeo+9bKu74xq4C6i+n74E3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wUpoagCWCLQkBP1WrY9NB7hmFIVvjAmLeZV1iOiuiGDp56govRgh4M7unypMXqitF
         IvLvSEXb2onaH8VpscO9mtxao08hGb/DKgcsHABmYGz9fF5cssg4qhHgLR3rb8pr3b
         D0y9btNygTOADLD9cVA9+VaxhNRl5yvtL1Yf2FQw=
Date:   Sat, 23 Nov 2019 18:36:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.3 0/6] 5.3.13-stable review
Message-ID: <20191123173605.GB2188842@kroah.com>
References: <20191122100320.878809004@linuxfoundation.org>
 <30001ff5-2c8b-49e4-bc41-a43e0284df2c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30001ff5-2c8b-49e4-bc41-a43e0284df2c@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 01:45:05PM -0700, shuah wrote:
> On 11/22/19 3:30 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.3.13 release.
> > There are 6 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 24 Nov 2019 09:59:19 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.3.13-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.3.y
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
