Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44773C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A87F2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="PnnSa2cR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfFQJli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:41:38 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33060 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbfFQJli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:41:38 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5H9aLRw019974;
        Mon, 17 Jun 2019 11:41:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=WZehqQgVkFhvfsisL+y7tm5FQFwE1NGQqYaPz62rGtM=;
 b=PnnSa2cRQ0JYexC1sWAn2LHmqBAp8oVT19QL/zKidBH9SWP9MlKIGAt4eLLHJSTnuURN
 y42bVuO5r78/RnFvzgdT8WV/ep1hzovwvSAq1ZVl73oQCK/KZkuHJXPTLuUW2XZTtKVW
 mYbLkpWJdSzv2HvxUazi5j9/b/qSGLtjQ8V2QwEdLzZ3GFBvkBvjdAf4TkC2wPNFoeI6
 7OiqjW9ZNw3Vc4LSYaxESgUds88ExrZJ9GOfCpBF71vSM5iW2f1SA6o7qtG3jT2/xGIE
 3usljuP2sG07MqqfzmgzMZ8oSgUy31rlR92zhPoMolKmXk6vmL2lE6nn9OFk6j/jcWwI Ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t4qjhsq6w-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 17 Jun 2019 11:41:25 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 20C4B3A;
        Mon, 17 Jun 2019 09:41:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C1F1A25C4;
        Mon, 17 Jun 2019 09:41:23 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 17 Jun
 2019 11:41:23 +0200
Subject: Re: [PATCH] ARM: dts: stm32: add power supply of rm68200 on
 stm32mp157c-ev1
To:     =?UTF-8?Q?Yannick_Fertr=c3=a9?= <yannick.fertre@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <1558450998-13451-1-git-send-email-yannick.fertre@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <fe5206ed-4e6b-1b2a-0283-bdc8e44270dc@st.com>
Date:   Mon, 17 Jun 2019 11:41:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1558450998-13451-1-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick

On 5/21/19 5:03 PM, Yannick Fertré wrote:
> This patch adds a new property (power-supply) to panel rm68200 (raydium)
> on stm32mp157c-ev1.
> 
> Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c-ev1.dts | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> index 8ef2cb0..50f3263 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> @@ -127,6 +127,7 @@
>   		reg = <0>;
>   		reset-gpios = <&gpiof 15 GPIO_ACTIVE_LOW>;
>   		backlight = <&panel_backlight>;
> +		power-supply = <&v3v3>;
>   		status = "okay";
>   
>   		port {
> 

Applied on stm32-next.

Thanks.
Alex
