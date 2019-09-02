Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E09C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC67C21881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567431547;
	bh=bw0bu1rEM2bRxmj8ScWjUSQdxn9XBw/6sO/2N8Oa4P0=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=ZVXenXl4m1f60akgBP4J+0moiaiSxiMYB27B+cRejz6UjmffPd/OG3HJWGm6nLmRE
	 ILYXL3hOP131mxh8NFwgLDoPORkWEvY1CWqXKTxvashoIqEhek6q7Sx7G7gdBASNDb
	 QlMwE5Q3aiXsIFASWei1LknODVKnJ4WyCb4hWbTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbfIBNjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:39:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34264 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfIBNjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:39:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so14117211wrn.1;
        Mon, 02 Sep 2019 06:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=OQ6Dfi/Qr6lIQFBaHa/Prz9is9N5AJrXXKIThd5iKms=;
        b=tKaZ8idTV87ekx33I5xwqxqasAW59W8qqZN3LhWRhUTviJ7swfK9SrV/VvgRvStBvT
         2lpI8cQu6VyNw8a3KbQAcyK3nf/cl/ikdNRAoX89u8XuuAfws0bsf29PhF7PDLhTmL7L
         JIpkyrV5jyGVC8GcZc3JwxAoC4KQ+cpO3W2zV29ucxaqirS1jReqZ5IAI9u4KCx77CgY
         RBVAv7vvCXmQZWxMVGeO13PMvfgCKu/UKhePamcmYIN9xHnvszDZhvhgn9IytrmohxPY
         wq8j/Ol8uiRpSAsFOvEhmr0wSVoZEViQlY4f3hUkhf5aFq3DQ/Wu17YZlsWKvNd8LY2C
         rAzQ==
X-Gm-Message-State: APjAAAXq07YkHvL3fueH9tjKf6vg+7HX4HrVGVdDNxaeElTFoyC7kpPe
        9AqkRVhWAbo3m4OjXfkhwmOUvFPEYg==
X-Google-Smtp-Source: APXvYqw2DiDJ+w1ebULyhODe4j+GTxATN3tGC0MMDX6/z8sFYsQz3kRcqnuum6hqSQEZ748nLe1u6w==
X-Received: by 2002:adf:f543:: with SMTP id j3mr2578327wrp.243.1567431541322;
        Mon, 02 Sep 2019 06:39:01 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id f23sm12797441wmf.1.2019.09.02.06.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:39:00 -0700 (PDT)
Message-ID: <5d6d1b74.1c69fb81.ed670.4fe4@mx.google.com>
Date:   Mon, 02 Sep 2019 14:39:00 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 08/18] dt-bindings: interrupt-controller: Add Loongson-3 HTINTC
References: <20190830043232.20191-1-jiaxun.yang@flygoat.com> <20190830043232.20191-3-jiaxun.yang@flygoat.com>
In-Reply-To: <20190830043232.20191-3-jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org
Cc:     chenhc@lemote.com, paul.burton@mips.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.co,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 12:32:22 +0800, Jiaxun Yang wrote:
> Document Loongson-3 HyperTransport Interrupt controller.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .../loongson,ls3-htintc.yaml                  | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-htintc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

