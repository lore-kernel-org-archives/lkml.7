Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791CBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3588B2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553730223;
	bh=3H91yTnlmYLSB3g9sniguGrQ5U4UG59dCRzHA2puXZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ak4WdVz7mKcLUxa37QWq6sOLVzvly66XpQD62WHNbVxP4UIOQTwallxgfQQRcNYUy
	 AGhzfmbxp+rgmHLMvEvotQYIT0QxMYcr/0aFBIhg9bQfeBtwoQ+ALDsnV6Jes0zgY5
	 YQwU7MR7e/ifRJrFeEaoiTQcP/2DSQnwkn8D9gac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbfC0Xnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:43:42 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45579 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfC0Xni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:43:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id y84so14324872oia.12;
        Wed, 27 Mar 2019 16:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tcNph9Id69E8YhpBRkzJlYXeaGJpvhJ4H1oJ7noArf4=;
        b=pHwOGUxMNXvTkyliOX1003htPwTbZmse65VrB55csnC2gIU1lkjT0eN2IsyrLphrom
         t6MITnFmUHmuFgitJ5cHNoQg4JbUBgU3mBT0ru7GM+Ks6SaRv0etJz4nSKM9UM4K5APj
         RT/pIXM2IBvidynqNikKWlNvp+HuomYfnr5usBEckex2vq898GkuAgZlr4yYpPbJLih1
         bTiw3DaLCFI8PGdcb7Ff4fetpDLVczenFs9YDijxtGNWX1/Nocqm+pWOMIgbCzVfYdUY
         AavxpJPpSKqAZUdw0KKabuwgLx67s0GQWGk5O5m/8q+ZK5Sv2B55uX6gz2YpMS3YlRJf
         yNzA==
X-Gm-Message-State: APjAAAWNnRXgmkEv9MhfJv7hVuSyg+OEYDU52OtvMUJisGXvOe1W5Dcf
        gugxZ7dzidhW1pJ+tESylk+8CiI=
X-Google-Smtp-Source: APXvYqwZ37Ax9Wip1cheKrD17VWGGSjdCdqC1GQnBJrUBPgfc681U2qv1liHAycHGCUo+mBfxAWXfA==
X-Received: by 2002:aca:3c8a:: with SMTP id j132mr11824869oia.38.1553730217755;
        Wed, 27 Mar 2019 16:43:37 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 66sm2927148otn.39.2019.03.27.16.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 16:43:37 -0700 (PDT)
Date:   Wed, 27 Mar 2019 18:43:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: remoteproc: Rename qcom,adsp binding
 document
Message-ID: <20190327234336.GA20438@bogus>
References: <20190306232220.32722-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306232220.32722-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Mar 2019 15:22:20 -0800, Bjorn Andersson wrote:
> The qcom,adsp binding document has evolved to cover the mechanism to
> load and boot firmware on a range of different Hexagon based remote
> subsystems. Rename the binding and update the description to better
> capture this.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../{qcom,adsp.txt => qcom,q6v5-pas.txt}          | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>  rename Documentation/devicetree/bindings/remoteproc/{qcom,adsp.txt => qcom,q6v5-pas.txt} (88%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
