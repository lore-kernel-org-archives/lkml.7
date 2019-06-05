Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584ACC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2284020866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559716508;
	bh=G1fCjyvuMI8j4lJIOPDrdCk2asa1xcNItBYzsfAa+b8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BBtaS4HWRd/xqOdPSjorVqG++prx8cepBHIl29PJjiz/5R1Ndlc0c5x3tkqA/O45y
	 sTHEfJrjtLrD2cA7Qha7eQg4sV+c7jgEiegNZ9bAM+kVwV3hzNCIHmPfVNQUrOWXMM
	 k4kxEhb9NfmMUbjWy3KsQDnHsIwv+vcgXyD8bk50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfFEGfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbfFEGfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:35:07 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0C5E2083E;
        Wed,  5 Jun 2019 06:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559716506;
        bh=G1fCjyvuMI8j4lJIOPDrdCk2asa1xcNItBYzsfAa+b8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RqRNxR+h7FMuAZfrxmvdDUYFY92bSMASxPOtEC8ZNn/Yd1Qw/C4Fe2BvN/f7Fd/BT
         rqgjDOQWs+K3DSzeCHuzfduZAxJ6Q/4c8Gl6idrwDC3T70CKVYe9uttwEfTI74Si+d
         kPn7wVGJ3T0glV1dXNU4ea9sk4EAuEj6GNUwxhds=
Date:   Wed, 5 Jun 2019 14:34:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Pramod Kumar <pramod.kumar_1@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        Leo Li <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: nxp: Add device tree binding
 for ls1046a-frwy board
Message-ID: <20190605063449.GG29853@dragon>
References: <20190527123404.30858-1-pramod.kumar_1@nxp.com>
 <20190527123404.30858-2-pramod.kumar_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527123404.30858-2-pramod.kumar_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 12:32:09PM +0000, Pramod Kumar wrote:
> Add "fsl,ls1046a-frwy" bindings for ls1046afrwy board based on ls1046a SoC
> 
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Pramod Kumar <pramod.kumar_1@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

I cannot apply patch from message using 'Content-Transfer-Encoding: base64'.

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 407138ebc0d0..09ff1999ce96 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -241,6 +241,7 @@ properties:
>            - enum:
>                - fsl,ls1046a-qds
>                - fsl,ls1046a-rdb
> +              - fsl,ls1046a-frwy

It might be better to keep the list alphabetically sorted.

Shawn

>            - const: fsl,ls1046a
>  
>        - description: LS1088A based Boards
> -- 
> 2.17.1
> 
