Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161DEC388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E321E217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569607251;
	bh=UaEk9j/5uDfdZSXEVBdpysAKX2A+URChP/sYfYE9OiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lue8CM86uIG5EjuHRiGb7po1NYSX6Zblt5oVRFQD+9pljYZE/A4CNYG6I/SzeUTwq
	 dUfR2EsT6nKsC7+FqokABZq2IJS827xVwgHDN97PEiJCLLYSbTpgq7DJYlwDVvDAfH
	 TeImSYgsl72u1deZUPSwF40Ns5s7f5YVJ0mNCDDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfI0SAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:00:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42826 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfI0SAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:00:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id c10so2991223otd.9;
        Fri, 27 Sep 2019 11:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l7BCwV3NerQ03LGiSzwjhLsOez+Wy/9zE1sSB6m5ONw=;
        b=Whpa2SGs5h1SJtN6MHpeUKKrWBOdVeW4weJ2mkRv86oXypFEXkcsKmu/VF6yn9lcIT
         YBzLMUupb1SG6lxim6gecCXgDsTo2mx6adJF0mLc1SfVQeGnllN+udDqInTYPEWRH/4S
         QNpU9998akbhVrTa7WONVrgjzfkidG+SGa+U/wulYAiocfTavWHbfvXs2tH50XMCZzS5
         SKb6NuJWd1RC8bd596DJiD/vc1+yG3l8k9vhjO38boD0WUsQjW22gIDOgy3p9KZ2uzaA
         s0bVCEllQ3qJcqJbDhyDREUU3YZXpdrtyzNWKMNMMIwvzs9Nl783mO320zlvoZiGRLIK
         8pBQ==
X-Gm-Message-State: APjAAAXq8pYbgYp54dKF0G4lI8kzpVHEImCJqIohJGtGFU6rN9HVwpCW
        0BYvuma6AXOp55gb3egmWQ==
X-Google-Smtp-Source: APXvYqx1zz9JdKZCj7dotz/c9Xs7Sqvslg98uXH+/47gz30MNOxp2Mf70RXqi68SYeY4gvveyJFkSg==
X-Received: by 2002:a9d:724c:: with SMTP id a12mr4598224otk.230.1569607248917;
        Fri, 27 Sep 2019 11:00:48 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z12sm601596oth.71.2019.09.27.11.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 11:00:47 -0700 (PDT)
Date:   Fri, 27 Sep 2019 13:00:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: samsung: Convert Exynos PMU
 bindings to json-schema
Message-ID: <20190927180047.GA24461@bogus>
References: <20190920162600.7486-1-krzk@kernel.org>
 <20190920162600.7486-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920162600.7486-2-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019 18:26:00 +0200, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos Power Management Unit (PMU) bindings to DT schema
> format using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Use select to skip other syscon nodes,
> 2. Indent example with four spaces (more readable),
> 3. Use pattern for clkoutN property,
> 4. Include header with clock IDs in example to bring it closer to real DTS.
> 
> Changes since v1:
> 1. Fix clock-names to match all elements against schema (any number of
>    any clkoutN values).
>    This currently fails:
>        properties:clock-names:items: {'enum': ['clkout0', 'clkout1', 'clkout2',
>        'clkout3', 'clkout4', 'clkout5', 'clkout6', 'clkout7', 'clkout8',
>        'clkout9', 'clkout10', 'clkout11', 'clkout12', 'clkout13', 'clkout14',
>        'clkout15', 'clkout16']} is not of type 'array
> 
> 2. Add syscon reboot and poweroff nodes.
> ---
>  .../devicetree/bindings/arm/samsung/pmu.txt   |  72 ------------
>  .../devicetree/bindings/arm/samsung/pmu.yaml  | 105 ++++++++++++++++++
>  2 files changed, 105 insertions(+), 72 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> 

Applied, thanks.

Rob
