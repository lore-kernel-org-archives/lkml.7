Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE163C2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 05:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB8920706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 05:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfLXFtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 00:49:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:50042 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfLXFtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 00:49:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 21:49:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,350,1571727600"; 
   d="scan'208";a="242421618"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 23 Dec 2019 21:49:09 -0800
Received: from [10.226.38.1] (unknown [10.226.38.1])
        by linux.intel.com (Postfix) with ESMTP id A898E58046E;
        Mon, 23 Dec 2019 21:49:06 -0800 (PST)
Subject: Re: [PATCH v2 1/2] clk: intel: Add CGU clock driver for a new SoC
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, yixin.zhu@linux.intel.com,
        qi-ming.wu@intel.com, rtanwar <rahul.tanwar@intel.com>,
        clang-built-linux@googlegroups.com
References: <cover.1576811332.git.rahul.tanwar@linux.intel.com>
 <ee8a8a0f0c882e22361895b2663870c8037c422f.1576811332.git.rahul.tanwar@linux.intel.com>
 <20191224052947.GA54145@ubuntu-m2-xlarge-x86>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <c61235a7-969f-f534-e25f-e3990b9c8d11@linux.intel.com>
Date:   Tue, 24 Dec 2019 13:49:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191224052947.GA54145@ubuntu-m2-xlarge-x86>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/12/2019 1:29 PM, Nathan Chancellor wrote:
> On Fri, Dec 20, 2019 at 11:31:07AM +0800, Rahul Tanwar wrote:
>> From: rtanwar <rahul.tanwar@intel.com>
>>
>> Clock Generation Unit(CGU) is a new clock controller IP of a forthcoming
>> Intel network processor SoC. It provides programming interfaces to control
>> & configure all CPU & peripheral clocks. Add common clock framework based
>> clock controller driver for CGU.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> Hi Rahul,
>
> The 0day bot reported this warning with clang with your patch, mind
> taking a look at it since it seems like you will need to do a v2 based
> on other comments?
>
> It seems like the check either needs to be something different or the
> check should just be removed.
>
> Cheers,
> Nathan

Hi Nathan,

Yes sure, i will fix it in v3. I anyways need to post v3 to address review
comments received from few reviewers. Thanks.

Regards,
Rahul

