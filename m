Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117B0C00306
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D61320870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567714639;
	bh=88rFmXWI7MBUoGP0+3nqDbN1gaJhbK/2xLgp/HxpkNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=19zYWW8aIeXD4vWF8VVzC+doKw63jSnoTi6HCZ5N7m5FKXK7xqBLVhJLGB8771Xgi
	 8/nDgd9+Zo4TjBBF2nkiu8poT1qJZJrBk3pB/T0RwZu3ApOR6v0pRf/6GVOKw2cwO8
	 Bl1zinGOa7/95iOocA3qtVrh8cavbaTN2cGiNblw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389258AbfIEURS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731390AbfIEURR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:17:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63D3520825;
        Thu,  5 Sep 2019 20:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567714637;
        bh=88rFmXWI7MBUoGP0+3nqDbN1gaJhbK/2xLgp/HxpkNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0y7L7Owj4H7SP3QNjOF5qoBDyxH++4JgXJACgQMFN+mnR006h90o/xIL+wHZI6QDB
         t5iEpluZvmYxJBIeYczwu2zP68lyvIgd7QqP4ZHpTt4RK9QdRAZ9WwRowcGreehPgy
         HJaDgPjMjrLi4EmV+SpaXx/fQhBZDXalq3BbzX7g=
Date:   Thu, 5 Sep 2019 22:17:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.2 000/143] 5.2.12-stable review
Message-ID: <20190905201715.GA20849@kroah.com>
References: <20190904175314.206239922@linuxfoundation.org>
 <20190905195042.GB3397@JATN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905195042.GB3397@JATN>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 01:50:42PM -0600, Kelsey Skunberg wrote:
> On Wed, Sep 04, 2019 at 07:52:23PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.2.12 release.
> > There are 143 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri 06 Sep 2019 05:50:23 PM UTC.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.12-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Compiled, booted, and no regressions on my system.

Thanks for testing all of these and letting me know.

greg k-h
