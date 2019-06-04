Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD03FC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2D624ABC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559627430;
	bh=qyabw+QI3W1pUMAUFsWv+0ICU//HDk2k/J6gphOlGSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hbovXgKW7iJ9Zr3Jzh3hl5VrPLd8K2lbBzlB6JSCWB3P7Cr+Mwv2kEICuj6zxAk5d
	 081TGT1qEmOrtohm14CaS4xKYkZsYZF9fi+emgQoLwPxSfqY+5myLxuPhiyfrUqoBf
	 R3NuonkKKLaer8evEs3PCy9nSF45qfpvqPsbteEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfFDFua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 01:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFDFu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 01:50:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F5ED2064A;
        Tue,  4 Jun 2019 05:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559627429;
        bh=qyabw+QI3W1pUMAUFsWv+0ICU//HDk2k/J6gphOlGSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kDRURUmFOypkp2P3j+lBMad+gCMpqZrBCCI9dnXbCyBk/PR0LJtdpgKHh8MYEY6zM
         SWFpWhovEJY0Rll9SUYhYBDfFzke2ACsKlKh315fLkoV+IDRj66tMZR5zNlu7Fkb3X
         Rg0GrjzdhvjcLQSauBPmwrLFtzpWUP7Op09Yc1JA=
Date:   Tue, 4 Jun 2019 07:50:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.1 00/40] 5.1.7-stable review
Message-ID: <20190604055026.GC16504@kroah.com>
References: <20190603090522.617635820@linuxfoundation.org>
 <59b66e9f-69be-63a8-348a-9a24a1246dbf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59b66e9f-69be-63a8-348a-9a24a1246dbf@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 05:31:48PM -0600, shuah wrote:
> On 6/3/19 3:08 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.1.7 release.
> > There are 40 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed 05 Jun 2019 09:04:46 AM UTC.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.7-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.1.y
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
