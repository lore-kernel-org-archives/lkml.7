Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A8DC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5EA2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576708041;
	bh=gGZPk+XOvZuE4SMrBN9CIW5wz+ODCIU18ZTHsnDJA00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FEuD0RD+0pgq/xvhw+k5QKDrZpAanhXfhMQ6qqecOVnMc0Tc95AfK1C6G5Hp6zds3
	 MZ5juRJVosuCjIdMLJQCaHYOaP9gdYuWfNNDPTEi9sg2MYyHtTv3Izu8F5QfbHt6mt
	 ZSC281WVG4HGrvGVZMfqEeUWNIKK6kvP4hGM/ejE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfLRW1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:27:21 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42055 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRW1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:27:20 -0500
Received: by mail-oi1-f195.google.com with SMTP id 18so1340403oin.9;
        Wed, 18 Dec 2019 14:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DPx76fdrtNFryPt1bqjLnMiDt/+RbhXxSWMZR+o48kk=;
        b=TzMKeX4fuhLrR124RTRxvBjqgzDeP5tFAZBWQb3fvPjmXqzRKDg+G3BpRcbESS14gQ
         jk4kNoleZ9MSWZfhPK3FdgWGKbgUzzE9NiUmeOv5h+pQ4TlsWN8QVG2ZhkBH4BwOykrX
         Du6QBNzDo7M58XDrcLqm4AmqYYTbV0WMnR/PSWLstUyQYhG/dySL0s4AxxYvH0OMtcY0
         ptEB984aUYlwS6uIP7ETVXdOSwjC7yT4+/CP0VdvXIrtSgIwHwZW2wzKW3FPJJXVEo3s
         kRkZ2ytPNOlZX8NdGheABpKOuTcPYt/rB1DUQ9oFa8QIk8GmHNoPWRAOOg030f4HEees
         eCxg==
X-Gm-Message-State: APjAAAVsFHVsYNbRAw9fvzvlDdZKx1ki9u//4bwc8kvkcw8rljozA1oC
        AeG/w3jbVLmkVLZMR9kTdA==
X-Google-Smtp-Source: APXvYqwJ2EwcOT9FHyK5oTO5jZO1RaodG2vRem5BdHLYTRgbkWrURqnTXm4e0vS7WkNGgWnFiiOd2w==
X-Received: by 2002:aca:b7c5:: with SMTP id h188mr1610228oif.100.1576708039683;
        Wed, 18 Dec 2019 14:27:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b3sm1271775oie.25.2019.12.18.14.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 14:27:19 -0800 (PST)
Date:   Wed, 18 Dec 2019 16:27:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: Add dt bindings for flex noc
 Performance Monitor
Message-ID: <20191218222718.GA4028@bogus>
References: <19bb1ad0783e66aef45b140ccf409917ef94e63b.1575609926.git.shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19bb1ad0783e66aef45b140ccf409917ef94e63b.1575609926.git.shubhrajyoti.datta@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Dec 2019 11:09:56 +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Add dt bindings for flexnoc Performance Monitor.
> The flexnoc counters for read and write response and requests are
> supported.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> changes from RFC:
> moved to schema / yaml
> v2:
> Add additionalProperties
> Update the License
> 
>  .../devicetree/bindings/perf/xlnx-flexnoc-pm.yaml  | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
