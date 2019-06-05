Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0723C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2612075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfFELJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:09:02 -0400
Received: from foss.arm.com ([217.140.101.70]:57620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfFELJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:09:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40DAA15AB;
        Wed,  5 Jun 2019 04:09:01 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 051133F5AF;
        Wed,  5 Jun 2019 04:08:57 -0700 (PDT)
Date:   Wed, 5 Jun 2019 12:08:55 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Talel Shenhar <talel@amazon.com>
Cc:     nicolas.ferre@microchip.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh+dt@kernel.org,
        davem@davemloft.net, shawn.lin@rock-chips.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, jonnyc@amazon.com, hhhawa@amazon.com,
        ronenk@amazon.com, hanochu@amazon.com, barakw@amazon.com
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: Amazon's
 Annapurna Labs FIC
Message-ID: <20190605110855.GC20813@e107155-lin>
References: <1559731921-14023-1-git-send-email-talel@amazon.com>
 <1559731921-14023-2-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559731921-14023-2-git-send-email-talel@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 01:52:00PM +0300, Talel Shenhar wrote:
> Document Amazon's Annapurna Labs Fabric Interrupt Controller SoC binding.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> ---
>  .../interrupt-controller/amazon,al-fic.txt         | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt b/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
> new file mode 100644
> index 0000000..a2f31a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
> @@ -0,0 +1,22 @@
> +Amazon's Annapurna Labs Fabric Interrupt Controller
> +
> +Required properties:
> +
> +- compatible: should be "amazon,al-fic"
> +- reg: physical base address and size of the registers
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #interrupt-cells: must be 2.
> +- interrupt-parent: specifies the parent interrupt controller.
> +- interrupts: describes which input line in the interrupt parent, this
> +  fic's output is connected to.
> +
> +Example:
> +
> +amazon_fic: amazon_fic {

above must be:

amazon_fic: interrupt-controller@0xfd8a8500 {

--
Regards,
Sudeep
