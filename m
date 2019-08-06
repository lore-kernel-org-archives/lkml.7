Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C60C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683CA20880
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbfHFFxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 01:53:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:31466 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfHFFxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:53:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 22:53:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,352,1559545200"; 
   d="scan'208";a="349320281"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga005.jf.intel.com with ESMTP; 05 Aug 2019 22:53:15 -0700
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after
 reset
To:     Raul Rangel <rrangel@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <CAPDyKFpL1nHt1E1zgS-iDZf_KDWk2CN32Lvr+5Nmo8CtB2VCWg@mail.gmail.com>
 <20190607160553.GA185100@google.com>
 <CAPDyKFout6AY2Q92pYQ-KPH0NENq1-SkYivkDxjjb=uB=tKXuQ@mail.gmail.com>
 <20190610163252.GA227032@google.com>
 <fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com>
 <20190619145625.GA50985@google.com> <20190801151624.GA155392@google.com>
 <a9a8d3f5-d600-7c8d-8734-cf6a017849c5@intel.com>
 <20190805164917.GA93879@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <408c03b6-720f-1211-6855-2c128a3d269d@intel.com>
Date:   Tue, 6 Aug 2019 08:51:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805164917.GA93879@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/08/19 7:49 PM, Raul Rangel wrote:
> On Fri, Aug 02, 2019 at 07:58:20AM +0300, Adrian Hunter wrote:
>>
>> You seem not to have answered to my suggestion for a change to sdhci_reinit() here:
>>
>> 	https://lore.kernel.org/lkml/fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com/
>>
> I thought I answered it here: https://lore.kernel.org/lkml/20190619145625.GA50985@google.com/#t
> 
> Did I miss something?

I didn't get that mail for some reason, sorry.

Please send out my patch and your second with my ack.
