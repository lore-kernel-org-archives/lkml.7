Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27B9C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924F5206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKUXoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:44:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfKUXoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:44:37 -0500
Received: from oasis.local.home (unknown [66.170.99.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4860206D7;
        Thu, 21 Nov 2019 23:44:36 +0000 (UTC)
Date:   Thu, 21 Nov 2019 18:44:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Kusanagi Kouichi <slash@ac.auone-net.jp>, kbuild-all@lists.01.org,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Remove unnecessary DEBUG_FS dependency
Message-ID: <20191121184435.39eeac73@oasis.local.home>
In-Reply-To: <201911211354.zYtbB4MD%lkp@intel.com>
References: <20191120104350753.EWCT.12796.ppp.dion.ne.jp@dmta0009.auone-net.jp>
        <201911211354.zYtbB4MD%lkp@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 13:08:45 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Kusanagi,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/perf/core]
> [also build test ERROR on v5.4-rc8 next-20191120]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Kusanagi-Kouichi/tracing-Remove-unnecessary-DEBUG_FS-dependency/20191121-032827
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 8f6ee51d772d0dab407d868449d2c5d9c8d2b6fc
> config: arm-exynos_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>

Ah, this needs to have #ifdef around some parts to add this patch.

I'll see if I can fix this up.

-- Steve
