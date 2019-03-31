Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A2BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5D721873
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014518;
	bh=KUh9Ix85xujGaKNAHASI58sGI/kaT+Fgy4TB+ZXR3FY=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=TycaP8b4weDaTQn1PgL7FaQu8WyUzH25KYmhytgkaw/X6J10IXUU/clOYAdrRrEio
	 RH1wgBz+Fk9a4nXPlI1l13Kw1ATOiVfpClq+72dbMw0FHMmj2AMIngf0bVI93ESEoK
	 tioqjSU7f5foH/ejFZMVahv/+GOiIxm/vMg5e888=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbfCaGl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:41:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38040 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731290AbfCaGlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id g37so2931183plb.5;
        Sat, 30 Mar 2019 23:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=oqxqJs1X3uE4BtLPo5eHOzxBzvO8FT3UM7Tz6He21fI=;
        b=t0jdL9yQft5QnwbhtTQg05cBU1J7ShbsrSVHcMhsjipIvdG3NRkzjr1SBcKe4Wf5kk
         UrRixMdl3IE9vEPvhZDhZ8nP9mE7QBnIAu+Ngkin2EqJI8n47rZ2RofiT0JzSZZAQutn
         gjmH7lIZf8XGIFAKFtu9MDZXmvtU0uMVQ074VEGh6AOf1Ux21eJZLuaZpWYCy2Za9iKe
         FIvx65vQbNSAEBKTc3USknLk8VxOdbV0xrJao6JY19c9IPWf2xZEU8LQsB4OFLQipH3B
         c9ovkWFlEK5497EI6wHMQoXIq6l03WUoset9eg9b07EY30CtusXS6XPibMkyd2Im3E+1
         4k6A==
X-Gm-Message-State: APjAAAVno7o1R9d38+RHXicTqaKuTIJ00SlIRgxMYj2QCB10vHd4z4w8
        0Qf4JZUR7M1OaPBgVdKfNg==
X-Google-Smtp-Source: APXvYqztzt1BfHdpon6Y2Ez+5jI03aLlOq7ZHEuQpDX0rlk4Wy/2clhGyA06d3adVq5eKE6tvLkFqQ==
X-Received: by 2002:a17:902:b94a:: with SMTP id h10mr30055560pls.82.1554014513023;
        Sat, 30 Mar 2019 23:41:53 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id d3sm9812499pfn.113.2019.03.30.23.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:52 -0700 (PDT)
Message-ID: <5ca06130.1c69fb81.75bda.974a@mx.google.com>
Date:   Sun, 31 Mar 2019 01:41:50 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: Add Milbeaut AXI DMA controller bindings
References: <1553487314-9185-1-git-send-email-kasai.kazuhiro@socionext.com> <1553487314-9185-2-git-send-email-kasai.kazuhiro@socionext.com>
In-Reply-To: <1553487314-9185-2-git-send-email-kasai.kazuhiro@socionext.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        orito.takao@socionext.com, sugaya.taichi@socionext.com,
        kanematsu.shinji@socionext.com, jaswinder.singh@linaro.org,
        masami.hiramatsu@linaro.org, linux-kernel@vger.kernel.org,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
To:     Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 13:15:13 +0900, Kazuhiro Kasai wrote:
> Add Milbeaut AXI DMA controller bindings. This DMA controller has
> only capable of memory to memory transfer.
> 
> Signed-off-by: Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
> ---
>  .../devicetree/bindings/dma/xdmac-milbeaut.txt     | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/xdmac-milbeaut.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

