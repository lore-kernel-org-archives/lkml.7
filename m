Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1346C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A928D206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEBKYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:24:42 -0400
Received: from mail2.sp2max.com.br ([138.185.4.9]:42980 "EHLO
        mail2.sp2max.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfEBKYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:24:38 -0400
Received: from [172.17.0.2] (unknown [186.137.130.251])
        (Authenticated sender: pablo@fliagreco.com.ar)
        by mail2.sp2max.com.br (Postfix) with ESMTPA id 023877B05A2;
        Thu,  2 May 2019 07:24:30 -0300 (-03)
Subject: Re: [linux-sunxi] Re: [PATCH v5 2/7] ARM: dts: sun8i: v40:
 bananapi-m2-berry: Add GPIO pin-bank regulator supplies
To:     maxime.ripard@bootlin.com
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1556040365-10913-1-git-send-email-pgreco@centosproject.org>
 <1556040365-10913-3-git-send-email-pgreco@centosproject.org>
 <20190502073815.56ktbpiieviqr4ss@flea>
From:   =?UTF-8?Q?Pablo_Sebasti=c3=a1n_Greco?= <pgreco@centosproject.org>
Message-ID: <c1bc4831-ba63-fd51-9e0c-7c988096b1f4@centosproject.org>
Date:   Thu, 2 May 2019 07:24:29 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502073815.56ktbpiieviqr4ss@flea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-SP2Max-MailScanner-Information: Please contact the ISP for more information
X-SP2Max-MailScanner-ID: 023877B05A2.A1029
X-SP2Max-MailScanner: Sem Virus encontrado
X-SP2Max-MailScanner-SpamCheck: nao spam, SpamAssassin (not cached,
        escore=-2.9, requerido 6, autolearn=not spam, ALL_TRUSTED -1.00,
        BAYES_00 -1.90)
X-SP2Max-MailScanner-From: pgreco@centosproject.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


El 2/5/19 a las 04:38, Maxime Ripard escribió:
> On Tue, Apr 23, 2019 at 02:25:59PM -0300, Pablo Greco wrote:
>> The bananapi-m2-berry has the PMIC providing voltage to all the pin-bank
>> supply rails from its various regulator outputs, tie them to the pio
>> node.
>>
>> Signed-off-by: Pablo Greco <pgreco@centosproject.org>
>> ---
>>   arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>> index f05cabd..2cb2ce0 100644
>> --- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>> +++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>> @@ -123,6 +123,16 @@
>>   	status = "okay";
>>   };
>>
>> +&pio {
>> +	pinctrl-names = "default";
> A pinctrl-names property without any other one?
>
> Looks good otherwise, thanks
> Maxime
Right, I'll move this to the patch that adds pinctrl-0
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
Pablo
