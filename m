Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B4EC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 18:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E892146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 18:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfHRS7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 14:59:49 -0400
Received: from mailoutvs8.siol.net ([185.57.226.199]:49736 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbfHRS7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 14:59:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id DD634523A82;
        Sun, 18 Aug 2019 20:59:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2HPR71-A2-_F; Sun, 18 Aug 2019 20:59:45 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 88748523A8A;
        Sun, 18 Aug 2019 20:59:45 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 9A39B523A83;
        Sun, 18 Aug 2019 20:59:43 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: h6: Introduce Tanix TX6 board
Date:   Sun, 18 Aug 2019 20:59:42 +0200
Message-ID: <7640522.c0V0aH5rf2@jernej-laptop>
In-Reply-To: <201908190222.ZdIp2gT1%lkp@intel.com>
References: <20190816205342.29552-3-jernej.skrabec@siol.net> <201908190222.ZdIp2gT1%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 18. avgust 2019 ob 20:42:49 CEST je kbuild test robot napisal(a):
> Hi Jernej,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc4 next-20190816]
> [if your patch is applied to the wrong git tree, please drop us a note to
> help improve the system]
> 
> url:   
> https://github.com/0day-ci/linux/commits/Jernej-Skrabec/dt-bindings-arm-sun
> xi-Add-compatible-for-Tanix-TX6-board/20190819-002034 config:
> arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O
> ~/bin/make.cross chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=arm64
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> >> Error: arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts:83.1-6 Label
> >> or path r_ir not found FATAL ERROR: Syntax error parsing input tree

Strange, Allwinner tree has commit, which introduces r_ir node:
https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/commit/?
h=sunxi/dt-for-5.4&id=9267811aad3524c857cf2e16bbadd8c569e15ab9

Maybe kbuild test robot tree doesn't have it?

Best regards,
Jernej

> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation




