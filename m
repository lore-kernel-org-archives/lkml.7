Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B752C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B32206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbfHAHNR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:13:17 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:38977 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbfHAHNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:13:17 -0400
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B3C0A100005;
        Thu,  1 Aug 2019 07:13:12 +0000 (UTC)
Date:   Thu, 1 Aug 2019 09:13:10 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     marek.vasut@gmail.com, bbrezillon@kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, vigneshr@ti.com, richard@nod.at,
        robh+dt@kernel.org, stefan@agner.ch, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        juliensu@mxic.com.tw, paul.burton@mips.com, liang.yang@amlogic.com,
        lee.jones@linaro.org, anders.roxell@linaro.org,
        christophe.kerello@st.com, paul@crapouillou.net,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] dt-bindings: mtd: Document Macronix raw NAND
 controller bindings
Message-ID: <20190801091310.035bc824@xps13>
In-Reply-To: <1564631710-30276-3-git-send-email-masonccyang@mxic.com.tw>
References: <1564631710-30276-1-git-send-email-masonccyang@mxic.com.tw>
        <1564631710-30276-3-git-send-email-masonccyang@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

Mason Yang <masonccyang@mxic.com.tw> wrote on Thu,  1 Aug 2019 11:55:10
+0800:

> Document the bindings used by the Macronix raw NAND controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  Documentation/devicetree/bindings/mtd/mxic-nand.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/mxic-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mxic-nand.txt b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
> new file mode 100644
> index 0000000..de37d60
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
> @@ -0,0 +1,19 @@
> +Macronix Raw NAND Controller Device Tree Bindings
> +-------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "mxicy,multi-itfc-v009-nand-morph"
> +- reg: should contain 1 entry for the registers
> +- interrupts: interrupt line connected to this raw NAND controller
> +- clock-names: should contain "ps", "send" and "send_dly"
> +- clocks: should contain 3 phandles for the "ps", "send" and
> +	 "send_dly" clocks
> +
> +Example:
> +
> +	nand: nand-controller@43c30000 {
> +		compatible = "mxicy,multi-itfc-v009-nand-morph";

"mxicy" looks strange to me, I know it has been used in the past and
cannot be removed, but I don't think it is wise to continue using it
while your use "mxic" in all your other contributions. I would update
the prefix to mxic here and fill-in the relevant doc.

Also, what is nand-morph? I thought we were okay for
the "-nand-controller" suffix.


Thanks,
Miquèl
