Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66253CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CA52084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572039179;
	bh=SZUK9+O0OoECdBmeSIf56mgCIoPc3bu1KThHvH15OVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0tgYiOVDno1mD1EOCKR7PGM7sOUKXwIyFBnb34dSB7RX16DplhjymzZ9MMGsMUowe
	 6sHWAm5vOrC8xVy7eyvmY9Ltc6+oVXNEQAStLdMhNQfEFKbYFzCXJGE1QJeLg7tx4U
	 lU4z9FecDS2ip4IuMqsB2Pxe8Oiw+qj/zmMdzKiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfJYVc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:32:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46967 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfJYVc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:32:57 -0400
Received: by mail-ot1-f67.google.com with SMTP id 89so2994658oth.13;
        Fri, 25 Oct 2019 14:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z0Dfu2WmLrW82obqVEzdgL4RLEpx99A6YNjCZkr1AdY=;
        b=tWphUpcA7ok/rG8n8/XWesvW/0xO/Jtrnae3TxShxPqwGsz6nrJE7MMUXRF0YsLLUC
         U5L4a5LZKsTvWXLG+GNtOTr8cLw/7VfYt5ZkiGQrbAD1NPU6wJCcyUTYXfWH2EGfI7ZI
         LkzCtGl1K54RMJXgUmBHSlE9MZvZsDgrBl9W1UY2ajiykT36fGnFw1LdBthCFZM02CxU
         KQD0vESGULJEfmm68DGI0dQ7g2tuCskEFHDzIP5xHO+aZUT4o1NhISnCfveKtU08wahR
         vcunTQn0yKvj6DJ18GtA4qRhBBpSB2BRlT7xAf023Sp/2fXDY/kPI+gJtYdj2QrN+JZF
         4dxA==
X-Gm-Message-State: APjAAAWFiDiihH+NDUScxE+vOOp+LSVOSMb9kOEK8atLSEp5r/IJspAK
        cH7W6Q7Wk2xcoTg5xvcnIkoao1A=
X-Google-Smtp-Source: APXvYqz5bA/sDLT9LYdiIgseo6TuDUbb3NL+cEtzFm8N8YSHB9VLO4PAlGBNFEbX6YVVd8nSUc1Qdw==
X-Received: by 2002:a9d:65cb:: with SMTP id z11mr737532oth.195.1572039176538;
        Fri, 25 Oct 2019 14:32:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e102sm1132401ote.78.2019.10.25.14.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 14:32:55 -0700 (PDT)
Date:   Fri, 25 Oct 2019 16:32:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andy Yan <andy.yan@rock-chips.com>
Cc:     heiko@sntech.de, kever.yang@rock-chips.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: Add doc about rk3308 General
 Register Files
Message-ID: <20191025213255.GA21912@bogus>
References: <20191021084437.28279-1-andy.yan@rock-chips.com>
 <20191021084555.28356-1-andy.yan@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021084555.28356-1-andy.yan@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 16:45:55 +0800, Andy Yan wrote:
> RK3308 GRF is divided into four sections: GRF, SGRF,
> DETECTGRF, COREGRF. This patch add documentation for
> it.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> Changes in v2: None
> 
>  .../devicetree/bindings/soc/rockchip/grf.txt          | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
