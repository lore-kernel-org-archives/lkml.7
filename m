Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB697C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7142173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553791813;
	bh=PvKv0rf9ng3+9tGSeaJmJ9HBfw+MeFZPb/a4GP5Vs64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dOF5x7HQkBsl/cFMjAkmsPcjlSmPjbTSFh986yqdMR7TXu4FCKdehTZ5mYToERjaN
	 Sp3IiWz1gOeB8T/j8A93vf9IeEPu88q9Nakk5Kged4VEDDdCPxRug/ehireEEhoib0
	 A4ujhs3iP0jWMNsBc7GcdbE4pO9aCrz8V86UY1u8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfC1QuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:50:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45480 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1QuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:50:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id e5so18938090otk.12;
        Thu, 28 Mar 2019 09:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t1Psqei9lUi5j9Hd+oGgZKpCerKGwvlb8ii8MsHezM8=;
        b=migcW0gPIN6xBGiAZH8nXndN9qcQx00Wfqd6wzvFU6UF1XXatttXaJApoBePglXfke
         yvt29WSVEDRGt3L0ypfKf0dQ5vALERThvpUmZYMY0gPtEhCKQPJApqWtEMfTZ1Pmh2/P
         /kxKENrSDXEU/nMkvpik7IXVr6a4jo5IVJGUHJBfJQDxoOLNBpSij/3nerW159gnhGpX
         HfyjXLxE/AC3zw7cMuFOWADyNCApZKO1rRmrO2PxHZR8AzKMqg/LCeXVjarMiMLqNbkP
         iVVozULVK2mHOqCpiRkG2xu8wg+SLURnMnBwaZG8XJTHnxonJTwHB72JMwnzAu6TPPK1
         2IkA==
X-Gm-Message-State: APjAAAUdZeVC2gG7cOukpXHZxNATfaOPryWEJXDqjkfFLafozdl3DghA
        lfAts/iZ7bMRIUho41kRGQ==
X-Google-Smtp-Source: APXvYqzdVVyNIpuXCTfSuvkRh6vQqVLRLn4Op1LRyh33zxQsGPw8+z6VtrbNt9lCcNKnj8/aqkshBw==
X-Received: by 2002:a9d:5d0b:: with SMTP id b11mr9599392oti.80.1553791811310;
        Thu, 28 Mar 2019 09:50:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k25sm4593865otj.72.2019.03.28.09.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 09:50:10 -0700 (PDT)
Date:   Thu, 28 Mar 2019 11:50:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Patrick Venture <venture@google.com>
Cc:     venture@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, andrew@aj.id.au, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
Message-ID: <20190328165009.GA25705@bogus>
References: <20190327212155.80730-1-venture@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327212155.80730-1-venture@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 14:21:55 -0700, Patrick Venture wrote:
> Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> 
> Signed-off-by: Patrick Venture <venture@google.com>
> ---
> Changes for v8:
> - None
> Changes for v7:
> - Moved node under the syscon node it requires
> Changes for v6:
> - None
> Changes for v5:
> - None
> Changes for v4:
> - None
> Changes for v3:
> - None
> Changes for v2:
> - Added comment about syscon required parameter.
> ---
>  .../bindings/misc/aspeed-p2a-ctrl.txt         | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
