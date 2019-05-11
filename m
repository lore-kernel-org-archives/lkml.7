Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42188C04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 05:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119482183F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 05:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557553752;
	bh=xKVDSaOBM/IHzgfxXmeikmxnt+gJyV4w3qYoxxPMRU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PxSsIsjMpbpoga9DM1IGD/4S8K3O4LDuUqpg1NCb9AfN303JFI9yb52OcHE0nIKFT
	 mSr0AaJdQssTACUZxhnXfOdag2U83LS7uT24RwORTt67wVLUe4BgElGMiSvnm+TAo2
	 +PNIgwY/rVpS8Yh68hs76Sk/E91Pg9d7rDrRYm4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfEKFtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 01:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfEKFtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 01:49:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACDE82173B;
        Sat, 11 May 2019 05:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557553750;
        bh=xKVDSaOBM/IHzgfxXmeikmxnt+gJyV4w3qYoxxPMRU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kCBiioyg1fpUlxZDPxXR3ShwWbR9HzuazwMcxJHNMUiWrxymc3752Zxt243eeK46C
         mdA07uGZEBO7jV615RUBfkfwMVn5wOLErNzFBOuzl+TGfNL7VMhCo03huiqT8IJEGe
         Rib1Z7jtf40rGC7Flh3Wsz2S/XymZBL14XaE6jUs=
Date:   Sat, 11 May 2019 07:49:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.1 00/30] 5.1.1-stable review
Message-ID: <20190511054907.GD14153@kroah.com>
References: <20190509181250.417203112@linuxfoundation.org>
 <c6179816-83d8-a12e-5bfb-256f23f835db@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6179816-83d8-a12e-5bfb-256f23f835db@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 03:14:08PM -0600, shuah wrote:
> On 5/9/19 12:42 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.1.1 release.
> > There are 30 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat 11 May 2019 06:11:35 PM UTC.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.1-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.1.y
> > and the diffstat can be found below.
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testingn all of these and letting me know.

greg k-h
