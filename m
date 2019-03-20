Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328EAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91AE2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JxziM4PI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfCTFFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:05:12 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:33501 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfCTFFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:05:12 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190320050509epoutp020885a779ff2533289035225a47e28b60~Nkk3rpOeB1918319183epoutp02N
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 05:05:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190320050509epoutp020885a779ff2533289035225a47e28b60~Nkk3rpOeB1918319183epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553058309;
        bh=4Ce7XFj0btp0zV5a/xpebOI/wXq9NQrb4f1Hrl4XJ2Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JxziM4PI7urjyfTGhihwyraQgEpT01frHKgmXGnCnRfirAY0VJy9CEWpMBA7FqBcJ
         CQnEn7wpc/tzvEpufAL2CuDEETUeOWuhoSFW5M88q5JIQ7BR8YDusiKhIsGYo51a2r
         Ei5Xug69MSbk5TyDk7HgDli3SA4d+lf4fNSISQMY=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190320050506epcas1p4229dd2019922cdc10fd716534f731037~Nkk08y3Nt0472804728epcas1p4P;
        Wed, 20 Mar 2019 05:05:06 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.3F.04143.20AC19C5; Wed, 20 Mar 2019 14:05:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190320050506epcas1p34dc500e2204b848726bda1ee12473b2c~Nkk0MUny41184911849epcas1p3h;
        Wed, 20 Mar 2019 05:05:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190320050506epsmtrp17361c077b5d0fbad7e63d43689e0f228~Nkk0LO7Lc0986909869epsmtrp1m;
        Wed, 20 Mar 2019 05:05:06 +0000 (GMT)
X-AuditID: b6c32a37-f31ff7000000102f-01-5c91ca028238
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.1C.03662.10AC19C5; Wed, 20 Mar 2019 14:05:06 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190320050505epsmtip12e5b2c51b8619fb0ee310eefd0076337~Nkkz9UQrN2718027180epsmtip1M;
        Wed, 20 Mar 2019 05:05:05 +0000 (GMT)
Subject: Re: [PATCH v2 5/5] arm64: dts: rockchip: Enable dmc and dfi nodes
 on gru.
To:     =?UTF-8?Q?Ga=c3=abl_PORTAY?= <gael.portay@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Derek Basehore <dbasehore@chromium.org>,
        Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, kernel@collabora.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <3adc4347-7dd9-106f-e564-26d39ff38ffb@samsung.com>
Date:   Wed, 20 Mar 2019 14:05:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319181323.22804-6-gael.portay@collabora.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHc9+vFl3ds4Bc2Zz1LUsGodBHLVyNZSSa5W0ah8EQ05B0L/DW
        EvorfcXM/XAwN0cZOhjxV4vVjKKTsYAFHMIMWWmisNDNGdgyQ8KgU0ACmYSNKKxr+9jGf59z
        zzn3e7/n3ivHlVEqXV5hcwlOG29hqA3EjcEMtRobbizVRH35aHb8CUCBPxZINNv1LYUuhcIk
        GrnyHYXa7wcB8vfNUSg6+YhEy53DOOoK15NoqekqhkY+nJOhwNQYie71NVNo8VQIoMcTURy1
        /nwXQ/drvqTQx7dCssJkrt3XDjhv9V2C6x33Ay7Q5qa4Lv8H3KpngOBOd7cB7psxH86dGD9H
        cl9PdhLcYuCFoo2Gyj1mgS8XnCrBVmYvr7CZ9Mz+YuNeoy5Pw6rZXSifUdl4q6Bn9h0oUr9a
        YYn5Y1RHeUtVbKmIF0Ump2CP017lElRmu+jSM4Kj3OLY5cgWeatYZTNll9mtu1mNJlcXK3yz
        0uz/fAZ3tKS9vRL5DVSDIWUdSJJDeie8Pd1M1oENciXdC+DMrA9IwWMAR89+j0vBnwCu/n1a
        9l/LXINMStwCsGVwgownlPQCgOHFN+KcTB+GPefDWLwohb5Kwq9+6gPxBE7rYc31p1icKToT
        Dkz/QsX5WXoHHF2eStQo6AJYe8qLx5mgX4IfPRhOKKfSR+DC7/2EVLMZDl2IJDiJfgUG634g
        pP3T4K+RS5jE2+GJHm/CAqSXZLBx/lNKsrAPTobchMTJcPZ295q1dDjz2ck1fhdeGwpRUnMt
        gN0DP5JSQgsHWptiCvKYQgbs6MuRxDbB+aV6Mr4MaQWsPbk24BfhvYlxTOKtsOUT99oROHj2
        QhBrADs86+x41lnwrLPg+V/sMiDawBbBIVpNgsg6tOuvOwASjz8zvxd0hg8EAS0HzDOKOxMN
        pUqSPyoeswYBlONMisLJN5YqFeX8sXcEp93orLIIYhDoYtNuxNNTy+yxr2RzGVldrlarRTvZ
        PB3LMmmKjsK9pUraxLuESkFwCM5/+zB5Uno1OPxe8TbDlF6jrWcKrj068jTyMC9rfndR9GJJ
        iUH/+rlcS+Qt/ubG7Zu97kJz0iC3fLywI/AEHkx5cNE4zRjUq94z1ZF+/2vFdw6t5PuyR1cM
        WbIck0rtOPjFWOrWvxZHKK6n341l3zz+/qZtz3kyzjS9/HzNQtbDLc0lk614//kxhhDNPJuJ
        O0X+H2PksXESBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7bCSnC7TqYkxBj8yLV7d/cVosenje1aL
        V5v3sFnMP3KO1eLssoNsFmtuH2K0WLLrDZvF/0evWS1+bDjFbLH5XA+rxdfJy5kszja9YbfY
        9Pgaq8XlXXPYLD73HmG0+PTgP7PF0usXmSxuN65gs2jde4TdQdhjzbw1jB6zGy6yeOy4u4TR
        Y9OqTjaPzUvqPf7O2s/i0bdlFaPH9mvzmD2a705n9Vj7aAOLx+dNcgHcUVw2Kak5mWWpRfp2
        CVwZSya9ZC5YLF7x58lDxgbGk0JdjJwcEgImEsffTGDvYuTiEBLYzSixcdILRoiEpMS0i0eZ
        uxg5gGxhicOHiyFq3jJKdP37zwZSIywQInFo8g1mkISIwEpWiamz1rKDJJgFbCUaN/5mgug4
        ziixacdtsKlsAloS+1/cAOvmF1CUuPrjMVicV8BOoqN3NjOIzSKgKtHy7BTYIFGBCIm7F1+w
        QNQISpyc+QTM5hSwlzjUdZ4FYpm6xJ95l5ghbHGJW0/mM0HY8hLNW2czT2AUnoWkfRaSlllI
        WmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4AWhp7WA8cSL+EKMAB6MS
        D++JBxNihFgTy4orcw8xSnAwK4nwFiVOjBHiTUmsrEotyo8vKs1JLT7EKM3BoiTOK59/LFJI
        ID2xJDU7NbUgtQgmy8TBKdXAqN3E9USB54rMRasN+ubnBUzTYzb4rnJT21AnNntG/sPlJ23P
        XQyOnZjBHLZFY/K+WXvYRWfeL7roXsNw6drpW+nz59qusWD9JL7vyYGK1x90np7g/NQtu0dP
        Kadhhl5hC5++8espBc48NowfEzRfhb76vT7n2+lVwlmOHo2HU3Y+158eyqK/XomlOCPRUIu5
        qDgRANDBlKv8AgAA
