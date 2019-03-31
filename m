Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051582183F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014567;
	bh=CHU5OqLawWCoCIVycoGDpkayc0QA3tdnaHfmf8BTztw=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=AiFIQsmyuTPOnkp1cyW0wPm/WPH6rgC/yxSMx9/tznv+t40SQZENFzDNlPQfz+PqA
	 4iw85XXHdH9dQcN6daxhfWxIZY1Shh3mu10g285RVLJT/P457V7TFG6w3e8beWNuqx
	 PDU1ryvqc7c/t4SLXkXuGv2qdRoiO0Nx84jtNeCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbfCaGmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:42:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43983 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbfCaGmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:42:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so2970713pfd.10;
        Sat, 30 Mar 2019 23:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=vSXDChUhILRmmgCN3ZahXVED8oDDAFSXQLLAtQEKHiY=;
        b=CBCXUDiwYsteSdVqMEZnBqbg/25qAf430x1zUfvsCjzmXiYfaPs00So73rS4r8JG3c
         WA3nMR/DSI1opF50+8Swk5azIOBPwXRS1fPV3vV4lBdpEAaXIsz8GXI9opZZLvOlgebL
         2abETxOAmIOKA4trF7rV3deWyOhA+9ltsjoLMvdJSSdZAZ7aglw3w54vJ16ViVCn/enq
         wkpIPoLS7CjSxcw90ROTyZQPbBcRO9IBmYqOCPVGnGFheUbdhWQZcvFIhy6qqFJ/jT/0
         H47Iu/07i/40tOs8gPd2gbB0HRmOJ1uU8JMd3jndFiD17WRVIKJOUa/vaTh1a5oOWDj0
         Dbtg==
X-Gm-Message-State: APjAAAUWOR6K5ArzndX2p6olP8xIhFA5yuGVU1jXGZH9shVJjaOces2D
        mvLhWaBjfhknfLzIH1ZFDw==
X-Google-Smtp-Source: APXvYqxnHwA+BapEia7iN6WSAoOOGnY6YwJhsBnHs8WmiyiYHAIcrr9zBWg7UNFdW5auUBLJ4OIK8Q==
X-Received: by 2002:a62:70c6:: with SMTP id l189mr3964121pfc.139.1554014561867;
        Sat, 30 Mar 2019 23:42:41 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id r8sm8787780pfd.8.2019.03.30.23.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:42:41 -0700 (PDT)
Message-ID: <5ca06161.1c69fb81.bf261.7caf@mx.google.com>
Date:   Sun, 31 Mar 2019 01:42:39 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RFC 5/6] dt-bindings: arm: amlogic: add Odroid-N2 binding
References: <20190327103308.25058-1-narmstrong@baylibre.com> <20190327103308.25058-6-narmstrong@baylibre.com>
In-Reply-To: <20190327103308.25058-6-narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Neil Armstrong <narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 11:33:07 +0100, Neil Armstrong wrote:
> Add compatible for the Amlogic G12B (S922X) SoC based Odroid-N2 SBC
> from HardKernel.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

