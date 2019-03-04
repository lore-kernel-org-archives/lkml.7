Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A12C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA3520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfCDOAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:00:19 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:10155 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfCDOAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:00:18 -0500
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x24E07Yj038829;
        Mon, 4 Mar 2019 23:00:07 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Mon, 04 Mar 2019 23:00:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.2] (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x24E06W5038823
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 4 Mar 2019 23:00:06 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: fix cts, rts pin assign of
 UART3 for rk3399
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190219140800.12624-1-katsuhiro@katsuster.net>
 <20190219140800.12624-2-katsuhiro@katsuster.net>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <79bf4a6a-59d1-7478-3a28-20ac6c1a44e9@katsuster.net>
Date:   Mon, 4 Mar 2019 23:00:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190219140800.12624-2-katsuhiro@katsuster.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

On 2019/02/19 23:08, Katsuhiro Suzuki wrote:
> This patch fixes pin assign of cts and rts signal of UART3.
> 
> Currently GPIO3_C2 and C3 pins are assigned but TRM says that
> GPIO3_C0 and C1 are correct.
> 
> Refer:
>    RK3399 TRM v1.4 - Table 19-1 UART Interface Description
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 76fc2c7af80a..beaa92744a64 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -2535,12 +2535,12 @@
>   
>   			uart3_cts: uart3-cts {
>   				rockchip,pins =
> -					<3 RK_PC2 RK_FUNC_2 &pcfg_pull_none>;
> +					<3 RK_PC0 RK_FUNC_2 &pcfg_pull_none>;
>   			};
>   
>   			uart3_rts: uart3-rts {
>   				rockchip,pins =
> -					<3 RK_PC3 RK_FUNC_2 &pcfg_pull_none>;
> +					<3 RK_PC1 RK_FUNC_2 &pcfg_pull_none>;
>   			};
>   		};
>   
> 

