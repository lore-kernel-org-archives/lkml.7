Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E30C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4E22064A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553798433;
	bh=uQ5VZ/A1stP+Zub17FUITgQK4q4n9mP4+a2eEtf0Vg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tnUO/g9WOMzVgSz7LlpdL/x8Ez0rN1x97W5R8f6lP5KEleyZt80nlg9LI/CU2Xuqs
	 dRxLlfgTZAgAjRqKpPpebDVdm+F4TlJ72YJyHUG2r9F/pyyPpnhRnoRQQrjNFF1Xod
	 DY5V7GHMplZwaWt/lLub6GWaHkRqrktQYPtX7Zt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfC1Skb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:40:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46275 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfC1Skb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:40:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id s24so9843583otk.13;
        Thu, 28 Mar 2019 11:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ijOdPuSr2U/a+vHqdcUJEaEGQ1lKoFqL0dEsruheFU=;
        b=O2WXCclLvCFpF03I4jXP6bZgQXe/zta7Q+g9IXXZUG9Tpsr6ZQMAFg55h2CGxkCulx
         6Ynnrech/rrNN5x5cW0wepo5FNFFr8T0e7gjPaLRQz7RO/+m7jAn4w5a56odwdGyOEgq
         DAY1oIE43lWe2f/XkG8DJ5g6vwQmCqAAbr80iQfqqOircfryRqAZhorJ1YSayRrzjd+l
         O7CefYuSa3up0dOVxSc1rQOOnrX1pU73FQMQd0VleNFy2o38aHkqTQPg+P6gQUhKhJNE
         Mov+dEt7RA+XItiS5mRF+E73v0klqL7xWMIR0TdDJvXBrt1ReviOrRN5ufd/vNlryGad
         fpQA==
X-Gm-Message-State: APjAAAUioXfZzlm1mQqAV7bxQnr/GDzxYuYzQcjNS7IyfVnNyOKn2kRa
        AT8taxiGjV1vjc3Zm47i9Q==
X-Google-Smtp-Source: APXvYqyiUJ3jx//pCBHqZ/CnqG4JrTH4fThDXZAhsbQHbjGXyEz9RgIav5/834tACJYKe2lPObbIKQ==
X-Received: by 2002:a9d:7691:: with SMTP id j17mr11092900otl.262.1553798430535;
        Thu, 28 Mar 2019 11:40:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z2sm11138834ota.56.2019.03.28.11.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 11:40:29 -0700 (PDT)
Date:   Thu, 28 Mar 2019 13:40:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, rnayak@codeaurora.org,
        david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v3 4/9] dt-bindings: power: Add rpm power domain bindings
 for qcs404
Message-ID: <20190328184029.GA20260@bogus>
References: <20190327123832.11566-1-sibis@codeaurora.org>
 <20190327123832.11566-5-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327123832.11566-5-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 18:08:27 +0530, Sibi Sankar wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add RPM power domain bindings for the qcs404 family of SoC
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> [sibis: Add supported rpmpd states for qcs404]
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> skip adding Rob's R-b due to some additional changes
> https://lore.kernel.org/lkml/20190325223343.GA27389@bogus/
> 
>  .../devicetree/bindings/power/qcom,rpmpd.txt  |  1 +
>  include/dt-bindings/power/qcom-rpmpd.h        | 22 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
