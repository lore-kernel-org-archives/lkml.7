Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9CFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2E2207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfK0B2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:28:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:50972 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfK0B2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:28:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 17:28:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,247,1571727600"; 
   d="scan'208";a="202905417"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 26 Nov 2019 17:28:35 -0800
Received: from [10.226.38.16] (unknown [10.226.38.16])
        by linux.intel.com (Postfix) with ESMTP id 97EB0580332;
        Tue, 26 Nov 2019 17:28:33 -0800 (PST)
Subject: Re: [PATCH v6 0/2] phy: intel,lgm-emmc-phy: Add support for eMMC PHY
 on Intel LGM SoC
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
References: <20191021095436.50303-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <8a29dc7e-8d81-2630-f086-e1ac400f5718@linux.intel.com>
Date:   Wed, 27 Nov 2019 09:28:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021095436.50303-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

   Kindly , can you please review the eMMC-PHY driver series of patches 
if you have time.

---
With Best Regards
Vadivel Murugan
On 21/10/2019 5:54 PM, Ramuthevar,Vadivel MuruganX wrote:
>   Rebased to kernel verson 5.4
>
> dt-bindings: phy: intel-emmc-phy: Add YAML schema for LGM eMMC PHY
> changes in v6:
>     - cobined comaptible strings
>     - added as contiguous and can be a single entry for reg properties
> changes in v5:
>     - earlier Review-by tag given by Rob
>     - rework done with syscon parent node.
>
>   changes in v4:
>     - As per Rob's review: validate 5.2 and 5.3
>     - drop unrelated items.
>
>   changes in v3:
>     - resolve 'make dt_binding_check' warnings
>
>   changes in v2:
>     As per Rob Herring review comments, the following updates
>    - change GPL-2.0 -> (GPL-2.0-only OR BSD-2-Clause)
>    - filename is the compatible string plus .yaml
>    - LGM: Lightning Mountain
>    - update maintainer
>    - add intel,syscon under property list
>    - keep one example instead of two
>
> phy: intel-lgm-emmc: Add support for eMMC PHY
>    No changes from  patchV5
>   
> Ramuthevar Vadivel Murugan (2):
>    dt-bindings: phy: intel-emmc-phy: Add YAML schema for LGM eMMC PHY
> 	
>    phy: intel-lgm-emmc: Add support for eMMC PHY
>
>   .../bindings/phy/intel,lgm-emmc-phy.yaml           |  63 +++++
>   drivers/phy/Kconfig                                |   1 +
>   drivers/phy/Makefile                               |   1 +
>   drivers/phy/intel/Kconfig                          |   9 +
>   drivers/phy/intel/Makefile                         |   2 +
>   drivers/phy/intel/phy-intel-emmc.c                 | 283 +++++++++++++++++++++
>   6 files changed, 359 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>   create mode 100644 drivers/phy/intel/Kconfig
>   create mode 100644 drivers/phy/intel/Makefile
>   create mode 100644 drivers/phy/intel/phy-intel-emmc.c
>
