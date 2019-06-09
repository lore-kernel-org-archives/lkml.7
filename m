Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F039C468BE
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 07:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25612145D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 07:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560064498;
	bh=6+qDS6a27M+gHvNge6uqRZiZ7nKkkoO+sK9oyT3xtk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GfprPLVb62VKenV76Q6LhJnzC3Kmaq90dRUuklEwjL8oGnl2Ldi/2X5BYunqcQ62R
	 OjrjwiTWC20maRLCKArrtavhRjq8s4Vk8omVavUKdSUfPmLhPEzSgdvj8Uq141vocZ
	 xPCNeVlR71g/LMpOMzCJeurJylzRy33VsPV1mn3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfFIHO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 03:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfFIHO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 03:14:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 802B7208C0;
        Sun,  9 Jun 2019 07:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560064496;
        bh=6+qDS6a27M+gHvNge6uqRZiZ7nKkkoO+sK9oyT3xtk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7l5y+qi8+2J+UMHnhGnOr2cwD/+RFkefDrCgv4Tu1JOvRMS1CP4FP0u5M7Sc55l7
         bOzcQG6zQyVybOMLi3mMaNzXJlCATSoNO+yXzJ2xZbQoEXljVqTomcV71oFEEYoZfW
         uCXftF9I2BOU82eib63Hof6IYYRq0HXsMdQB8nSQ=
Date:   Sun, 9 Jun 2019 09:14:53 +0200
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
Subject: Re: [PATCH 4.14 00/69] 4.14.124-stable review
Message-ID: <20190609071453.GA4565@kroah.com>
References: <20190607153848.271562617@linuxfoundation.org>
 <20190608093256.GD19832@kroah.com>
 <CA+G9fYsB52VKE1+z8eJvz-x-Nyq2E7DtOoCw6vJPH_0F7UiXNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsB52VKE1+z8eJvz-x-Nyq2E7DtOoCw6vJPH_0F7UiXNg@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 12:36:23AM +0530, Naresh Kamboju wrote:
> On Sat, 8 Jun 2019 at 15:03, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jun 07, 2019 at 05:38:41PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.14.124 release.
> > > There are 69 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Sun 09 Jun 2019 03:37:08 PM UTC.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.124-rc1.gz
> > > or in the git tree and branch at:
> > >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > > and the diffstat can be found below.
> >
> > -rc2 is out, to hopefully resolve the btrfs 32bit build failure:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.124-rc2.gz
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.
> 
> NOTE:
> selftest sources version updated to 5.1
> Following test cases reported pass after upgrade
>   kselftest:
>     * bpf_test_libbpf.sh
>     * net_ip_defrag.sh
> Few kselftest test cases reported failure and we are investigating.
> 
> LTP version upgrade to 20190517

Great, thanks for testing!

greg k-h
