Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EA2C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C282073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="cTa6HUut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfG2HYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 03:24:24 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22458 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbfG2HYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 03:24:24 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6T7Lfvg024841;
        Mon, 29 Jul 2019 09:24:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=ag3607f4rZRHcp8HUBaVypYdYUkemynvgAUvHb2YYs0=;
 b=cTa6HUutdsFxJUHgsniQS2DcXuwLLWJsFjrVZtH8En5C2JGiJZ2b/TGEgzSPi0kJRVQe
 ejdE0EP46/cWqytEhxJasHdNELl3Tty51MdQxdAdKkjBHBsnmDg6ibXRh/jicctJCY1S
 qjVPxUSYrYpx1uct2CopUHWbLjevIw9utzejE0aexuXIky5ooOCUO3YKesuC12yucoPT
 FEKdY8MrsoVBnzRDxtSnyWlmyYUmgVN6MMhRNyOGKDPYCMEnqlqGFKhLIE0bsKYePFzI
 1CAWdNkAHFnNrSHfezPxkIDy1V2pssTGHMOJrYnk385lHt1AcipeBrX+zTd9KetUwU+z 2g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u0ccwanxs-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 29 Jul 2019 09:24:10 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5051342;
        Mon, 29 Jul 2019 07:24:01 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 332AC56D1;
        Mon, 29 Jul 2019 07:24:01 +0000 (GMT)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 29 Jul
 2019 09:24:00 +0200
Subject: Re: [PATCH] ARM: dts: stm32: add audio codec support on
 stm32mp157a-dk1 board
To:     Olivier MOYSAN <olivier.moysan@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1562327580-19647-1-git-send-email-olivier.moysan@st.com>
 <27476214-07fe-886b-1cab-20902837f29c@st.com>
 <f43b8af7-e2c0-6193-d666-9fa60050e07d@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f87aaed6-1aa4-fd52-9476-b22f9b122aeb@st.com>
Date:   Mon, 29 Jul 2019 09:23:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f43b8af7-e2c0-6193-d666-9fa60050e07d@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-29_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/19 11:41 AM, Olivier MOYSAN wrote:
> 
> 
> On 7/24/19 6:40 PM, Alexandre Torgue wrote:
>> Hi Olivier
>> 
>> On 7/5/19 1:53 PM, Olivier Moysan wrote:
>>> Add support of Cirrus cs42l51 audio codec on stm32mp157a-dk1 board.
>>> Configuration overview:
>>> - SAI2A is the CPU interface used for the codec audio playback
>>> - SAI2B is the CPU interface used for the codec audio record
>>> - SAI2A is configured as a clock provider for the audio codec
>>> - SAI2A&B are configured as slave of the audio codec
>>> - SAI2A&B share the same interface of the audio codec
>>>
>>> Note:
>>> In master mode, cs42l51 audio codec provides a bitclock
>>> at 64 x FS, regardless of data width. This means that
>>> slot width is always 32 bits.
>>> Set slot width to 32 bits and slot number to 2
>>> in SAI2A&B endpoint nodes, to match this constraint.
>>> dai-tdm-slot-num and dai-tdm-slot-width properties are used here,
>>> assuming that i2s is a special case of tdm, where slot number is 2.
>>>
>>> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
>>> ---
>>>    arch/arm/boot/dts/stm32mp157a-dk1.dts | 89 +++++++++++++++++++++++++++++++++++
>>>    1 file changed, 89 insertions(+)
>>>
>> 
>> ...
>> 
>>>    
>>> +&sai2 {
>>> +    clocks = <&rcc SAI2>, <&rcc PLL3_Q>, <&rcc PLL3_R>;
>>> +    clock-names = "pclk", "x8k", "x11k";
>>> +    pinctrl-names = "default", "sleep";
>>> +    pinctrl-0 = <&sai2a_pins_a>, <&sai2b_pins_b>;
>>> +    pinctrl-1 = <&sai2a_sleep_pins_a>, <&sai2b_sleep_pins_b>;
>>> +    status = "okay";
>>> +
>>> +    sai2a: audio-controller@4400b004 {
>>> +            #clock-cells = <0>;
>>> +            dma-names = "tx";
>>> +            clocks = <&rcc SAI2_K>;
>>> +            clock-names = "sai_ck";
>>> +            status = "okay";
>>> +
>>> +            sai2a_port: port {
>>> +                    sai2a_endpoint: endpoint {
>>> +                            remote-endpoint = <&cs42l51_tx_endpoint>;
>>> +                            format = "i2s";
>>> +                            mclk-fs = <256>;
>>> +                            dai-tdm-slot-num = <2>;
>>> +                            dai-tdm-slot-width = <32>;
>>> +                    };
>>> +            };
>>> +    };
>>> +
>> You could use label to overload sai2a and sai2b. no ?
> I propose to keep it unchanged for better readability
>> 

Ok. Applied on stm32-next.

Regards
Alex

