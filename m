Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BA0FC6196
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2BE21848
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573088471;
	bh=+HV8Ak3oWRWUlVdn18PAONdk2DTT2tF4m627c1XJzK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HyKYqikPxc/+aajxlEPe76SyD0LC7zMOPKHuzXzAKu5y9BZYnypOkv6QEauURNGIc
	 8dmdyluuWVIAjFQBwMkJ6Lv/2INeefBISFO9tZVpQSOCM72rtsigG86VeBD1trp9zp
	 E9/9SCS0i+HnzSJhGvgoiCZgTje/xuPRsqQ+rzaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbfKGBBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 20:01:10 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32923 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKGBBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 20:01:10 -0500
Received: by mail-ot1-f65.google.com with SMTP id u13so548623ote.0;
        Wed, 06 Nov 2019 17:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0UuYlDNlg6CYP1umbuTYzjw05bILsaabq8J86syVD2w=;
        b=KMk3J6hksWfQ2mfvBVfiaIKbl7PG2K8xnZRaHVJfztYDrs4DNajfRQGlviarxeIhpu
         w9A/G/pdF6kLfz8nFwFdcrydilw3G+9NopLB/EiCHbBTH5UtrnU+RsKkQfHKYrDG67HU
         2wIfhsEpryOwtDCl1YE16FIUf/t4wfRZqhR2z4KZWUcwk7OHPWc9fOTqNWCgy8MsEGKk
         0bvArElW6w9bRiOa7QuywDM5Hzi7k2ZzG7yzk46xVUa1hPMcIbQfjRqnYFZ7RK0Gyr/Z
         vf/FWXho1SWkE7RHl8HmYheVblyDe6ewQR7m/0RZ6NsbXQKyWUCIn9Id2o8wY/B0Wfiy
         z2sw==
X-Gm-Message-State: APjAAAUNM5yvdi0cdXJm0UB7JQ8+3AxFY07RFz7Df6PD0+5ZWB6MPOkH
        tjJT3CFhP5TvpGqJMWaQdoPqfeg=
X-Google-Smtp-Source: APXvYqyOlvqRefihFIqohvXnpjnmLfZkNeSk5z0zxj9LIO/elGrRi5RqBERx/C9tj5eOaNM2qfOfEQ==
X-Received: by 2002:a9d:7410:: with SMTP id n16mr570148otk.3.1573088469199;
        Wed, 06 Nov 2019 17:01:09 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a3sm222078oto.15.2019.11.06.17.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 17:01:08 -0800 (PST)
Date:   Wed, 6 Nov 2019 19:01:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2] dt-bindings: usb: dwc3: Move Amlogic G12A DWC3 Glue
 Bindings to YAML schemas
Message-ID: <20191107010108.GA5321@bogus>
References: <20191106104458.23698-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106104458.23698-1-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Nov 2019 11:44:58 +0100, Neil Armstrong wrote:
> Now that we have the DT validation in place, let's convert the device tree
> bindings for the Amlogic G12A DWC3 Glue Bindings over to a YAML schemas,
> the AXG and GXL glue bindings will be converted later.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Changes since v1:
> - fixed typo in description
> - removed dr-mode definition in favor of "true"
> 
>  .../devicetree/bindings/usb/amlogic,dwc3.txt  |  88 ------------
>  .../usb/amlogic,meson-g12a-usb-ctrl.yaml      | 128 ++++++++++++++++++
>  2 files changed, 128 insertions(+), 88 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> 

Applied, thanks.

Rob
