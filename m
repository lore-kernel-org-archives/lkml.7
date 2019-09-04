Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C526C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B032186A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfIDNil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:38:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:13364 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730145AbfIDNik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:38:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 06:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="182488528"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 04 Sep 2019 06:38:39 -0700
Received: from [10.249.77.74] (vramuthx-mobl1.gar.corp.intel.com [10.249.77.74])
        by linux.intel.com (Postfix) with ESMTP id 514455802AF;
        Wed,  4 Sep 2019 06:38:37 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] phy: intel-lgm-sdxc: Add support for SDXC PHY
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
References: <20190904062719.37462-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190904062719.37462-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190904123957.GM2680@smile.fi.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <a36dcf94-4636-1742-4ae6-60cf2c03c7f5@linux.intel.com>
Date:   Wed, 4 Sep 2019 21:38:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904123957.GM2680@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

  Thank you for the review comments .

On 4/9/2019 8:39 PM, Andy Shevchenko wrote:
> On Wed, Sep 04, 2019 at 02:27:19PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add support for SDXC PHY on Intel's Lightning Mountain SoC.
> What's the difference to eMMC PHY?
> Can they share the same / similar code?
eMMC and SDXC interface controller share the common driver since IP block
of the vendor(SDHC-ARASAN) is same, where as PHY is different. The PHY 
is designed by Intel itself to support
specific eMMC card and SD/SDIO card specific. e.g: PAD, CLK, driver 
strength..etc.

IP block of the PHY  is different module for eMMC and SDXC to adapt the 
controllers, that is reason we have different drivers.
---
With Best Regards
Vadivel
