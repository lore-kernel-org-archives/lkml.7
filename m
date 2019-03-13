Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD23C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761A82077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552510620;
	bh=5o2CRzapPXDkwn5x+wt2WSV3zaptoABhsPnUdfM0c7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LG0D8Fm8RjK0tnG3hXTHVWpnLX29pKZpIObVbAnck9esp9Mc4Am+9UVe/rdEVJqax
	 3oaUbUq0eJdxLr1LRS64Z+iFg2D/PgzReTcSczfqoorPH7i2HACtuTiF88cYlHJdcA
	 h0aUPifz3oRVviNJW8olGekrsoNw4gfThzEyH7GA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfCMU46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbfCMU44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:56:56 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF972146E;
        Wed, 13 Mar 2019 20:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552510616;
        bh=5o2CRzapPXDkwn5x+wt2WSV3zaptoABhsPnUdfM0c7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cXIt0mo/jZQ/CFBu3W7zR8GIOcuF07gC/s836CGKpwDtiitWqHlFhJ/stNcmeKpqU
         pokfuPQQAkjzryW/KYcadjpyzlfO5TSz08wV0zKHZrMknSLhjxxkKO1gdO3KrkvTr1
         pmKueIPP/iO17oYdr1ZrB8yE1gvY11uLMuLL42is=
Date:   Wed, 13 Mar 2019 13:56:55 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.20 000/171] 4.20.16-stable review
Message-ID: <20190313205655.GB5289@kroah.com>
References: <20190312170347.868927101@linuxfoundation.org>
 <CA+G9fYsiYKYuXMzBog_g+6-KdDk+CQo=Y533WFRkC-GceaQW-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsiYKYuXMzBog_g+6-KdDk+CQo=Y533WFRkC-GceaQW-g@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 05:24:09PM +0530, Naresh Kamboju wrote:
> On Tue, 12 Mar 2019 at 22:42, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.20.16 release.
> > There are 171 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu Mar 14 17:02:23 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.16-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing all of these and letting me know.

greg k-h
