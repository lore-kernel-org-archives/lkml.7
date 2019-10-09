Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31871ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D0A21835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfJIJr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:47:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:57234 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbfJIJrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:47:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 02:47:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; 
   d="scan'208";a="200083428"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Oct 2019 02:47:55 -0700
Received: from [10.226.38.27] (unknown [10.226.38.27])
        by linux.intel.com (Postfix) with ESMTP id 4E0855803E4;
        Wed,  9 Oct 2019 02:47:52 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] mmc: sdhci-of-arasan: Add Support for Intel LGM
 SDXC
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com, robh+dt@kernel.org, mark.rutland@arm.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20191003040032.37696-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191003040032.37696-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <2cbda555-42d2-392c-0887-09cae4a35dce@intel.com>
 <38228535-8d4c-76e9-f568-c0dfdc3994b3@linux.intel.com>
 <20191009094005.GB32742@smile.fi.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <00bb038f-f959-74bf-e598-45891e65d73e@linux.intel.com>
Date:   Wed, 9 Oct 2019 17:47:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009094005.GB32742@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 9/10/2019 5:40 PM, Andy Shevchenko wrote:
> On Wed, Oct 09, 2019 at 09:06:16AM +0800, Ramuthevar, Vadivel MuruganX wrote:
>> Hi Adrian,
>>
>>      Thank you for the Acked-by, will add *Acked-by* in the next-patch.
> Please, stop top-posting.
>
> Besides that, there is no need for next version if the only comments you got
> are ACKs. Rb:s, etc.
Sure, Thanks!
---
Regards
Vadivel
