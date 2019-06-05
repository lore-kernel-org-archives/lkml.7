Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9105FC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5AE20870
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfFELUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:20:25 -0400
Received: from foss.arm.com ([217.140.101.70]:57812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbfFELUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:20:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADF07374;
        Wed,  5 Jun 2019 04:20:24 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EDB53F5AF;
        Wed,  5 Jun 2019 04:20:24 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id D81B6682412; Wed,  5 Jun 2019 12:20:22 +0100 (BST)
Date:   Wed, 5 Jun 2019 12:20:22 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v1 2/2] dt/bindings: drm/komeda: Adds SMMU support for
 D71 devicetree
Message-ID: <20190605112022.GU15316@e110455-lin.cambridge.arm.com>
References: <1556605118-22700-1-git-send-email-lowry.li@arm.com>
 <1556605118-22700-3-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556605118-22700-3-git-send-email-lowry.li@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 07:19:34AM +0100, Lowry Li (Arm Technology China) wrote:
> Updates the device-tree doc about how to enable SMMU by devicetree.
> 
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  Documentation/devicetree/bindings/display/arm,komeda.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/arm,komeda.txt b/Documentation/devicetree/bindings/display/arm,komeda.txt
> index 02b2265..b12c045 100644
> --- a/Documentation/devicetree/bindings/display/arm,komeda.txt
> +++ b/Documentation/devicetree/bindings/display/arm,komeda.txt
> @@ -11,6 +11,10 @@ Required properties:
>        - "pclk": for the APB interface clock
>  - #address-cells: Must be 1
>  - #size-cells: Must be 0
> +- iommus: configure the stream id to IOMMU, Must be configured if want to
> +    enable iommu in display. for how to configure this node please reference
> +        devicetree/bindings/iommu/arm,smmu-v3.txt,
> +        devicetree/bindings/iommu/iommu.txt
>  
>  Required properties for sub-node: pipeline@nq
>  Each device contains one or two pipeline sub-nodes (at least one), each
> @@ -44,6 +48,9 @@ Example:
>  		interrupts = <0 168 4>;
>  		clocks = <&dpu_mclk>, <&dpu_aclk>;
>  		clock-names = "mclk", "pclk";
> +		iommus = <&smmu 0>, <&smmu 1>, <&smmu 2>, <&smmu 3>,
> +			<&smmu 4>, <&smmu 5>, <&smmu 6>, <&smmu 7>,
> +			<&smmu 8>, <&smmu 9>;
>  
>  		dp0_pipe0: pipeline@0 {
>  			clocks = <&fpgaosc2>, <&dpu_aclk>;
> -- 
> 1.9.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
