Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6955FECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AB220872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571179674;
	bh=9KIppj9sIMhLUXahYTnMGR5moFaEWa0XPQDoEtu2aYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iWe6rtQ5c1qsZhsMIA21cM/ioexIGiNHELBlbrypi6IJUBkeLL/20E0DmjmApV7Y4
	 g54tUYIxIQX3Y/xFUNkz8OnduXQnPVZBDr1HUXVh4h6khbq0Mf5YI/n5n8E/7DE3s7
	 IM+TqCa5WldbyQjtl/6UG+SKGt2RtGgS2kpdx9AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390103AbfJOWrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:47:52 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39737 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfJOWrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:47:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id s22so18438291otr.6;
        Tue, 15 Oct 2019 15:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L29Q7uBjfh2/8GkHTrSFKn53EJrq5c7glms3MlDnD+8=;
        b=PR/6g4zkqN0a/OpxGj2lWVdHvLGwsQKTyb6oNSIS+jsrcO+neli5piQyVqOCkC5BPt
         kx8C7k7JvakEuH8Hazo5YK1MQjQngDI3rKKcEvJWHu9EiGO5B+Sjq8Ol4sw7+KV6WRpO
         eOQehABrMB71QCX9YCIWy6sqfyFy6OTE0LdETqgQRohR+KDGHSHNtQM6AhGn4Hn8Kw9K
         oOqfkCUV8eHhJDotvKTbb44+FGaInL7PZkf1P9BB4y/U+qQis6x8FbyklwaQ3SoxXYUE
         rGJ0deKTaT+URse9d8zyrNap52+a6u+6WFncntlqRzF2eJiGbhzdUEC5ejqn+1y2+MEl
         2GtA==
X-Gm-Message-State: APjAAAX7HbVPiTpgAP4/qg78OAyqFLA5l6ulpBzuuHW9jDBeCF46p9RZ
        2edPr1WHGEQ/kfMh8p4cSA==
X-Google-Smtp-Source: APXvYqw5mXf86Bg84vSsRwYWEsXXpCgsWXJFetgM2DHfYHCqXad5KFgjFqh2gh6OrmOLdlLnZxsqHQ==
X-Received: by 2002:a9d:7147:: with SMTP id y7mr17614612otj.62.1571179671509;
        Tue, 15 Oct 2019 15:47:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a69sm6826546oib.14.2019.10.15.15.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:47:51 -0700 (PDT)
Date:   Tue, 15 Oct 2019 17:47:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH 2/3] dt-bindings: arm: at91: Document Kizbox3 HS board
 binding
Message-ID: <20191015224750.GA14460@bogus>
References: <20191011125022.16329-1-kamel.bouhara@bootlin.com>
 <20191011125022.16329-3-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011125022.16329-3-kamel.bouhara@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019 14:50:21 +0200, Kamel Bouhara wrote:
> Document devicetree binding of SAMA5D27 Kizbox3 HS board from Overkiz
> SAS.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
