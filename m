Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D52BC282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC1821479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555771279;
	bh=pTno6LasJNHvkuWzGrGs4UGh1vgXY+qZzjBQRhOdERw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ElgAvO0NL+aYj94u9nLujtep9u3KSB7kfCsjOWtGg0Vwuvq3lSwxlza4ScubYWa6t
	 suJr70sj2DQnynvS3B60GtDNxRK/mVsnG9JsY53geCWO9rKKFKq7ZHjExxKtV8MGQI
	 R/gLs4FovdTJBTjvspzPkEeUiGqlKhqEno82ucyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfDTOlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 10:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDTOlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 10:41:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ECE82087F;
        Sat, 20 Apr 2019 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555771276;
        bh=pTno6LasJNHvkuWzGrGs4UGh1vgXY+qZzjBQRhOdERw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RIIjeXKvX5WiJirIt/mXWiH988q5SsuI18e5f0FAmvfr2LVXIkGrJkWpK5nOAR175
         q8DhLqjktFYGTvi96J/sYv9Hwtm94gyR39zbeFa94QxrC0hPCqjWXB8XnuRgCbTH5m
         eCGla1BlwYDFZBDj9oK6eczeiLg/L2nlAjFhSvxE=
Date:   Sat, 20 Apr 2019 16:41:14 +0200
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
Subject: Re: [PATCH 5.0 00/93] 5.0.9-stable review
Message-ID: <20190420144114.GB12442@kroah.com>
References: <20190418160436.781762249@linuxfoundation.org>
 <CA+G9fYvS1-6Br-vxZ1VJQc2Bo3TSXLWwG8mCsV_LPq+3CNKkpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYvS1-6Br-vxZ1VJQc2Bo3TSXLWwG8mCsV_LPq+3CNKkpw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 10:22:32AM +0530, Naresh Kamboju wrote:
> On Thu, 18 Apr 2019 at 23:40, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.0.9 release.
> > There are 93 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat Apr 20 16:03:33 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.9-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing these and letting me know.

greg k-h
