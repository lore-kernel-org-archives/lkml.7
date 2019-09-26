Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A066C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 03:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC60207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 03:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391523AbfIZDkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 23:40:55 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:16169 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733221AbfIZDky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 23:40:54 -0400
Received: from [10.28.19.63] (10.28.19.63) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 26 Sep
 2019 11:40:36 +0800
Subject: Re: [PATCH v2 2/3] dt-bindings: reset: add bindings for the Meson-A1
 SoC Reset Controller
To:     Kevin Hilman <khilman@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1569227661-4261-1-git-send-email-xingyu.chen@amlogic.com>
 <1569227661-4261-3-git-send-email-xingyu.chen@amlogic.com>
 <7htv90rnp2.fsf@baylibre.com>
From:   Xingyu Chen <xingyu.chen@amlogic.com>
Message-ID: <5d2af18b-1b0a-0b35-9855-b27bbae3a71b@amlogic.com>
Date:   Thu, 26 Sep 2019 11:40:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7htv90rnp2.fsf@baylibre.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.19.63]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kevin
Thanks for your review

On 2019/9/26 6:55, Kevin Hilman wrote:
> Xingyu Chen <xingyu.chen@amlogic.com> writes:
> 
>> Add DT bindings for the Meson-A1 SoC Reset Controller include file,
>> and also slightly update documentation.
>>
>> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> 
> The order here doesn't look right.  As the sender, your sign-off should
> be last.  Is Jianxin the author or are you?  If Jianxin, there should be
> a "From:" line at the beginning of the changelog to indicate authorship
> that's different from the sender.
I am an author for this patchset, i will reorder Signed-off in next version.
> 
>> ---
>>   .../bindings/reset/amlogic,meson-reset.yaml        |  1 +
>>   include/dt-bindings/reset/amlogic,meson-a1-reset.h | 59 ++++++++++++++++++++++
>>   2 files changed, 60 insertions(+)
>>   create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h
>>
>> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>> index 00917d8..b3f57d8 100644
>> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>> @@ -16,6 +16,7 @@ properties:
>>         - amlogic,meson8b-reset # Reset Controller on Meson8b and compatible SoCs
>>         - amlogic,meson-gxbb-reset # Reset Controller on GXBB and compatible SoCs
>>         - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
>> +      - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
>>   
>>     reg:
>>       maxItems: 1
>> diff --git a/include/dt-bindings/reset/amlogic,meson-a1-reset.h b/include/dt-bindings/reset/amlogic,meson-a1-reset.h
>> new file mode 100644
>> index 00000000..8d76a47
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/amlogic,meson-a1-reset.h
>> @@ -0,0 +1,59 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> + *
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + * Author: Xingyu Chen <xingyu.chen@amlogic.com>
>> + *
>> + */
>> +
>> +#ifndef _DT_BINDINGS_AMLOGIC_MESON_A1_RESET_H
>> +#define _DT_BINDINGS_AMLOGIC_MESON_A1_RESET_H
>> +
>> +/* RESET0 */
>> +#define RESET_AM2AXI_VAD		1
> 
> minor nit: can you use comments/whitespace here to indicate holes?
> Please see the other amlogic files in this dir for examples.
I will fix it in next version.
> 
> Kevin
> 
> .
> 
