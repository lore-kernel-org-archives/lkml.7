Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6C9C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183CB218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgAFIBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:01:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:32659 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgAFIBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:01:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 00:01:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,401,1571727600"; 
   d="scan'208";a="215128790"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 06 Jan 2020 00:01:48 -0800
Received: from [10.226.38.20] (unknown [10.226.38.20])
        by linux.intel.com (Postfix) with ESMTP id CD9CC5802C0;
        Mon,  6 Jan 2020 00:01:46 -0800 (PST)
Subject: Re: [PATCH v10 0/2] phy: intel-lgm-emmc: Add support for eMMC PHY
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, peter.harliman.liem@intel.com
References: <20191217015658.23017-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <c5df1165-5b8d-f329-582f-15553eb5eb1a@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <9917ebc0-656e-6539-504a-208ef375a989@linux.intel.com>
Date:   Mon, 6 Jan 2020 16:01:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <c5df1165-5b8d-f329-582f-15553eb5eb1a@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/1/2020 3:24 PM, Kishon Vijay Abraham I wrote:
>
> On 17/12/19 7:26 AM, Ramuthevar,Vadivel MuruganX wrote:
>> Add eMMC-PHY support for Intel LGM SoC
> merged now, Thanks!

Thanks a lot!!! Kishon for the quick rely and merge.

---
Regards
Vadivel
>
> -Kishon
>
>> changes in v10:
>>    - Rob's review comments update in YAML
>>    - drop clock-names since it is single entry
>>   
>> changes in v9:
>>    - Rob's review comments update in YAML
>>
>> changes in v8:
>>   Remove the extra Signed-of-by
>>
>> changes in v7:
>>   Rebased to maintainer kernel tree phy-tag-5.5
>>
>> changes in v6:
>>     - cobined comaptible strings
>>     - added as contiguous and can be a single entry for reg properties
>> changes in v5:
>>     - earlier Review-by tag given by Rob
>>     - rework done with syscon parent node.
>>
>>   changes in v4:
>>     - As per Rob's review: validate 5.2 and 5.3
>>     - drop unrelated items.
>>
>>   changes in v3:
>>     - resolve 'make dt_binding_check' warnings
>>
>>   changes in v2:
>>     As per Rob Herring review comments, the following updates
>>    - change GPL-2.0 -> (GPL-2.0-only OR BSD-2-Clause)
>>    - filename is the compatible string plus .yaml
>>    - LGM: Lightning Mountain
>>    - update maintainer
>>    - add intel,syscon under property list
>>    - keep one example instead of two
>>
>>
>>
>> Ramuthevar Vadivel Murugan (2):
>>    dt-bindings: phy: intel-emmc-phy: Add YAML schema for LGM eMMC PHY
>>    phy: intel-lgm-emmc: Add support for eMMC PHY
>>
>>   .../bindings/phy/intel,lgm-emmc-phy.yaml           |  56 ++++
>>   drivers/phy/Kconfig                                |   1 +
>>   drivers/phy/Makefile                               |   1 +
>>   drivers/phy/intel/Kconfig                          |   9 +
>>   drivers/phy/intel/Makefile                         |   2 +
>>   drivers/phy/intel/phy-intel-emmc.c                 | 283 +++++++++++++++++++++
>>   6 files changed, 352 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>>   create mode 100644 drivers/phy/intel/Kconfig
>>   create mode 100644 drivers/phy/intel/Makefile
>>   create mode 100644 drivers/phy/intel/phy-intel-emmc.c
>>
