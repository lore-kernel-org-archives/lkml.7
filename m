Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F58FC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3993D218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562145136;
	bh=7/M4xurAmMfi79ptyArfqLbkVVjjR+yLdkzHj67BgdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H2GBYmRNrJky/8v43bwRirl2riBAPBPsjP9FL5astf5B5RvTnx2+zLzoxkY9WZWne
	 uDRr64jFr4s/5hqPmHN/M15b96fN5v/LekEKFWnvlh4IRiICQPKtNo0IWFeY4mbbo4
	 xTc03A1Y2SWRJNxEI7tTonHKNqdQQz8WujjIgiAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfGCJMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbfGCJMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:12:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6EA92189E;
        Wed,  3 Jul 2019 09:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562145133;
        bh=7/M4xurAmMfi79ptyArfqLbkVVjjR+yLdkzHj67BgdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQ0sxPR7tD0P60E9Brn71NLTGsxyGzW0n6KNd66zJZNorh2+VHz8+HwZglhTSv7YX
         eYlZwkOTZC92gzBUCvIX7aKm7mMmhrOyv1hktJZl86kbmNDniBcM56LhOiLkKqglOM
         uRmxBZSYoP2G+eQwkQcaFPWiEoEKY9C46XG6LVBc=
Date:   Wed, 3 Jul 2019 11:12:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.1 00/55] 5.1.16-stable review
Message-ID: <20190703091210.GC12289@kroah.com>
References: <20190702080124.103022729@linuxfoundation.org>
 <82a59082-af68-51e7-49c7-62d1b45df18a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82a59082-af68-51e7-49c7-62d1b45df18a@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 04:56:24PM -0600, shuah wrote:
> On 7/2/19 2:01 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.1.16 release.
> > There are 55 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu 04 Jul 2019 07:59:45 AM UTC.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.16-rc1.gz
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

thanks for testing all of these and letting me know.

greg k-h
