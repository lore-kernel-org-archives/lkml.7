Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6A0C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365BD20692
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKVCTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 21:19:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:50449 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfKVCTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 21:19:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 18:19:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,228,1571727600"; 
   d="scan'208";a="407432177"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 21 Nov 2019 18:19:42 -0800
Received: from [10.226.38.71] (unknown [10.226.38.71])
        by linux.intel.com (Postfix) with ESMTP id B50825802E4;
        Thu, 21 Nov 2019 18:19:39 -0800 (PST)
Subject: Re: [PATCH v8 1/2] pinctrl: Add pinmux & GPIO controller driver for a
 new SoC
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com
References: <cover.1573797249.git.rahul.tanwar@linux.intel.com>
 <33e649758b70490f01724a887c490d5008c7656d.1573797249.git.rahul.tanwar@linux.intel.com>
 <CACRpkdaoiYvcMVCyJJTSyvSZUMAj6QsCcGG3=s4or31r08=hdg@mail.gmail.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <fcfbbd80-d626-1b71-6b40-92de4fef6393@linux.intel.com>
Date:   Fri, 22 Nov 2019 10:19:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdaoiYvcMVCyJJTSyvSZUMAj6QsCcGG3=s4or31r08=hdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

On 21/11/2019 9:47 PM, Linus Walleij wrote:
> Hi Rahul,
>
> On Fri, Nov 15, 2019 at 10:25 AM Rahul Tanwar
> <rahul.tanwar@linux.intel.com> wrote:
>
>> Intel Lightning Mountain SoC has a pinmux controller & GPIO controller IP which
>> controls pin multiplexing & configuration including GPIO functions selection &
>> GPIO attributes configuration.
>>
>> This IP is not based on & does not have anything in common with Chassis
>> specification. The pinctrl drivers under pinctrl/intel/* are all based upon
>> Chassis spec compliant pinctrl IPs. So this driver doesn't fit & can not use
>> pinctrl framework under pinctrl/intel/* and it requires a separate new driver.
>>
>> Add a new GPIO & pin control framework based driver for this IP.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> Thanks a lot for quick iterations and hard work on getting this
> driver in such a nice shape in such a short time!
>
> Patch applied for kernel v5.5.
>
> If there are any remaining issues I am sure we can fix them up
> in-tree.

Thanks a lot for your valuable time/feedback, encouraging words
& for accepting the patch.

Regards,
Rahul
