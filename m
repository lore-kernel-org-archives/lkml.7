Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A5CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DCB2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLQIxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:53:34 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:42113 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfLQIxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:53:34 -0500
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBH8rDNq089476;
        Tue, 17 Dec 2019 17:53:13 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp);
 Tue, 17 Dec 2019 17:53:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp)
Received: from [192.168.1.2] (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xBH8rDMm089472
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 17 Dec 2019 17:53:13 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v3] arm64: dts: rockchip: split rk3399-rockpro64 for v2
 and v2.1 boards
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
References: <20191202055929.26540-1-katsuhiro@katsuster.net>
 <6656576.A7zHEAv81k@phil>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <c7a6427d-9a11-a83e-82dd-d799fc0f72ce@katsuster.net>
Date:   Tue, 17 Dec 2019 17:53:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <6656576.A7zHEAv81k@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

On 2019/12/16 19:04, Heiko Stuebner wrote:
> Hi Katsuhiro,
> 
> Am Montag, 2. Dezember 2019, 06:59:29 CET schrieb Katsuhiro Suzuki:
>> This patch splits rk3399-rockpro64 dts file to 2 files for v2 and
>> v2.1 boards.
>>
>> Both v2 and v2.1 boards can use almost same settings but we find a
>> difference in I2C address of audio CODEC ES8136.
>>
>> Reported-by: Vasily Khoruzhick <anarsoul@gmail.com>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>>
>> ---
>>
>> Changes in v3:
>>    - Add compatible strings for v2.0 and v2.1 boards
>>
>> Changes in v2:
>>    - Use rk3399-rockpro64.dts for for v2.1 instead of creating
>>      rk3399-rockpro64-v2.1.dts
>> ---
>>   .../devicetree/bindings/arm/rockchip.yaml     |   2 +
>>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>>   .../boot/dts/rockchip/rk3399-rockpro64-v2.dts |  30 +
>>   .../boot/dts/rockchip/rk3399-rockpro64.dts    | 759 +----------------
>>   .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 763 ++++++++++++++++++
>>   5 files changed, 800 insertions(+), 755 deletions(-)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dts
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
>>
>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> index d9847b306b83..8d8658613c57 100644
>> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> @@ -409,6 +409,8 @@ properties:
>>   
>>         - description: Pine64 RockPro64
>>           items:
>> +          - const: pine64,rockpro64-v2.1
>> +          - const: pine64,rockpro64-v2.0
>>             - const: pine64,rockpro64
>>             - const: rockchip,rk3399
>>   
> 
> applied for 5.6 with a changed binding. If you need a
> "one-of-many" element it should use an enum ... see the rk3399-firefly
> and other boards for example. So I've adapted the patch accordingly:
> 

Thank you for pointing and fix.
I will do as that for next time.


> @@ -409,6 +409,9 @@ properties:
>   
>         - description: Pine64 RockPro64
>           items:
> +          - enum:
> +              - pine64,rockpro64-v2.1
> +              - pine64,rockpro64-v2.0
>             - const: pine64,rockpro64
>             - const: rockchip,rk3399
>   
> 
> Heiko
> 
> 
> 

Best Regards,
Katsuhiro Suzuki

