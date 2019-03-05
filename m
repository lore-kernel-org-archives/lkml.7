Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C150C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50D820842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551772712;
	bh=tMAPtGIB1bCqNaxNUGDowNjRdjUY9eJHsxZWwAPRPxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eRLcf9tE3c8vsIgKotFPGx0QkSTDWAs8HzjOyU0NFxbJkxR457dmcCeYr1GGX+iC0
	 jMfHyq9fGmHFIXeeDOcMV7cLJCZkbPiAJB4fA21HJMU0LGZr6YOKRalORgIS90j4Fq
	 FRDiVNljXnOhuUVVX3kvlc1H9zC9/ohgj/NFIc2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfCEH6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:58:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfCEH6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:58:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EDC720675;
        Tue,  5 Mar 2019 07:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551772710;
        bh=tMAPtGIB1bCqNaxNUGDowNjRdjUY9eJHsxZWwAPRPxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NeP/u0WBD+BxO8E2Qu/pnKhpyLbfugePxq0T3JylIWkwuL3G2Jg8dsTxSbVvkLMxH
         WcgFiAfOUg+enVv+TdLAZneePq7yZNNwv9KUat7m5vFtjyUBiwQ3KDPhd31OnHhdq7
         AG4cVgi2qcm448N0WLeRAX8Vsy5mGTGqhnrSAr84=
Date:   Tue, 5 Mar 2019 08:58:28 +0100
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
Subject: Re: [PATCH 4.20 00/88] 4.20.14-stable review
Message-ID: <20190305075828.GA5726@kroah.com>
References: <20190304081630.610632175@linuxfoundation.org>
 <CA+G9fYueBwOic8sV6tVZzejQw0vFUeJJdyPHefCfDg2AmykCxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYueBwOic8sV6tVZzejQw0vFUeJJdyPHefCfDg2AmykCxA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 02:06:11AM +0530, Naresh Kamboju wrote:
> On Mon, 4 Mar 2019 at 14:02, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.20.14 release.
> > There are 88 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Mar  6 08:16:03 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.14-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Wonderful, thanks for testing all of these and letting me know.

greg k-h
