Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DF2C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABBF21925
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568808905;
	bh=eU5SfvEC9eVdelPlr0dsPa4V0vBKZnCBVBchfJFdAFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NUZOSDLimWhKnAuIC6sEjD0xMFQP7qzR42eyfqQ7hjCJgnIZ4ZloqeP+JgZLa1Xau
	 Kqgwn5fatpQ8ENB0/bXov/FpjnlHB90nsZULUxwiDiLwTmqA68FBQbv70u0+gr5tbz
	 kY5dHTKYPpFY+IcSQ5krHrrvUrzVOy5iohW0zG6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbfIRMPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:15:04 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45815 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbfIRMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:15:04 -0400
Received: by mail-ot1-f66.google.com with SMTP id 41so6050039oti.12;
        Wed, 18 Sep 2019 05:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iwhCp5qcYnf6sA1iPmnMj21Y3p/sdCHl5i/JOjrNkTo=;
        b=JWcmNX9mHjO6yPg7q6T7VIlwSY+o0UtFBDKRwQcHRN8Y42/mR8nFbmlCgf792+ytjq
         p/iUYWLo5IEuJeVB4zSawkBdMIVprO6fBnC+1mEJPwHK8r764VOhg3I1cm8sZCIT5Mve
         hNkivmR6wHgZXn5geHtt5BkBnLAy6ler2AoHOVCOUdQbGetkVJ41ruWS+ckvFnjyh4Xh
         YAVM+8hKOTI/qWfwni+qUnkD406BO0jaUYMi7Yy3iQCW30CKuy5JlZBfef9xkzDdoIFp
         dF0/os4cHICJoL5hZh2u3QqpF/6a34BfTm8GWuTh4Lz7/ReKrlttT+B+YR7VajSVPJly
         BotA==
X-Gm-Message-State: APjAAAWWnfMg33aZslhFfvV5fqbZX+91GxmU5DMWzf90591QXqLhllFv
        PlD+VCbRXhhIwGbziX2adQ==
X-Google-Smtp-Source: APXvYqylx/gSShddZtCWoCwVr8YsIaFdNTEn4984KKX/F9Ola6SeUx0xaI9HwZ9jz5zzmHxuvk370A==
X-Received: by 2002:a9d:7e97:: with SMTP id m23mr2633158otp.324.1568808902856;
        Wed, 18 Sep 2019 05:15:02 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v6sm1721538oie.4.2019.09.18.05.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 05:15:02 -0700 (PDT)
Date:   Wed, 18 Sep 2019 07:15:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: phy-qcom-qmp: Add sm8150 UFS phy
 compatible string
Message-ID: <20190918121501.GA32535@bogus>
References: <20190906051017.26846-1-vkoul@kernel.org>
 <20190906051017.26846-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906051017.26846-3-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Sep 2019 10:40:16 +0530, Vinod Koul wrote:
> Document "qcom,sdm845-qmp-ufs-phy" compatible string for QMP UFS PHY
> found on SM8150.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
