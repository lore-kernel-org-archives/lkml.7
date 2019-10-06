Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB3EC4740A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 02:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7323222CE
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570327231;
	bh=c+PDK9PdBWeKgicXAkks/m/JE6AGhT/LowZoiedqZro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mLH3lp0LZJxcSVW+VpPvUlAtK0fJbIBEYn6Sfp8ZdW+b0bjS9OXMsSd7V5NoTnB+G
	 pL3F2neamv39ljZDNyCQwWqXEB3M2ZOXKc3khX3zgkpjJSQ3D7DuoHEXicYvqUu1f7
	 Ds2uOKAUPuJrSRdw8MuyiffknwFoaDl25WwSatWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfJFCAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 22:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJFCAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 22:00:30 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E53A218AC;
        Sun,  6 Oct 2019 01:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570327229;
        bh=c+PDK9PdBWeKgicXAkks/m/JE6AGhT/LowZoiedqZro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fR5wuOg5eKsMSOc4WOitA6WL61fR4NMKj+yAPKAo51oRtS1FuQwft2UTm46fefZWI
         fq74W2Ux64Wiil1DSbB3MljCikBphpo5Af9hVuVpn5o0eE6SaeOcfx70RYWhq38n3+
         m0pejNP7trXxFEtmLaMpzsYoPY/iN+/KFLlC68m4=
Date:   Sun, 6 Oct 2019 09:59:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Eddy Petrisor <eddy.petrisor@nxp.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: arm: fsl: Add the S32V234-EVB board
Message-ID: <20191006015942.GK7150@dragon>
References: <20190905115803.19565-1-stefan-gabriel.mirea@nxp.com>
 <20190905115803.19565-2-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190905115803.19565-2-stefan-gabriel.mirea@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 11:58:32AM +0000, Stefan-gabriel Mirea wrote:
> From: Eddy Petrișor <eddy.petrisor@nxp.com>
> 
> Add entry for the NXP S32V234 Customer Evaluation Board to the board/SoC
> bindings.
> 
> Signed-off-by: Eddy Petrișor <eddy.petrisor@nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

I'm about to apply the patches, but found the messages are using base64
Content-Transfer-Encoding, which is difficult for me to apply patch
from.  Please fix it and resend.

Shawn

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 7294ac36f4c0..597c563bdec9 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -309,4 +309,10 @@ properties:
>                - fsl,ls2088a-rdb
>            - const: fsl,ls2088a
>  
> +      - description: S32V234 based Boards
> +        items:
> +          - enum:
> +              - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
> +          - const: fsl,s32v234
> +
>  ...
> -- 
> 2.22.0
> 
