Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499E3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1968F20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367109;
	bh=PWgtplNi9MeOfRHF/wUemlUkE0j9YqSbGEyR6V/E8kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fDtfOG/dyTx6F8cRF/+3MBY/R77w1cySnh2bl6QgG731Sj1rieS1GsKS6jRVWbFYq
	 rNdGPIMc98HzPglRx7x81AsosS96Ae98y0B1gGkICOVCplJjqGzGNmLKKBAopJysek
	 y9cAqtVtvI8BVVJpVYj2KRgj/8xm7pkm27H+v6jU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbfB1PS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:18:27 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46497 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfB1PS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:18:26 -0500
Received: by mail-ot1-f65.google.com with SMTP id c18so17915021otl.13;
        Thu, 28 Feb 2019 07:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rrUI3DpLUqlevhHM1+N3cZFDvFtGfUPnpY6hijSO1bI=;
        b=XRIRsW4qn00V0N9wbIHPbpBeCUPhftwt64yQbFEpkTCqfYQ0SHPxqzyX1sKv3lMBEJ
         34gCs5xXqNOzaSKbbWgntT0q+KTN7uStMPqHt8x+gYGl4XNyXmLALhKnGmD1DV3nZaMV
         RvrvZQ2mVXZa2mprlx52NRqR6YN1M1IyJOjmvzlzXLEKXuXBl9KESB9HhEpFdTKCHzyU
         bbK5nRnMPaZk+PQL+W2WKXCLdZ3hxXrsspCbSX4iFjbayT/WnaJq0Vgf8NdQVsHzDf32
         ISo7Kx0L0awBQ+02aCW/FHBDBBwjIoBJb76QlfiYRqXgQY20551lpF0PclXavnS/DTZO
         XOaA==
X-Gm-Message-State: APjAAAXYaRH+l1K60rfw9z/9qhhzYA64MnsMLr90y5U1zzDTR1CmfxfQ
        mooaxQKNNahsM9Aq+u4aGw==
X-Google-Smtp-Source: APXvYqytrjuxaDhpiDPmXoWwVGNogQTyuG2It+qETpx4AEGr1RmtQ7HG9aDgctV/KQHPUwolG586vw==
X-Received: by 2002:a9d:5906:: with SMTP id t6mr59309oth.308.1551367104931;
        Thu, 28 Feb 2019 07:18:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 9sm1680046oid.22.2019.02.28.07.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 07:18:24 -0800 (PST)
Date:   Thu, 28 Feb 2019 09:18:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: phy: Add Amlogic G12A USB2 PHY Bindings
Message-ID: <20190228151823.GA20865@bogus>
References: <20190212151413.24632-1-narmstrong@baylibre.com>
 <20190212151413.24632-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212151413.24632-2-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 16:14:06 +0100, Neil Armstrong wrote:
> Add the Amlogic G12A Family USB2 OTG PHY Bindings
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/phy/meson-g12a-usb2-phy.txt      | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
