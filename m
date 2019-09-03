Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7D1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1896233A1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567532479;
	bh=IdouqmjiZsmDUpSyxcdAaRYhiy4IE2E9qcuXGCwj7e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kONGUII/qaF9QnYqw0Oopyp7Olh/rlvbFce3hRSdy8oIvg4gPf8lNs9ROxmg0rLuI
	 I9gilIUrgTUphc0CyppBvPYVm5lfQRwhxGA7vHYesCSSe5RFYxssvNN1l1ixGwNkkK
	 nVSxgjg1ZSnQLlIbgYMghvzcmZWV7xrqfaA4we9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfICRlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:41:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33617 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICRlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:41:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id u16so18428751wrr.0;
        Tue, 03 Sep 2019 10:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ieQ0SS1TbyTo2Ti96I4YLp+pK1fJ3Fs4s6IUdQyKN2Y=;
        b=hzDkDTTax1da3WYxozxrckgfZjPBMdhziR71ncEM00cMw21CHxXTxkZGDA/W6AoFfH
         4SoX5ZzdV1grtC2J+Drxo+eU182Tu56LDxPu17TKHt3bF9yjlkUQr+Q6eSHi8c5xFDUw
         he6DwzymBxXiybAGLnqioDCBbRpS1vT70jA7j+njxD2wVmgYRQAa20RKAYKYFGheVxB7
         yygaAqdqPk4X+dDxUP8ay6xjS6/iW/2QeWiJPDYJ0AxQiUAJae+bf2VcRAAmUGL8Cw/a
         En1+p25A728szr/+aBvpiJ/lx09z4hX0J3hCPRS4+K36ZDm9fulDt5NEuOJOjHqehEkt
         lAWQ==
X-Gm-Message-State: APjAAAXlHxpQmMSBMuWk7XlYnvNe7hNqy3Luvn66hPsr4NzLfvW4JMPW
        uvTi/7EGtdUID2bKRJeOCQ==
X-Google-Smtp-Source: APXvYqxnUok+psv1QFkj8jaGGJBG3k+UUbHqh55UDvJs1Lvg9ReVnSTkNKcfQo3GWrM2PteMUQAa+Q==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr28322655wrp.122.1567532476537;
        Tue, 03 Sep 2019 10:41:16 -0700 (PDT)
Received: from localhost ([176.12.107.132])
        by smtp.gmail.com with ESMTPSA id b184sm294493wmg.47.2019.09.03.10.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 10:41:16 -0700 (PDT)
Date:   Tue, 3 Sep 2019 18:41:14 +0100
From:   Rob Herring <robh@kernel.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i3c@lists.infradead.org, bbrezillon@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, pgaj@cadence.com,
        Joao.Pinto@synopsys.com, Vitor Soares <Vitor.Soares@synopsys.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: i3c: add a note for no guarantee of
 'assigned-address' use
Message-ID: <20190903174114.GA3710@bogus>
References: <cover.1567437955.git.vitor.soares@synopsys.com>
 <159ae86a8f87b8d518bf63a8946b03b14e6b5500.1567437955.git.vitor.soares@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159ae86a8f87b8d518bf63a8946b03b14e6b5500.1567437955.git.vitor.soares@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Sep 2019 12:35:53 +0200, Vitor Soares wrote:
> By default, the framework will try to assign the 'assigned-address' to the
> device but if the address is already in use the device dynamic address
> will be different.
> 
> Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> ---
>  Documentation/devicetree/bindings/i3c/i3c.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
