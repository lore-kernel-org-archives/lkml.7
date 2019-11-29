Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22C2C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48112082E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfK2Lxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 06:53:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:49250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbfK2Lxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:53:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2489AD93;
        Fri, 29 Nov 2019 11:53:47 +0000 (UTC)
Date:   Fri, 29 Nov 2019 12:53:47 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>, kbuild-all@lists.01.org,
        joe@perches.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, tj@kernel.org, arnd@arndb.de,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Subject: Re: [PATCH 3/4] printk: Drop pr_warning definition
Message-ID: <20191129115347.ltzif5jstfxh3h3t@pathway.suse.cz>
References: <20191128004752.35268-4-wangkefeng.wang@huawei.com>
 <201911281545.4mGpcG7D%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911281545.4mGpcG7D%lkp@intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-11-28 15:14:36, kbuild test robot wrote:
> Hi Kefeng,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on wq/for-next]
> [cannot apply to pmladek/for-next v5.4 next-20191127]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Kefeng-Wang/part2-kill-pr_warning-from-kernel/20191128-085343
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-next
> config: i386-defconfig (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/platform/x86/eeepc-laptop.c: In function 'eeepc_rfkill_hotplug':
> >> drivers/platform/x86/eeepc-laptop.c:581:3: error: implicit declaration of function 'pr_warning'; did you mean 'acpi_warning'? [-Werror=implicit-function-declaration]
>       pr_warning("Unable to find port\n");
>       ^~~~~~~~~~
>       acpi_warning
>    cc1: some warnings being treated as errors

[...]

These are false positives. These pr_warning() calls have already been
removed in mainline via a pull request from printk.git.

Best Regards.
Petr


tj/wq.git for-next branch is outdated.
This branch is outdated. The 
