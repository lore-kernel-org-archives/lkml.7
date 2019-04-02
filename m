Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB44C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B0520840
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfDBG0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:26:12 -0400
Received: from mx.socionext.com ([202.248.49.38]:39671 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDBG0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:26:10 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 02 Apr 2019 15:26:08 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 6356F6117D;
        Tue,  2 Apr 2019 15:26:08 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 2 Apr 2019 15:26:08 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 0F6C41A04E0;
        Tue,  2 Apr 2019 15:26:08 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.234.213])
        by yuzu.css.socionext.com (Postfix) with ESMTP id D340C120487;
        Tue,  2 Apr 2019 15:26:07 +0900 (JST)
Cc:     kanematsu.shinji@socionext.com, jic23@kernel.org,
        mark.rutland@arm.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        orito.takao@socionext.com, sugaya.taichi@socionext.com,
        kasai.kazuhiro@socionext.com
Subject: Re: [PATCH 1/2] dt-bindings: iio: counter: Add Milbeaut Updown
 Counter
To:     Rob Herring <robh@kernel.org>
References: <1553581989-13525-1-git-send-email-kanematsu.shinji@socionext.com>
 <20190331015228.GA27625@bogus>
From:   =?UTF-8?B?S2FuZW1hdHN1LCBTaGluamkv5YW85p2+IOS8uOasoQ==?= 
        <kanematsu.shinji@socionext.com>
Message-ID: <976d5e2a-4bb8-3314-453b-921d06ba8ec6@socionext.com>
Date:   Tue, 2 Apr 2019 15:26:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20190331015228.GA27625@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for your review.

On 2019/03/31 15:42, Rob Herring wrote:
> On Tue, Mar 26, 2019 at 03:33:09PM +0900, Shinji Kanematsu wrote:
>> Add documentation for Milbeaut Updown Counter device
>> quadrature encoder and counter binding.
>>
>> Signed-off-by: Shinji Kanematsu <kanematsu.shinji@socionext.com>
>> ---
>>   .../bindings/iio/counter/milbeaut-updown_cnt.txt   | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt b/Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt
>> new file mode 100644
>> index 0000000..6771567
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt
>> @@ -0,0 +1,22 @@
>> +SOCIONEXT Milbeaut Updown counter
>> +
>> +Required properties:
>> +- compatible:       Must be "socionext,milbeaut-updown-counter".
>> +- reg:              Offset and length of the device's register set.
>> +- clocks:           Phandle to the clock used by the Updown counter module.
>> +- clock-names:      Must be "mux".
>> +- interrupts:       SPI number of the device's set.
>> +- cms_type:         connected_device
>> +                     1: updown button  (updown counter mode)
>> +                     2: rotary encoder (phase difference counter mode)
> 
> We should have a common property for describing what's attached.
> IIRC, just had a similar binding recently.
> 

OK, I search the similar binding.

Thank you,
Kanematsu

>> +
>> +Example:
>> +
>> +	updown0: updown@1e002000 {
>> +		compatible = "socionext,milbeaut-updown-counter";
>> +		reg = <0x1e002000 0x20>;
>> +		clocks = <&clk 4>;
>> +		clock-names = "mux";
>> +		interrupts = <0 104 0x4>;
>> +		cms_type = <1>;
>> +	};
>> -- 
>> 1.9.1
>>
> 

