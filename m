Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D79CC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 05:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02D6207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 05:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgAGF0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 00:26:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:13641 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgAGF0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 00:26:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 21:26:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; 
   d="scan'208";a="395244570"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 06 Jan 2020 21:26:44 -0800
Received: from [10.226.38.20] (unknown [10.226.38.20])
        by linux.intel.com (Postfix) with ESMTP id 3EED85803E3;
        Mon,  6 Jan 2020 21:26:43 -0800 (PST)
Subject: Re: linux-next: build warning after merge of the phy-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20200107161733.3c70149b@canb.auug.org.au>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <e09d6254-4ff6-93b4-f007-e256db135e47@linux.intel.com>
Date:   Tue, 7 Jan 2020 13:26:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200107161733.3c70149b@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/1/2020 1:17 PM, Stephen Rothwell wrote:
> Hi all,
>
> After merging the phy-next tree, today's linux-next build (86_64
> allmodconfig) produced this warning:
>
> WARNING: modpost: missing MODULE_LICENSE() in drivers/phy/intel/phy-intel-emmc.o
> see include/linux/module.h for more information
>
> Introduced by commit
>
>    95f1061f715e ("phy: intel-lgm-emmc: Add support for eMMC PHY")

sorry,  will fix it and update.

Thanks!

---
Regards
Vadivel
