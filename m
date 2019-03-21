Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C494C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DB3218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfCUOzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:55:44 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:38384 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUOzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:55:44 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2LEtaYg085653;
        Thu, 21 Mar 2019 23:55:36 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Thu, 21 Mar 2019 23:55:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2LEtaId085647
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 21 Mar 2019 23:55:36 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: fix cts, rts pin assign of
 UART3 for rk3399
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190219140800.12624-1-katsuhiro@katsuster.net>
 <20190219140800.12624-2-katsuhiro@katsuster.net>
 <79bf4a6a-59d1-7478-3a28-20ac6c1a44e9@katsuster.net>
Message-ID: <d085cb23-68f2-ecb4-9421-99389335a78f@katsuster.net>
Date:   Thu, 21 Mar 2019 23:55:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <79bf4a6a-59d1-7478-3a28-20ac6c1a44e9@katsuster.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping again...

Please let me know if there is problem in this patch.


On 2019/03/04 23:00, Katsuhiro Suzuki wrote:
> ping...
> 
> On 2019/02/19 23:08, Katsuhiro Suzuki wrote:
>> This patch fixes pin assign of cts and rts signal of UART3.
>>
>> Currently GPIO3_C2 and C3 pins are assigned but TRM says that
>> GPIO3_C0 and C1 are correct.
>>
>> Refer:
>>    RK3399 TRM v1.4 - Table 19-1 UART Interface Description
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> index 76fc2c7af80a..beaa92744a64 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -2535,12 +2535,12 @@
>>               uart3_cts: uart3-cts {
>>                   rockchip,pins =
>> -                    <3 RK_PC2 RK_FUNC_2 &pcfg_pull_none>;
>> +                    <3 RK_PC0 RK_FUNC_2 &pcfg_pull_none>;
>>               };
>>               uart3_rts: uart3-rts {
>>                   rockchip,pins =
>> -                    <3 RK_PC3 RK_FUNC_2 &pcfg_pull_none>;
>> +                    <3 RK_PC1 RK_FUNC_2 &pcfg_pull_none>;
>>               };
>>           };
>>
> 
> 

