Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37485C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100C22087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbfHBKtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:49:16 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:53029 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfHBKtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:49:16 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id BEC1D20025;
        Fri,  2 Aug 2019 12:49:12 +0200 (CEST)
Date:   Fri, 2 Aug 2019 12:49:11 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Inki Dae <inki.dae@samsung.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: ERROR: "vmf_insert_mixed" [drivers/gpu/drm/exynos/exynosdrm.ko]
 undefined!
Message-ID: <20190802104911.GA30582@ravnborg.org>
References: <CGME20190724223620epcas3p35a32100b839a0d545e910e3ed84047ca@epcas3p3.samsung.com>
 <201907250623.Lvc2mgUO%lkp@intel.com>
 <d1ba546e-11d1-3f16-aba8-10ffd318a3f3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1ba546e-11d1-3f16-aba8-10ffd318a3f3@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=Oh2cFVv5AAAA:8
        a=bt8Zh30PAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=7gkXJVJtAAAA:8
        a=JtIW4zDZkoOJZ0rFRgkA:9 a=QEXdDO2ut3YA:10 a=7KeoIwV6GZqOttXkcoxL:22
        a=AjGcO6oz07-iQ99wixmX:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Inki

On Fri, Aug 02, 2019 at 05:15:06PM +0900, Inki Dae wrote:
> Hi,
> 
> 19. 7. 25. 오전 7:35에 kbuild test robot 이(가) 쓴 글:
> > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   bed38c3e2dca01b358a62b5e73b46e875742fd75
> > commit: 156bdac99061b4013c8e47799c6e574f7f84e9f4 drm/exynos: trigger build of all modules
> > date:   4 weeks ago
> > config: h8300-allmodconfig (attached as .config)
> > compiler: h8300-linux-gcc (GCC) 7.4.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 156bdac99061b4013c8e47799c6e574f7f84e9f4
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.4.0 make.cross ARCH=h8300 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >>> ERROR: "vmf_insert_mixed" [drivers/gpu/drm/exynos/exynosdrm.ko] undefined!
> 
> With below patch I think the build error reported already will be fixed,
> https://patchwork.kernel.org/patch/11035147/

I have the exact same patch locally - that I forgot to send out.
So:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
