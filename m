Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1ADC04AAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 02:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373C320862
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 02:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558060411;
	bh=qFzo55aPTQ0h2FPJSrknaV9jpOCcM6FrAf3j7KGisb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JSivlLV6PU4FfcTMj7/1tQRy5fERU96rI0INqag+oMRaWkW49dHuWLCU8l25u61oR
	 f4S3/SgqylhE97djJtoNSj7X2dW+vbUqQyB8BNoF5yrcnUb7PbRxnKilbuuu+ZHMfI
	 +6/lp783pgYX53P7Chy9RAMJZHhneM1Bc/ldmg/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfEQCda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 22:33:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfEQCda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 22:33:30 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49603204EC;
        Fri, 17 May 2019 02:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558060409;
        bh=qFzo55aPTQ0h2FPJSrknaV9jpOCcM6FrAf3j7KGisb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=06Q3xxMLF9S+6erhbfe2QZ+U2p8hfbcBrwwxX5oqWXgno/tzMaUw5ksT9Da+3x0LD
         gg3cQMaywfIue7RVgBJn771YdcyoYZvXSH8g+469l874phH4nzZ8x8PL2X+JZLE/Gr
         yLc2LLoe7+QLqlQycG/+aHG9Pqlw/LEzW7CG9ve4=
Date:   Fri, 17 May 2019 10:32:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Pramod Kumar <pramod.kumar_1@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add device tree binding for
 ls1046a-frwy board
Message-ID: <20190517023248.GY15856@dragon>
References: <20190508135501.17578-1-pramod.kumar_1@nxp.com>
 <20190508135501.17578-2-pramod.kumar_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508135501.17578-2-pramod.kumar_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 01:53:08PM +0000, Pramod Kumar wrote:
> Add "fsl,ls1046a-frwy" bindings for ls1046afrwy board based on ls1046a SoC
> 
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Pramod Kumar <pramod.kumar_1@nxp.com>

Sorry. I do not take patch from message using base64 encoding.

Shawn

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 7e2cd6ad26bd..873999bf4a43 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -205,6 +205,7 @@ properties:
>            - enum:
>                - fsl,ls1046a-qds
>                - fsl,ls1046a-rdb
> +              - fsl,ls1046a-frwy
>            - const: fsl,ls1046a
>  
>        - description: LS1088A based Boards
> -- 
> 2.17.1
> 
