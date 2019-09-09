Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF14C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D714521920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568019742;
	bh=iWg5Zbyj/IVYCTFHJJ9TmCz/4IVIEKIjEN2VJ1mqKtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aXqrGYks3ZgtzpF4IvRmRnqWu9rm1orcxE7cUsOMI0uaAoZ6Tf3JdP3f7RTQQeRxA
	 jhAzBFxqaJt3FBtkUhWb7auphWPtWOzWFGsmewCpaP5J4uYqYP2VmDAQhwI4msbcjT
	 Degyn4me1R2RxZag+DtvPxsicaF+zVnJY6RYKd5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbfIIJCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfIIJCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:02:21 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4222C2089F;
        Mon,  9 Sep 2019 09:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568019740;
        bh=iWg5Zbyj/IVYCTFHJJ9TmCz/4IVIEKIjEN2VJ1mqKtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KKm7XVw5mBryqlCrM9yzsCmJgFhzsfWnLyBUH1aLO+RMFtjtNj2Zedy8sWFrCGBXp
         LvVdpmVyUW2B9SIqRkhrbKmr728AbXBePAyppYlu62lQZbrW1KTVHhjAB2t0mLlqg5
         JaMvK8L51FQrG+HNtRLGTnJlqvDF1VEH4VCMfEps=
Date:   Mon, 9 Sep 2019 10:02:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 5.2 00/94] 5.2.14-stable review
Message-ID: <20190909090218.GA1970@kroah.com>
References: <20190908121150.420989666@linuxfoundation.org>
 <CA+G9fYuQzkppyLeS0zhoaZxnT8A4d9jyErN_ehFBQRwKLA8nXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYuQzkppyLeS0zhoaZxnT8A4d9jyErN_ehFBQRwKLA8nXA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 11:24:19AM +0530, Naresh Kamboju wrote:
> On Sun, 8 Sep 2019 at 18:19, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.2.14 release.
> > There are 94 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Tue 10 Sep 2019 12:09:36 PM UTC.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.14-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
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
