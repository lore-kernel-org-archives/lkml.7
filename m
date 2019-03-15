Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B9EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297082184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552692189;
	bh=G6rtwSDofx2AzrADwAlrxRce+aG23NrkMT+ORyB/7IQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dyt3j9KNsugX7+dEo1w0tf/bwnSEBRapPClqG+JkcqHf1ATw3hlDOla3aRYhGRfD6
	 iI9+XAVRgjzifLWLLJqGe8fGAVg9RVOUGN8pEppz5INM8UiTi212aDs7pHnw6NLua3
	 1B/uUs+572Sytr9VmG1lMqx18Dwop46JAHSgzlNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfCOXXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:23:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36991 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfCOXXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:23:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id b3so9827412otp.4;
        Fri, 15 Mar 2019 16:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4vWOVw173LlG102bzQxZCjkBSAnfIUTlDyFq5biQERc=;
        b=ZNhld0OkZ0ETiyEnhkoaHpxlFDMD2uzJ/FnDhkzIOGVkJNVwIbDFyaVGZMpcnAOC4/
         6H1LT3wNNE7DsO4UFnDYbeJBMrz0BY/5ZwVbihoyXYSrLVAK1LdPsXm/c7WMyjeuxGIU
         iTSuhYL9z2s/yl3lfrQDzhai2rPQOgpuXL/SjZHxasTfV77cI6njups5/0/Kfx2LWyMD
         0EWctAi9DzqXmFWlnLIMawlPY3TaYML2sW2BQKO5EMAJm6WsxKhZrWXQcfTbNZTjL4dI
         qUQ5jDhYTlwpCRs4JSloDTnnz1aojWECj13CbfyhHU0xLXldSkLhnkTH463VqiC7K4kW
         P8Og==
X-Gm-Message-State: APjAAAWQbGRE5kkF4yfRJK+EDHKORRv6jH82a6+sCjBLeAwYxevRpzze
        59oPrkeVzgtdj2uKI12aPA==
X-Google-Smtp-Source: APXvYqwXsy9xVddmFQwMXMPmPZ4TZIlaLKBENsiCWGrqz+ULAMA/ffZ5SZupXwcqv/xhBOQAtwj71g==
X-Received: by 2002:a9d:7597:: with SMTP id s23mr3693880otk.25.1552692186013;
        Fri, 15 Mar 2019 16:23:06 -0700 (PDT)
Received: from localhost ([2607:fb90:1cdc:ff1d:59ce:35b2:628:2365])
        by smtp.gmail.com with ESMTPSA id c19sm1494396oih.46.2019.03.15.16.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 16:23:04 -0700 (PDT)
Date:   Fri, 15 Mar 2019 18:23:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v5 1/3] dt-bindings: phy: Add Stingray USB PHY binding
 document
Message-ID: <20190315232303.GA17556@bogus>
References: <1552406781-5180-1-git-send-email-srinath.mannam@broadcom.com>
 <1552406781-5180-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552406781-5180-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 09:36:19PM +0530, Srinath Mannam wrote:
> Add DT binding document for Stingray USB PHY.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>  .../bindings/phy/brcm,stingray-usb-phy.txt         | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> new file mode 100644
> index 0000000..51c3d73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> @@ -0,0 +1,40 @@
> +Broadcom Stingray USB PHY
> +
> +Required properties:
> + - compatible : should be one of the listed compatibles
> +	- "brcm,sr-usb-combo-phy" is combo PHY has two PHYs, one SS and one HS.
> +	- "brcm,sr-usb-hs-phy" is a single HS PHY.
> + - reg: offset and length of the PHY blocks registers

> + - address-cells: should be 1
> + - size-cells: should be 0

These can be dropped now. With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> + - #phy-cells:
> +   - Must be 1 for brcm,sr-usb-combo-phy as it expects one argument to indicate
> +     the PHY number of two PHYs. 0 for HS PHY and 1 for SS PHY.
> +   - Must be 0 for brcm,sr-usb-hs-phy.
> +
> +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> +
> +Example:
> +	usbphy0: usb-phy@0 {
> +		compatible = "brcm,sr-usb-combo-phy";
> +		reg = <0x00000000 0x100>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#phy-cells = <1>;
> +	};
> +
> +	usbphy1: usb-phy@10000 {
> +		compatible = "brcm,sr-usb-combo-phy";
> +		reg = <0x00010000 0x100>,
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#phy-cells = <1>;
> +	};
> +
> +	usbphy2: usb-phy@20000 {
> +		compatible = "brcm,sr-usb-hs-phy";
> +		reg = <0x00020000 0x100>,
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#phy-cells = <0>;
> +	};
> -- 
> 2.7.4
> 
