Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DAFC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD11924670
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575577780;
	bh=kJ8gRVt1ELZthKhNFJuzZ3/sJg+kN1ArRSuLGYOKDeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JqEnX7ik8rUjbyqpSuq0M6sdXyis31FJUg2ujkQtr6Iq/ED2USvua//ztJ+i+1PN6
	 2etX9SqPb/230PUa4Uh9CEnPAfdTRBBbZ6XOTDhbJ24iaIriV91a+vB7kYXCnDVuLM
	 /WABQSo0hMqEtFKDyVmU4ZauUNzw3jT6dMxRebmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfLEU3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:29:39 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41790 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfLEU3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:29:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so3786082otc.8;
        Thu, 05 Dec 2019 12:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AkgcD/tlGSGxu27RuFySd/svBXgn20nKAGDvAk8fZnw=;
        b=kvt9t3ABsooWquXw2z9hlcFBB2BZjka5EbjKfNCLc5QesBZcEfUV4u4IN9VZ3mQsVB
         vc4kd4qLMkxCfc8zRzvXEWiY46JY4TxQQ42mwXPln3SEEs/erV6K8hrUbr8FQTfeXEYD
         HA4smXUsXire6BiCI0mlB7n80sv0DeevPvQUJqYXRnEmi7siX94nFFkXSWvyUazuXQKf
         uMPzHmXgleGUa55V9dm+AsUg6moVUzV67Hl6taGKQnnDEDxZtrIovav5kCva8BaBvIbH
         8HJJYr/OvP74uqrlqLyBI1JL6G4U62ip5P0gw1TVVud0X6jcyQYV4EdeYxwYogbuEJqe
         RjsA==
X-Gm-Message-State: APjAAAVQGQK7Ne6C65FW6GEqFTzjwrkBDvnePZKLTfpQuzSNqVhwh3dI
        K5G2pIRUFLwTqwmiv4q7iw==
X-Google-Smtp-Source: APXvYqyMBZipl4SbfrQGrlbvmjV0BrjbSTlW/cYZIx23F5xuG32bO6yJwaFFSKjMkkSlUt8kkoa9vg==
X-Received: by 2002:a9d:413:: with SMTP id 19mr8338330otc.11.1575577778427;
        Thu, 05 Dec 2019 12:29:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n17sm3710261otq.46.2019.12.05.12.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 12:29:37 -0800 (PST)
Date:   Thu, 5 Dec 2019 14:29:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     robh@kernel.org, p.zabel@pengutronix.de,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: reset: Add YAML schemas for the
 Intel Reset controller
Message-ID: <20191205202936.GA21122@bogus>
References: <4193fef447c220406ab39225eb3eb66025734cd3.1574755533.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4193fef447c220406ab39225eb3eb66025734cd3.1574755533.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 16:35:17 +0800, Dilip Kota wrote:
> Add YAML schemas for the reset controller on Intel
> Gateway SoC.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
> Changes on v4:
> 	Address Rob review comments
> 	  Drop oneOf and items for 'compatible'
> 	  Add maxItems for 'reg' and 'intel,global-reset'
> 
> Changes on v3:
> 	Fix DTC warnings
> 	Add support to legacy xrx200 SoC
> 	Change file name to intel,rcu-gw.yaml
> 
>  .../devicetree/bindings/reset/intel,rcu-gw.yaml    | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
