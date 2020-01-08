Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221CEC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD85A20673
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578482260;
	bh=9eedaPIG/RcoRzKUdINlT24sZPom70kaScaV+oXhakQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aN4yi/7KMPaYto/Jcjvq725jEJ2Pgd/+xncmWVY42EGkTOe6uZWViNwjoxey1f+SN
	 y+affPuuytdPRlNTAz/RlLRzMRgGGASqEke/+JdgvARMs6Avy2FarBf+0ZgF9pmIQ8
	 btVkqE9zISHKYqwyD0+xl8F6aIITqQWYhdFaUgds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgAHLRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:17:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbgAHLRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:17:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DCAD2082E;
        Wed,  8 Jan 2020 11:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578482258;
        bh=9eedaPIG/RcoRzKUdINlT24sZPom70kaScaV+oXhakQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wPITPVnQmeAZAtR42evmAXlnLI+qYgdRR98CrMOcGZ0z62gPrueXXBvxRSRtmWdyQ
         IEkbCnKPOYbXVEVlT2ls1L/GjNKGiKJXDf7l7vZgJXybuVYz7/wFjtYL2z46/IiEZj
         C8Kkuo1DFWDrobUuTBOsy5Ra+ao10Y1Hr1jvhHx4=
Date:   Wed, 8 Jan 2020 07:41:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/191] 5.4.9-stable review
Message-ID: <20200108064102.GA2278146@kroah.com>
References: <20200107205332.984228665@linuxfoundation.org>
 <b8349973-564b-fdff-47db-9e5f06ad5e3a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8349973-564b-fdff-47db-9e5f06ad5e3a@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 07:37:56PM -0700, shuah wrote:
> On 1/7/20 1:52 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.9 release.
> > There are 191 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 09 Jan 2020 20:44:51 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.9-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for quickly testing all of these and letting me know.

greg k-h