X-CMS-MailID: 20190320050506epcas1p34dc500e2204b848726bda1ee12473b2c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190319181359epcas4p11159b40adf1c883d179e18356d4cbd30
References: <20190319181323.22804-1-gael.portay@collabora.com>
        <CGME20190319181359epcas4p11159b40adf1c883d179e18356d4cbd30@epcas4p1.samsung.com>
        <20190319181323.22804-6-gael.portay@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gaël,

On 19. 3. 20. 오전 3:13, Gaël PORTAY wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> Enable the DMC (Dynamic Memory Controller) and the DFI (DDR PHY Interface)
> nodes on gru/kevin boards so we can support DDR DVFS.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> ---
> 
> Changes in v2:
> - [PATCH 8/8] Move center-supply attribute of dmc node in file
>               rk3399-gru-chromebook.dtsi (where ppvar_centerlogic is
> 	      defined).
> 
> Changes in v1: None
> 
>  .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  4 ++++
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 20 +++++++++++++++++++
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  2 +-
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> index 931640e9aed4..cfb81356c61e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> @@ -400,3 +400,7 @@ ap_i2c_tp: &i2c5 {
>  		rockchip,pins = <0 8 RK_FUNC_GPIO &pcfg_pull_none>;
>  	};
>  };
> +
> +&dmc {
> +	center-supply = <&ppvar_centerlogic>;
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> index da03fa9c5662..d14dce679e7a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -289,6 +289,12 @@
>  	status = "okay";
>  };
>  
> +&dmc_opp_table {
> +	opp04 {
> +		opp-suspend;
> +	};
> +};
> +
>  /*
>   * Set some suspend operating points to avoid OVP in suspend
>   *
> @@ -368,6 +374,10 @@
>  		<200000000>;
>  };
>  
> +&display_subsystem {
> +	devfreq = <&dmc>;
> +};

When I checked the rockchip_drm_drv.c on linux-next.git (20190320),
there are no any codes about this. Maybe it should be removed.

> +
>  &emmc_phy {
>  	status = "okay";
>  };
> @@ -489,6 +499,16 @@ ap_i2c_audio: &i2c8 {
>  	status = "okay";
>  };
>  
> +&dfi {
> +	status = "okay";
> +};
> +
> +&dmc {
> +	status = "okay";
> +	upthreshold = <25>;
> +	downdifferential = <15>;
> +};
> +
>  &sdhci {
>  	/*
>  	 * Signal integrity isn't great at 200 MHz and 150 MHz (DDR) gives the
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 8fe86a3e7658..010b3e5267a0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -156,7 +156,7 @@
>  		};
>  	};
>  
> -	display-subsystem {
> +	display_subsystem: display-subsystem {
>  		compatible = "rockchip,display-subsystem";
>  		ports = <&vopl_out>, <&vopb_out>;
>  	};
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
