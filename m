Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0396AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB7F21D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfJCHrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 03:47:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:17762 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfJCHrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:47:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 00:47:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,251,1566889200"; 
   d="scan'208";a="205558147"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 03 Oct 2019 00:47:00 -0700
Received: from [10.226.38.25] (unknown [10.226.38.25])
        by linux.intel.com (Postfix) with ESMTP id AB2F55803A5;
        Thu,  3 Oct 2019 00:46:57 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] mmc: sdhci-of-arasan: Add Support for Intel LGM
 SDXC
To:     Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, michal.simek@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20191003040032.37696-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191003040032.37696-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <329a38b4-4fba-eb6e-0d40-c241cfa28e25@intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <0c3d406c-dc28-a670-91df-7c7e6f818f87@linux.intel.com>
Date:   Thu, 3 Oct 2019 15:46:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <329a38b4-4fba-eb6e-0d40-c241cfa28e25@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

  Thank you for the comments.

On 3/10/2019 3:02 PM, Adrian Hunter wrote:
> On 3/10/19 7:00 AM, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> The current arasan sdhci PHY configuration isn't compatible
>> with the PHY on Intel's LGM(Lightning Mountain) SoC devices.
>>
>> Therefore, add a new compatible, to adapt the Intel's LGM
>> SDXC PHY with arasan-sdhc controller to configure the PHY.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> Aren't these patches already in v5.4-rc1

  No, these patches are not there in v5.4-rc1.

  The one which is in v5.4-rc1 supports only eMMC, does not SD/SDIO, so 
these patches are required.

---
With Best Regards
Vadivel Murugan
