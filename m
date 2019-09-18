Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83764C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 02:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E9F21881
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 02:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfIRC0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 22:26:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:21394 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfIRC0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 22:26:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 19:26:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,519,1559545200"; 
   d="scan'208";a="187632736"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 17 Sep 2019 19:26:14 -0700
Received: from [10.226.38.20] (unknown [10.226.38.20])
        by linux.intel.com (Postfix) with ESMTP id B043C58012D;
        Tue, 17 Sep 2019 19:26:12 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: intel-sdxc-phy: Add YAML schema
 for LGM SDXC PHY
To:     Rob Herring <robh@kernel.org>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
References: <20190904062719.37462-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190917202410.GA6574@bogus>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <b860d369-fda4-4a20-bba5-4ced420de8aa@linux.intel.com>
Date:   Wed, 18 Sep 2019 10:26:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190917202410.GA6574@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

     Thank you for the review comments.

On 18/9/2019 4:24 AM, Rob Herring wrote:
> On Wed, Sep 04, 2019 at 02:27:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add a YAML schema to use the host controller driver with the
>> SDXC PHY on Intel's Lightning Mountain SoC.
> Same issues on this one as emmc phy.

Agreed!, once clarified the emmc phy comments, let me update further. 
Thanks!

Best Regards
Vadivel
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   changes in v3:
>>     - Rob's review comments addressed and updated the patch
>>     - merged syscon and sdxc yaml file as single file after discussion
>>
>>   changes in v2:
>>     - As per Rob's review comment syscon node entry added instead of reference
>>     - splitted two patches one for syscon and another for sdxc phy
>> ---
>>   .../bindings/phy/intel,lgm-sdxc-phy.yaml           | 69 ++++++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
