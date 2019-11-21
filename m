Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D063BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E49A20708
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574367605;
	bh=tLTI+rrMTmofvOGL7fPngNOUF+n7CrK8+TfuJYXHWWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MtSVD7CsqBaEBX8Ec53RAjTASB9Sw/Gu0fwaron8M12f8z0EO3UexA/+RcD9ybM43
	 zdv/Z8bMNUvBlZdp8RzzoIL0OBDvkBqMm9QvqoUeLQWyuHw/RD7XIe3bUEBylSu1dX
	 FZla8RCfJqv0E20R94VK4RtR+LkxNoP6YbgbLdig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKUUUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:20:04 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32966 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUUUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:20:04 -0500
Received: by mail-oi1-f195.google.com with SMTP id m193so4459564oig.0;
        Thu, 21 Nov 2019 12:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ctEbvEF+D3upIcOL5VXM4n468EvW3StUvGyLExGsOyc=;
        b=TxR6rwohsnIVpmpfmd6k+cMZ7qFf6mPk0C60hSW3OUSw+w992KFwbk0cSKaC8/HcbK
         UN6f+Ep1zESf9cz2YYEO02j0pCDy1dQaJdw6CU3h7DeFIFvvN28Eiil0t73tGPtPWNNw
         xxsL1ElQxQwZ7BfJHqhq89lVviYAuRNUlBdZmHUEVT1oKeSV1JxmvFHTR5NVkt7o4gMr
         ock0g7GUsQxg4spCz8v3DxMvkC0N79vry0Q86ja6D7ygH2nbW5KEAHKn7/GN5TzqCdfw
         etB8bVgBo/+M/14bY8w3l/O7B5lQobmsE88Ce58NdnMwVDZBJGq7BcVCvzJUoEyDTxir
         KneA==
X-Gm-Message-State: APjAAAUJIrzeinkdJH5F9y4DM4q6UEsyuyr71Y4BKmdUrFhyrMoPom7y
        PKQtZ3a3UqAy/jBcKa4NMA==
X-Google-Smtp-Source: APXvYqxt9oXGFEJN7MoDV16iEhPuS0xuVhs0yYo1/QRqf/rvK8UqBXM9F42AdY5F2UufMMuGLxwOcw==
X-Received: by 2002:a05:6808:8ce:: with SMTP id k14mr9093989oij.76.1574367603254;
        Thu, 21 Nov 2019 12:20:03 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l18sm1341155oti.11.2019.11.21.12.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 12:20:02 -0800 (PST)
Date:   Thu, 21 Nov 2019 14:20:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, marc.w.gonzalez@free.fr,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH v10 2/4] dt-bindings: clock: Convert qcom,mmcc to DT
 schema
Message-ID: <20191121202001.GA19935@bogus>
References: <1574025887-32667-1-git-send-email-jhugo@codeaurora.org>
 <0101016e7b4311fe-8edd7849-df65-47dd-98fa-1e2063c83178-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016e7b4311fe-8edd7849-df65-47dd-98fa-1e2063c83178-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Nov 2019 21:27:03 +0000, Jeffrey Hugo wrote:
> Convert the qcom,mmcc-X clock controller binding to DT schema.  Add the
> protected-clocks property to the schema to show that is it explicitly
> allowed, instead of relying on the generic, pre-schema binding.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,mmcc.txt        | 28 ----------
>  .../devicetree/bindings/clock/qcom,mmcc.yaml       | 60 ++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,mmcc.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
