Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C59C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2783321D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572983884;
	bh=I7QRqTDJmwYS0vX5sM86Pf1uZEDFPm7/3ej3udmZ4N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QmPaqgWWNW8+htH86P6eczQmhaHjYBk3DQwhlXnVK/86ARUzRKsfPpgN7b/UIdM7x
	 wkpYguD2Gu7y/JLVGhIslB9s794BvOYXfyfTdUzIhFQnMoD+jq0A2bU2NPk4rImxOb
	 KKxPw/x7dsMvgYIJ44hUYRV6E0Xx1zL/V6MGbez0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKET6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:58:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42228 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfKET6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:58:02 -0500
Received: by mail-ot1-f67.google.com with SMTP id b16so18730171otk.9;
        Tue, 05 Nov 2019 11:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x/Pqzh0wjtCm8/DGrbF/d0ukivugFZC6wp2pNvyyKqU=;
        b=YuZ5mrtnQfjAuFFwfdDv4UNqXc+AEdAgz0eE/dx9f+KjqbW+XUS3BK6oJkJg7y2rA9
         xtk4ReZZALvJSQ+1+hjiJ91W4MxHC1BdYG2LHEAbnIO+dGzRIHm+/gNt2YN63iKtFX/Q
         2LVjhu+agnKwBvJZja+rpG/gmnr3RqD+xaeA3uOLtSjuV/VgcRO+klyWPhlRRiJ2x4O6
         RFQFzd1PWg3C1YN1Y6JGEaBZjqV55MISzedWtYOJNj3Nhwnf6gZiXgewBqG+N9nq8U+t
         BVLhIa3KZF9/M6urIkFoWNLPGAPnaX1iYxZZKuZvgxqcn6bloAcDCfezyMhVaDjAeebG
         TSoQ==
X-Gm-Message-State: APjAAAXtDaQFjJBPQajym/d5Y5U6Ik+ESYWOBO7Jc0wDr5CHRRqDuaO0
        g2GeMLzafWikxbj1lI27M7eFIwA=
X-Google-Smtp-Source: APXvYqzVTpLLqzm+L3XsD+1vas5TRGDVn3vLjnHeqDn40MYgszVtjMGB2hevWDiXQ0kvMy5d6Dbxrg==
X-Received: by 2002:a9d:5617:: with SMTP id e23mr3940969oti.208.1572983881547;
        Tue, 05 Nov 2019 11:58:01 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c20sm1533138otm.80.2019.11.05.11.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 11:58:00 -0800 (PST)
Date:   Tue, 5 Nov 2019 13:58:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     p.zabel@pengutronix.de, mark.rutland@arm.com, yuenn@google.com,
        venture@google.com, benjaminfair@google.com,
        avifishman70@gmail.com, joel@jms.id.au, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-binding: reset: add NPCM reset controller
 documentation
Message-ID: <20191105195800.GA16739@bogus>
References: <20191031135617.249303-1-tmaimon77@gmail.com>
 <20191031135617.249303-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031135617.249303-2-tmaimon77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 03:56:15PM +0200, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM reset controller.

'dt-bindings' for the subject.

> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/reset/nuvoton,npcm-reset.txt     | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
> new file mode 100644
> index 000000000000..6e802703af60
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
> @@ -0,0 +1,32 @@
> +Nuvoton NPCM Reset controller
> +
> +Required properties:
> +- compatible : "nuvoton,npcm750-reset" for NPCM7XX BMC
> +- reg : specifies physical base address and size of the register.
> +- #reset-cells: must be set to 2
> +
> +Optional property:
> +- nuvoton,sw-reset-number - Contains the software reset number to restart the SoC.
> +  NPCM7xx contain four software reset that represent numbers 1 to 4.
> +
> +  If 'nuvoton,sw-reset-number' is not specfied software reset is disabled.
> +
> +Example:
> +       rstc: rstc@f0801000 {
> +               compatible = "nuvoton,npcm750-reset";
> +               reg = <0xf0801000 0x70>;
> +               #reset-cells = <2>;
> +               nuvoton,sw-reset-number = <2>;
> +       };
> +
> +Specifying reset lines connected to IP NPCM7XX modules
> +======================================================
> +example:
> +
> +        spi0: spi@..... {
> +                ...
> +                resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_PSPI1>;
> +                ...
> +        };
> +
> +The index could be found in <dt-bindings/reset/nuvoton,npcm7xx-reset.h>.
> --
> 2.22.0
> 
> 
> 
> ===========================================================================================
> The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.


We can't accept patches with this footer.

Rob

