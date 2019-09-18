Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42ECC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDEC20644
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfIRLJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 07:09:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:49769 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfIRLJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:09:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 04:09:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,520,1559545200"; 
   d="scan'208";a="177684967"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by orsmga007.jf.intel.com with ESMTP; 18 Sep 2019 04:09:06 -0700
Subject: Re: [PATCH V9 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x
 support
To:     "Michael K. Johnson" <johnsonm@danlj.org>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "ben.chuang@genesyslogic.com.tw Ben Chuang" <benchuanggli@gmail.com>
References: <cover.1568184581.git.benchuanggli@gmail.com>
 <2d08c47490a349d7ee5682749f68604adc62f19f.1568184581.git.benchuanggli@gmail.com>
 <20190918104734.GA3320@people.danlj.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <781dc676-4903-5ab2-84d1-b5357c11dccd@intel.com>
Date:   Wed, 18 Sep 2019 14:07:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918104734.GA3320@people.danlj.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/19 1:47 PM, Michael K. Johnson wrote:
> I see that the first four patches made it into Linus's kernel
> yesterday. Is there any chance of this final patch that actually
> enables the hardware making it into another pull request still
> intended for 5.4?  Waiting on additional acked-by on Ben's work
> addressing all the review comments?
> 
> Thanks.
> 
> On Wed, Sep 11, 2019 at 03:23:44PM +0800, Ben Chuang wrote:
>> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>
>> Add support for the GL9750 and GL9755 chipsets.
>>
>> Enable v4 mode and wait 5ms after set 1.8V signal enable for GL9750/
>> GL9755. Fix the value of SDHCI_MAX_CURRENT register and use the vendor
>> tuning flow for GL9750.
> 

It is OK by me:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
