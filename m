Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1599C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6480620449
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m59KHU11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfESRtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:49:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45932 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbfESRtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WkSri6KdzdPoSDtpcQbCQ546W7rQSzg2uVsaczN2X7g=; b=m59KHU1154ZMkq7fBg+iRMZFYl
        VMPbpWyTtNDy7o/EAfkA3x3q5oZUMhBOjOnebDji8P0qGLpQrV+WHlsKcd4wYsZ1LBQGjoIXfoBXy
        Gn7R9Vd4Jm54uGE2JKNyrpYgYhY/e6HUFMY/jA5HXvAv4O1Nbut2Hv3ENKQK8FbQMTpcJB3GlfMT1
        1HT3xfli1JuDht4koR+DTA1cuoEtS393JX9P1i/hQbCYNE1VF3FgpzgOPzFSNxa5pjOuSJF3hV4ha
        4t+PTojt3ZBzhO3zO/kkan/HgFUgMfV0vuMY2ihMqXQZKnQ5WVR27Oce4FBdUiDioJzMmHIA/iDD6
        b/dVNRAw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSBkN-0006UP-PD; Sun, 19 May 2019 02:40:24 +0000
Subject: Re: drivers/soc/Kconfig:23: 'menu' in different file than 'menu'
To:     kbuild test robot <lkp@intel.com>,
        Patrick Venture <venture@google.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
References: <201905171226.xchw0NQ2%lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <777141e2-4aff-cc89-0258-cc933a485bed@infradead.org>
Date:   Sat, 18 May 2019 19:40:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905171226.xchw0NQ2%lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/19 9:40 PM, kbuild test robot wrote:
> Hi Patrick,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0d74471924f2a01dcd32d154510c0500780b531a
> commit: 524feb799408e5d45c6aa82763a9f52489d1e19f soc: add aspeed folder and misc drivers
> date:   3 weeks ago
> config: xtensa-allyesconfig
> compiler: xtensa-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 524feb799408e5d45c6aa82763a9f52489d1e19f
>         GCC_VERSION=8.1.0 make.cross ARCH=xtensa  allyesconfig
>         GCC_VERSION=8.1.0 make.cross ARCH=xtensa 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/soc/Kconfig:23: 'menu' in different file than 'menu'
>>> drivers/soc/aspeed/Kconfig:1: location of the 'menu'
>>> drivers/Kconfig:233: 'menu' in different file than 'menu'
>>> drivers/soc/aspeed/Kconfig:1: location of the 'menu'
>    <none>:34: syntax error
>>> drivers/Kconfig:2: missing end statement for this entry
>    make[2]: *** [allyesconfig] Error 1
>    make[1]: *** [allyesconfig] Error 2
>    make: *** [sub-make] Error 2
> --
>>> drivers/soc/Kconfig:23: 'menu' in different file than 'menu'
>>> drivers/soc/aspeed/Kconfig:1: location of the 'menu'
>>> drivers/Kconfig:233: 'menu' in different file than 'menu'
>>> drivers/soc/aspeed/Kconfig:1: location of the 'menu'
>    <none>:34: syntax error
>>> drivers/Kconfig:2: missing end statement for this entry
>    make[2]: *** [oldconfig] Error 1
>    make[1]: *** [oldconfig] Error 2
>    make: *** [sub-make] Error 2
> --
>>> drivers/soc/Kconfig:23: 'menu' in different file than 'menu'
>>> drivers/soc/aspeed/Kconfig:1: location of the 'menu'
>>> drivers/Kconfig:233: 'menu' in different file than 'menu'
>>> drivers/soc/aspeed/Kconfig:1: location of the 'menu'
>    <none>:34: syntax error
>>> drivers/Kconfig:2: missing end statement for this entry
>    make[2]: *** [olddefconfig] Error 1
>    make[1]: *** [olddefconfig] Error 2
>    make: *** [sub-make] Error 2
> 
> vim +23 drivers/soc/Kconfig
> 
> 5d144e36 Andy Gross        2014-04-24  22  
> 3a6e0821 Santosh Shilimkar 2014-04-23 @23  endmenu
> 
> :::::: The code at line 23 was first introduced by commit
> :::::: 3a6e08218f36baa9c49282ad2fe0dfbf001d8f23 soc: Introduce drivers/soc place-holder for SOC specific drivers
> 
> :::::: TO: Santosh Shilimkar <santosh.shilimkar@ti.com>
> :::::: CC: Kumar Gala <galak@codeaurora.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

Fixed by:

commit 80d0c649244253d8cb3ba32d708c1431e7ac8fbf
Author: Olof Johansson <olof@lixom.net>
Date:   Mon Apr 29 12:25:41 2019 -0700

    soc: aspeed: fix Kconfig

which is now in mainline.


-- 
~Randy
