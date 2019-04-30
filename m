Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBABC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D77204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfD3Lep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:34:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:6143 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfD3Leo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:34:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 04:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,413,1549958400"; 
   d="scan'208";a="295763947"
Received: from mylly.fi.intel.com (HELO [10.237.72.154]) ([10.237.72.154])
  by orsmga004.jf.intel.com with ESMTP; 30 Apr 2019 04:34:42 -0700
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Intel Comet Lake PCI IDs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Evan Green <evgreen@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190409151100.16027-1-andriy.shevchenko@linux.intel.com>
 <CAE=gft7VK=7gV3PV1QdjRPOccEYmL-341fUNX+wXGUfrvzUDfw@mail.gmail.com>
 <CAHp75Vfw8-jfzgOBwyTk6E5sqsSxh1NVPnLdQHyZJZneruT3uA@mail.gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <12f48b95-7a45-919e-0eb5-30e00e692743@linux.intel.com>
Date:   Tue, 30 Apr 2019 14:34:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfw8-jfzgOBwyTk6E5sqsSxh1NVPnLdQHyZJZneruT3uA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 10:55 AM, Andy Shevchenko wrote:
> On Tue, Apr 16, 2019 at 6:10 AM Evan Green <evgreen@chromium.org> wrote:
>> On Tue, Apr 9, 2019 at 11:11 PM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>>
>>> Intel Comet Lake has the same LPSS than Intel Cannon Lake.
>>> Add the new IDs to the list of supported devices.
> 
>>>   static const struct pci_device_id intel_lpss_pci_ids[] = {
>>> +       /* CML */
>>> +       { PCI_VDEVICE(INTEL, 0x02a8), (kernel_ulong_t)&spt_uart_info },
>>> +       { PCI_VDEVICE(INTEL, 0x02a9), (kernel_ulong_t)&spt_uart_info },
>>> +       { PCI_VDEVICE(INTEL, 0x02aa), (kernel_ulong_t)&spt_info },
>>> +       { PCI_VDEVICE(INTEL, 0x02ab), (kernel_ulong_t)&spt_info },
>>> +       { PCI_VDEVICE(INTEL, 0x02c5), (kernel_ulong_t)&bxt_i2c_info },
>>> +       { PCI_VDEVICE(INTEL, 0x02c6), (kernel_ulong_t)&bxt_i2c_info },
>>
>> How come it's not cnl_i2c_info?
> 
> This is a good question, that's why Jarkko asked Lee to hold on until
> we have confirmation about i2c timings.
> 
I got confirmation I2C uses the same input clock than Cannon Lake and 
matches with my measurements.

Andy: please do s/bxt_i2c_info/cnl_i2c_info/ in your patch.

-- 
Jarkko
