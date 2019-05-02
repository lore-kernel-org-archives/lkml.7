Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5F3C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4112081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556833004;
	bh=PhFXDYLbTsIXi/mvPrnQSUgomlUCPYqmfr7mpc3FhSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c1DXpVcdQsoiqJ4DWLDpXD8yRwfzRppUyJczEAVFz0364giwQ2nGGerygVrlb83F3
	 DiMsAePyYFQivNu58JRWNzm1FcrGfhJMohM36OYXnJ4vjXFQ8qSB6EEecLrezZ6Pcd
	 82YYywHLndQiPlgAg09hlZPb5FPsWHYkfHfAtg/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfEBVgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:36:43 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33273 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBVgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:36:43 -0400
Received: by mail-ot1-f67.google.com with SMTP id s11so3547142otp.0;
        Thu, 02 May 2019 14:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=68ezu1CC+9jQwedrlXKi1B7o3NkSj3TSJKQOha2Am3U=;
        b=oZdJNMNvRp08zZCLpiszpTic6dfJ4mM0cR1DOUZrCXAbNie0W5Vg0CNGxWSjE/uiYC
         9J5kZRDS+c7ynf5ZeONNCJp9FgXqDxC5PbNz9wj49dHiDRUUo2q6ZRC4He5nYmwc9SpV
         EKPgDvNmzbQuE5N9EhHU/xDKY/9SO3GiZjq3dzx01kIHv5ykHo3OhN3L0ZTiGPlDLvaI
         ojtLJWjE5EhXu89uYDLYK54FWe+maZJ/crqSruYi9NkGQd38lSiyLPwzNCtEBwFwL1j7
         rAGNzTsZPgCha7lOcbqyzAvfoa/rmWS39Psb1PEJAe0qi7O66aF2Gwd8jm/Tmgy7fF8/
         SVwQ==
X-Gm-Message-State: APjAAAX/K6X4svGZXM4DSDPPxUp78RHmGXkr50YEFiCs87/K6zu+uCCV
        gPDDlJwgZjI8vZ8eM03i1Q==
X-Google-Smtp-Source: APXvYqyVHjgextdRZdHLuL/OkF0dTrVbN6LNb+8KdVWK52/DvUyad7LssZXEokGeIAvDrcFVsBZDIg==
X-Received: by 2002:a9d:37e6:: with SMTP id x93mr4079435otb.351.1556833002225;
        Thu, 02 May 2019 14:36:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e9sm135608otf.48.2019.05.02.14.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 14:36:41 -0700 (PDT)
Date:   Thu, 2 May 2019 16:36:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: Add binding for Qualcomm PCIe2
 PHY
Message-ID: <20190502213640.GA21552@bogus>
References: <20190502001406.10431-1-bjorn.andersson@linaro.org>
 <20190502001406.10431-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502001406.10431-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 May 2019 17:14:05 -0700, Bjorn Andersson wrote:
> The Qualcomm PCIe2 PHY is a Synopsys based PCIe PHY found in a number of
> Qualcomm platforms, add a binding to describe this.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v2:
> - Add #clock-cells
> 
>  .../bindings/phy/qcom-pcie2-phy.txt           | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
