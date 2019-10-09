Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8B3ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 04:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F2021835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 04:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbfJIEjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 00:39:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:34629 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbfJIEjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 00:39:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x994cklP016126;
        Tue, 8 Oct 2019 23:38:47 -0500
Message-ID: <75d915aec936be64ea5ebd63402efd90bb1c29d9.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/3] dt-bindings: net: ftgmac100: Document AST2600
 compatible
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Andrew Jeffery <andrew@aj.id.au>, netdev@vger.kernel.org
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au
Date:   Wed, 09 Oct 2019 15:38:46 +1100
In-Reply-To: <20191008115143.14149-2-andrew@aj.id.au>
References: <20191008115143.14149-1-andrew@aj.id.au>
         <20191008115143.14149-2-andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 22:21 +1030, Andrew Jeffery wrote:
> The AST2600 contains an FTGMAC100-compatible MAC, although it no-
> longer
> contains an MDIO controller.

How do you talk to the PHY then ?

Cheers,
Ben.

> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  Documentation/devicetree/bindings/net/ftgmac100.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ftgmac100.txt
> b/Documentation/devicetree/bindings/net/ftgmac100.txt
> index 72e7aaf7242e..04cc0191b7dd 100644
> --- a/Documentation/devicetree/bindings/net/ftgmac100.txt
> +++ b/Documentation/devicetree/bindings/net/ftgmac100.txt
> @@ -9,6 +9,7 @@ Required properties:
>  
>       - "aspeed,ast2400-mac"
>       - "aspeed,ast2500-mac"
> +     - "aspeed,ast2600-mac"
>  
>  - reg: Address and length of the register set for the device
>  - interrupts: Should contain ethernet controller interrupt

