Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8BFC04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F13621019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfEHGEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:04:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:26918 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfEHGE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:04:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 23:04:29 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2019 23:04:27 -0700
Subject: Re: [PATCH 2/2] mmc: sdhci_am654: Fix SLOTTYPE write
To:     Faiz Abbas <a0230074@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org
References: <20190425155727.20010-1-faiz_abbas@ti.com>
 <20190425155727.20010-3-faiz_abbas@ti.com>
 <c2dcc343-395f-03a2-67a8-d89ab6a6b192@intel.com>
 <db0b0790-4556-8a3b-2ae1-fcb4b1beb4b3@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <755f5c9f-922b-4f29-982a-cc411897b063@intel.com>
Date:   Wed, 8 May 2019 09:04:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <db0b0790-4556-8a3b-2ae1-fcb4b1beb4b3@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/05/19 7:27 PM, Faiz Abbas wrote:
> Hi Adrian,
> 
> On 26/04/19 11:30 AM, Adrian Hunter wrote:
>> On 25/04/19 6:57 PM, Faiz Abbas wrote:
>>> In the call to regmap_update_bits() for SLOTTYPE, the mask and value
>>> fields are exchanged. Fix this.
>>
>> Could you also comment on whether this has any known effect on the driver.
>>
> 
> This call was basically a NOP but it was the correct way around in
> u-boot so it was just taking that value instead. No effect that was
> known to me. Found this out just by inspection.

Please put that in the commit message.
