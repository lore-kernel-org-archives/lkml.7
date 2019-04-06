Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2A1C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F44921871
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530846;
	bh=gupjbRFTIkw+Eoe56MroB4nUBSm36/Gtopp9TKdwl84=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=wfB/RQjc2OqLACvP4TautuU6KqWU/0ZjcXvuluTgl0NIOzbbLQf975KIXELAq9ahT
	 hUnuBmF7h3+F2cFRA/nePo0s6aYNQ55THqIhdNcGS1HLCfbyjLFEeMtpdUx0CCNgo2
	 B6VSIGsTExYUfq36PRT9+TKn+a6mKuYaq+j/sGxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfDFGHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:07:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37270 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfDFGHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:07:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so4202042pgc.4;
        Fri, 05 Apr 2019 23:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=lMrGUMpIFkbuBZrg6UX30UvKLSPJJuml/SeHu52b0CE=;
        b=VyabRoy8HWrYcYpm6KLdBzHuVGrQDje76ts6Zz9z4d6w2dEarpF+9RUwFJwdBpRyTZ
         8cO9zh63IaTuzX545ICGqG0+EDJCJHJ6my6XOe+7Onaqhi8e+DdQcZXM4v3ic0IOK5Y0
         UuzfwQx9ljEFgpz3O0R/a0WOu7iPoDUpzvcR7CiOR5vfLxCJQXaFNkketu9doza2RHzM
         rnQu0odSmJdr58Xiakoc6nbsINy0fBte4vRdglSyKLU0ecPNNbyzXGNvg7EJMFhqZfWO
         cqqQNS7PtA0Zm+inA2U0HnggBby8TKJDuas2bkTHKFs1tpqJglS4nwNFD8H3aWTSEmu2
         M2HQ==
X-Gm-Message-State: APjAAAWZHRupJWNhOJK/VXppGkjSSAjr7w9aWfs/t2wbaPhZ7tFq3hHS
        z/z1v9DhvMjuztr/yIllvA==
X-Google-Smtp-Source: APXvYqx7kHRPgRNWQt+YENR3PhZcrTQKq9FAPILeRhkzvBL5PHlfHyigQcVGOk5mmccPpUTqsCk6yg==
X-Received: by 2002:a65:420b:: with SMTP id c11mr16357089pgq.24.1554530843237;
        Fri, 05 Apr 2019 23:07:23 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id 10sm32524973pfh.14.2019.04.05.23.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:07:22 -0700 (PDT)
Message-ID: <5ca8421a.1c69fb81.a620b.5a7f@mx.google.com>
Date:   Sat, 06 Apr 2019 01:07:19 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: sifive: add FU540-C000 PRCI clock constants
References: <20190404003820.10679-1-paul.walmsley@sifive.com>
In-Reply-To: <20190404003820.10679-1-paul.walmsley@sifive.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, wesley@sifive.com,
        paul.walmsley@sifive.com, palmer@sifive.com
To:     Paul Walmsley <paul.walmsley@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Apr 2019 17:38:20 -0700, Paul Walmsley wrote:
> Add preprocessor macros for the important PRCI output clocks
> that are needed by both the FU540 PRCI driver and DT data.
> Details are available in the FU540 manual in Chapter 7 of
> 
>     https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> 
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Wesley Terpstra <wesley@sifive.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> ---
> Rob, Mark: this patch is a prerequisite for both the FU540 DT data
> and for the FU540 PRCI clock driver patch series.  To prevent one
> of those patch series from depending on the other, I'd like to ask
> Palmer to merge this patch in one of his -rc pull requests.  Could
> I get an ack from one or both of you for this purpose?  Thanks.
> 
> include/dt-bindings/clock/sifive-fu540-prci.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 include/dt-bindings/clock/sifive-fu540-prci.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

