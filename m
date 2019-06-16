Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA00C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 22:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B5220861
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 22:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfFPVzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 17:55:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42105 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfFPVzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 17:55:55 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcd7u-0000Hn-9A; Sun, 16 Jun 2019 23:55:50 +0200
Date:   Sun, 16 Jun 2019 23:55:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     kbuild test robot <lkp@intel.com>
cc:     "Chang S. Bae" <chang.seok.bae@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: Re: [tip:WIP.x86/cpu 12/18] undefined reference to
 `.Lparanoid_entry_checkgs'
In-Reply-To: <201906170531.BZfEWn04%lkp@intel.com>
Message-ID: <alpine.DEB.2.21.1906162355310.1760@nanos.tec.linutronix.de>
References: <201906170531.BZfEWn04%lkp@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, kbuild test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/cpu
> head:   60152cedb1bd1fa603528d53d1eec0279a74223f
> commit: 2902fa1280ff6b1ecac1d41d1ab81239393e09fb [12/18] x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit
> config: x86_64-alldefconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 2902fa1280ff6b1ecac1d41d1ab81239393e09fb
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    ld: arch/x86/entry/entry_64.o: in function `paranoid_entry':
> >> (.entry.text+0xf20): undefined reference to `.Lparanoid_entry_checkgs'

My bad. Fixed and pushed out.
