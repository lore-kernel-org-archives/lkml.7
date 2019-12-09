Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81214C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDDD206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="PQllKqhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfLINs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:48:28 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:59458 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfLINs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:48:28 -0500
X-Greylist: delayed 915 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Dec 2019 08:48:27 EST
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1575898389; x=1578490389;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZvMCSjdJbVZac2F8bcYMul/sOO8A2aMaXq5Bl5ynDSM=;
        b=PQllKqhqFuqpazx3wP6CWciKQz6FIX8bGLb+BFM+6vqxpltgk0ZUQHNjHtfTZt2L
        NHN8S+7EHwKLIb1RD5p6EXnd+jcbtXuQXuUmUldCrGGcYCjhri0mlbzBqT6L7PmA
        UqWrHkCla85x1YgmAOmIvGeti+EqP834ZoleWhijArE=;
X-AuditID: c39127d2-df9ff7000000408f-4e-5dee4d0e35f1
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E1.83.16527.E0D4EED5; Mon,  9 Dec 2019 14:33:07 +0100 (CET)
Received: from [172.16.23.108] ([172.16.23.108])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019120914330285-69242 ;
          Mon, 9 Dec 2019 14:33:02 +0100 
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: Add PHYTEC i.MX6 UL/ULL
 devicetree bindings
To:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org,
        Andrew Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-imx@nxp.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
References: <1568980346-385840-1-git-send-email-s.riedmueller@phytec.de>
From:   =?UTF-8?Q?Stefan_Riedm=c3=bcller?= <s.riedmueller@phytec.de>
Message-ID: <f2084e4d-8e62-80fc-e578-d3d4be50af2f@phytec.de>
Date:   Mon, 9 Dec 2019 14:33:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1568980346-385840-1-git-send-email-s.riedmueller@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.12.2019 14:33:02,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.12.2019 14:33:07,
        Serialize complete at 09.12.2019 14:33:07
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42JZI8DApSvq+y7WoPMyv0Vzh63F/CPnWC0e
        XvW32PT4GqtF16+VzBaXd81hs7jb0slqsfT6RSaL1r1H2C3+bt/EYvFii7gDt8eaeWsYPXbO
        usvusWlVJ5vHnWt72Dw2L6n32PhuB5NH/18Dj8+b5AI4orhsUlJzMstSi/TtErgyJi/cwVhw
        UKBi0rqgBsZH3F2MnBwSAiYSW79fYu1i5OIQEtjKKLFv7xkmCOcUo8T6Z2sYQaqEBRIk5h/f
        xA5iiwj4Slxf0cgCYjMLHGKSeNkGNklIwEOi6dApsDibgJPE4vMdbCA2r4CNxJZLW8FsFgEV
        ifntk8DmiApESDzffoMRokZQ4uTMJ2C9nAKeEu+vL2YHOUJCoJFJYnvjQxaIU4UkTi8+ywyx
        WF5i+9s5ULaZxLzND6FscYlbT+YzTWAUmoVk7iwkLbOQtMxC0rKAkWUVo1BuZnJ2alFmtl5B
        RmVJarJeSuomRmCUHZ6ofmkHY98cj0OMTByMhxglOJiVRHiXTHwVK8SbklhZlVqUH19UmpNa
        fIhRmoNFSZx3A29JmJBAemJJanZqakFqEUyWiYNTqoExYMKi50xf/pz7bb3efW9mmW6ZxrKC
        nfyTVgpsbGb6+G5TfpXHGt0zy7f91Oc5EHPf8PFmWbHps498O8Wi2Wc3NSTRQjEl/KSstOs8
        JRVDrutu9i8F7v1bq3i1QbDl/V1Hs3I/m4XrE0uVWE0a1z/dt8ZUIFEhRnd78bIejj/PVHzF
        10tdm3pYiaU4I9FQi7moOBEACOJCtqACAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just wanted to send a gentle ping for these two patches.

Regards,
Stefan


On 20.09.19 13:52, Stefan Riedmueller wrote:
> Add devicetree bindings for i.MX6 UL/ULL based phyCORE-i.MX6 UL/ULL and
> phyBOARD-Segin.
> 
> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
> ---
> Changes in v2:
>   - Use seperate description for each board instead of squashing them into
>     the standard board.
> ---
>   Documentation/devicetree/bindings/arm/fsl.yaml | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 1b4b4e6573b5..c926ff6eac67 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -164,6 +164,15 @@ properties:
>                 - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
>             - const: fsl,imx6ul
>   
> +      - description: i.MX6UL PHYTEC phyBOARD-Segin
> +        items:
> +          - enum:
> +              - phytec,imx6ul-pbacd10-emmc
> +              - phytec,imx6ul-pbacd10-nand
> +          - const: phytec,imx6ul-pbacd10  # PHYTEC phyBOARD-Segin with i.MX6 UL
> +          - const: phytec,imx6ul-pcl063   # PHYTEC phyCORE-i.MX 6UL
> +          - const: fsl,imx6ul
> +
>         - description: Kontron N6310 S Board
>           items:
>             - const: kontron,imx6ul-n6310-s
> @@ -183,6 +192,15 @@ properties:
>                 - fsl,imx6ull-14x14-evk     # i.MX6 UltraLiteLite 14x14 EVK Board
>             - const: fsl,imx6ull
>   
> +      - description: i.MX6ULL PHYTEC phyBOARD-Segin
> +        items:
> +          - enum:
> +              - phytec,imx6ull-pbacd10-emmc
> +              - phytec,imx6ull-pbacd10-nand
> +          - const: phytec,imx6ull-pbacd10 # PHYTEC phyBOARD-Segin with i.MX6 ULL
> +          - const: phytec,imx6ull-pcl063  # PHYTEC phyCORE-i.MX 6ULL
> +          - const: fsl,imx6ull
> +
>         - description: i.MX6ULZ based Boards
>           items:
>             - enum:
> 
