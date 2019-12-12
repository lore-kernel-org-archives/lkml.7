Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12119C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18902077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfLLBpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:45:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:40835 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727539AbfLLBpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:45:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 17:45:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,303,1571727600"; 
   d="scan'208";a="216118388"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 11 Dec 2019 17:45:13 -0800
Received: from [10.226.38.16] (unknown [10.226.38.16])
        by linux.intel.com (Postfix) with ESMTP id 127BA580297;
        Wed, 11 Dec 2019 17:45:11 -0800 (PST)
Subject: Re: [PATCH v7 0/2] phy: intel-lgm-emmc: Add support for eMMC PHY
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
References: <20191211025011.12156-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191211110542.GQ32742@smile.fi.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <0b4652c6-05c2-ab91-b79b-d4c2268ec9dd@linux.intel.com>
Date:   Thu, 12 Dec 2019 09:45:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191211110542.GQ32742@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/12/2019 7:05 PM, Andy Shevchenko wrote:
> On Wed, Dec 11, 2019 at 10:50:09AM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> Add eMMC-PHY support for Intel LGM SoC
>>
>> changes in v7:
>>   Rebased to maintainer kernel tree phy-tag-5.5
>>
> You forgot to bump version...

Thanks Andy, oh My bad, I will update the patch v8.

---
With Best Regards
Vadivel
