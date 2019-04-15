Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B622C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3091120880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353595;
	bh=+wKFBQXD0I7Vp70cs77EWtPvqRXfwTEoMiMBIuFToXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S/QGEpJRFy43w0cr6ay0iD1Y1HKy3AsCqxGvvCR+41Irn9fLp+8RwVef29p+GNDVW
	 l1Cz2RydhTTYWYo+ePR28RijcLXgfJLmb9Z4/ALVuik45Xt2nfefF5tgZNr0QjCKPI
	 ri2cAXPO81gcNbyT+sn2mX9kzfVhlfGU2sPMXSGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfDOSjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbfDOSjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:39:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6DDA2087C;
        Mon, 15 Apr 2019 18:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353593;
        bh=+wKFBQXD0I7Vp70cs77EWtPvqRXfwTEoMiMBIuFToXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rpizZuzdN6NUZktSCsfIYCh4gh/P1xwpBBEdo8bWwqG81EZpz2JLWUpD0c8Vii7GA
         Ix0vzhGF83VB8HpYX4m0GQhLzv9dkQPO0Qf8Ujn/Yfrr0qide3glJ4W9NDODqqWIBn
         ZCmgzwkT02l95QkhWUfeM6APaVSP57Q6UFShODVU=
Date:   Mon, 15 Apr 2019 20:39:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.0 000/246] 5.0.7-stable review
Message-ID: <20190415183950.GC7423@kroah.com>
References: <20190404084619.236418459@linuxfoundation.org>
 <f3b2926a-657a-f003-8e00-217d8cfb8f49@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3b2926a-657a-f003-8e00-217d8cfb8f49@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 09:01:41AM -0600, shuah wrote:
> On 4/4/19 2:45 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.7 release.
> > There are 246 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Apr  6 08:44:36 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.7-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
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
