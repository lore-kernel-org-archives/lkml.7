Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F6CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C280214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394754AbfITCrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 22:47:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:57115 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392034AbfITCrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 22:47:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2019 19:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,527,1559545200"; 
   d="scan'208";a="194571188"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Sep 2019 19:47:32 -0700
Received: from [10.226.39.42] (unknown [10.226.39.42])
        by linux.intel.com (Postfix) with ESMTP id 2798F5802A3;
        Thu, 19 Sep 2019 19:47:29 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] reset: Reset controller driver for Intel LGM SoC
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        p.zabel@pengutronix.de
Cc:     "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>,
        cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        robh@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
References: <90cc600d6f7ded68f5a618b626bd9cffa5edf5c3.1566531960.git.eswara.kota@linux.intel.com>
 <48b90943-e23d-a27a-c743-f321345c9151@linux.intel.com>
 <CAFBinCD1oKxYm8QD7XfZUWq_HC5A4GLMmLCnZrcRvpTxrKo30w@mail.gmail.com>
 <19719490-178a-18fd-64f2-f77d955897f7@linux.intel.com>
 <CAFBinCDmi4HN4Ayg4T8aKUeu4hrUmVQ+z-hTN-6XMhiOCUcHjg@mail.gmail.com>
 <34336c9a-8e87-8f84-2ae8-032b7967928f@linux.intel.com>
 <CAFBinCDfM3ssHisMBKXZUFkfoAFw51TaUuKt_aBgtD-mN+9fhg@mail.gmail.com>
 <657d796d-cb1b-472d-fe67-f7b9bf12fd79@linux.intel.com>
 <CAFBinCA5sRp1-siqZqJzFL2nuD3BtjrbD65QtpWbnTgtPNXY1A@mail.gmail.com>
 <cebd8f1d-90ab-87e7-9a34-f5c760688ce5@linux.intel.com>
 <CAFBinCCXo50OX6=8Fz-=nRKuELU_fMOCX=z6iwAcw0_Tfgn1ug@mail.gmail.com>
 <da347f1c-864c-7d68-33c8-045e46651f45@linux.intel.com>
 <CAFBinCDhLYmiORvHdZJAN5cuUjc6eWJK5n9Qg26B0dEhhqUqVQ@mail.gmail.com>
 <389f360a-a993-b9a8-4b50-ad87bcfec767@linux.intel.com>
 <CAFBinCBwrTajCrSf-UqZY5gHqUSn0UTmbc_TLPNVZrPyY5jpOA@mail.gmail.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <62697250-d2c2-87d5-6206-aac3f6fc2be7@linux.intel.com>
Date:   Fri, 20 Sep 2019 10:47:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCBwrTajCrSf-UqZY5gHqUSn0UTmbc_TLPNVZrPyY5jpOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 9/20/2019 3:51 AM, Martin Blumenstingl wrote:
> Hi Dilip,
>
> (sorry for the late reply)
>
> On Thu, Sep 12, 2019 at 8:38 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
> [...]
>> The major difference between the vrx200 and lgm is:
>> 1.) RCU in vrx200 is having multiple register regions wheres RCU in lgm
>> has one single register region.
>> 2.) Register offsets and bit offsets are different.
>>
>> So enhancing the intel-reset-syscon.c to provide compatibility/support
>> for vrx200.
>> Please check the below dtsi binding proposal and let me know your view.
>>
>> rcu0:reset-controller@00000000 {
>>       compatible= "intel,rcu-lgm";
>>       reg = <0x0000000 0x80000>, <reg_set2 size>, <reg_set3 size>,
>> <reg_set4 size>;
> I'm not sure that I understand what are reg_set2/3/4 for
> the first resource (0x80000 at 0x0) already covers the whole LGM RCU,
> so what is the purpose of the other register resources
Yes, as you said the first register resource is enough for LGM RCU as 
registers are at one single region. Whereas in older SoCs RCU registers 
are at different regions, so for that reason reg_set2/3/4 are used.

Driver will decide in reading the no. of register resources based on the 
"struct of_device_id".

Regards,
Dilip
>
>>      intel,global-reset = <0x10 30>;
>>      #reset-cells = <3>;
>> };
>>
>> "#reset-cells":
>>     const:3
>>     description: |
>>       The 1st cell is the reset register offset.
>>       The 2nd cell is the reset set bit offset.
>>       The 3rd cell is the reset status bit offset.
> I think this will work fine for VRX200 (and even older SoCs)
> as you have described in your previous emails we can determine the
> status offset from the reset offset using a simple if/else
>
> for LGM I like your initial suggestion with #reset-cells = <2> because
> it's easier to read and write.
>
>> Reset driver takes care of parsing the register address "reg" as per the
>> ".data" structure in struct of_device_id.
>> Reset driver takes care of traversing the status register offset.
> the differentiation between two and three #reset-cells can also happen
> based on the struct of_device_id:
> - the LGM implementation would simply also use the reset bit as status
> bit (only two cells are needed)
> - the implementation for earlier SoCs would parse the third cell and
> use that as status bit
>
> Philipp, can you please share your opinion on how to move forward with
> the reset-intel driver from this series?
> The reset_control_ops from the reset-intel driver are (in my opinion)
> a bug-fixed and improved version of what we already have in
> drivers/reset/reset-lantiq.c. The driver is NOT simply copy and paste
> because the register layout was greatly simplified for the newer SoCs
> (for which there is reset-intel) compared to the older ones
> (reset-lantiq).
> Dilip's suggestion (in my own words) is that you take his new
> reset-intel driver, then we will work on porting reset-lantiq over to
> that so in the end we can drop the reset-lantiq driver. This approach
> means more work for me (as I am probably the one who then has to do
> the work to port reset-lantiq over to reset-intel). I'm happy to do
> that work if you think that it's worth following this approach.
> So I want your opinion on this before I spend any effort on porting
> reset-lantiq over to reset-intel.
>
>
> Martin
