Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60633C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366562064B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLSK2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:28:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:23833 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfLSK2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:28:53 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 02:28:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,331,1571727600"; 
   d="scan'208";a="267168340"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Dec 2019 02:28:50 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iht34-0004cG-H6; Thu, 19 Dec 2019 12:28:50 +0200
Date:   Thu, 19 Dec 2019 12:28:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chen Gang <chengang@emindsoft.com.cn>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, sr@denx.de,
        mika.westerberg@linux.intel.com, yegorslists@googlemail.com,
        yuehaibing@huawei.com, haolee.swjtu@gmail.com, dsterba@suse.com,
        mojha@codeaurora.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lv Li-song <lvlisong@emindsoft.com.cn>
Subject: Re: [PATCH] drivers: tty: serial: 8250: fintek: Can enable or
 disable irq sharing based on isa or pci bus
Message-ID: <20191219102850.GJ32742@smile.fi.intel.com>
References: <20191213051717.2058-1-chengang@emindsoft.com.cn>
 <20191213105033.GT32742@smile.fi.intel.com>
 <758a0ca9-8f81-1a10-d9e1-11f86fac3de1@emindsoft.com.cn>
 <20191216095120.GN32742@smile.fi.intel.com>
 <2c4cba36-5833-ca08-4153-2061edf33186@emindsoft.com.cn>
 <1d0dae5a-cf47-1682-de62-468f60fc621a@emindsoft.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d0dae5a-cf47-1682-de62-468f60fc621a@emindsoft.com.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 05:35:59PM +0800, Chen Gang wrote:
> After check the linux-next tree, the core content is already fixed by
> the patch "4da22f1418cb serial: 8250_fintek: fix the mismatched IRQ
> mode" (it was applied on 2016-05-27).
> 
> And it looks my original modification for 8250_pnp.c is unnecessary, I
> guess originally I only wanted to make sure it should work well, but did
> not cleanup the code.

Good news!

> So this patch is useless, sorry to bother you. And again, thank you for
> reviewing the code.

You're welcome!

-- 
With Best Regards,
Andy Shevchenko


