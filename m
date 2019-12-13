Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A92CC2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D968F205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576279654;
	bh=sKszG99nwinMuvGshQ51xmMSwl7JdG7SQDBkCt/YiYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QgWZ8Hlb2itycPHiMExZKIiTJgkBV3dc4fSsW7ZTOY7oW3B+8H/svaP1eoj0YrFHK
	 VqyR1WJ5XWltoGZk3H6JZI/Sh+VbdvGa7fH6fsMRB06dQ7GQL4qBjqIz1vYtIcm96l
	 IHNdgFp2uelwC1T5Ga4R15XQfnbq0x3UOZv2oBkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfLMX1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:27:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39170 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfLMX1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:27:32 -0500
Received: by mail-ot1-f67.google.com with SMTP id 77so1041716oty.6;
        Fri, 13 Dec 2019 15:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S4bPNr6OBo/g9aqwSLy55ENKU+9zI0oQQiPkpLV/Jps=;
        b=kDqM1Ds/KcbFY/FLOQMpfQNYXvlaCBFdAI5dTBYv7jl8cldiPg0QU/xC5eNgZUPkJn
         Lqtdto0UF48upbGUJxk+VgGu3GMLd82tzm8T9owHr3buRb5IanxPxM+5MF9dkcytBDB7
         SYmr801XCHUmR76nVksgwu4F4q9VnmXHEMmRneYrt8TzaVt3g+ddx2D21jyWEg84r2fN
         gCpDS1QDDwLNmEmUog2g2YG6emzAo88mubdP9AjSwd7P8ZxU5OdSPBlLUcaR7No8T584
         nAXlu+G5lV/keLl2BIUp2vGnD10ViW0RBfIw3LFv1BReB6ss1oayMpjWZ9mV8dX19k5f
         kZ0g==
X-Gm-Message-State: APjAAAXvCx3bvWzZ89fDwbGkXIV5OviXkOLFFIT8R1Xujm5Vgkp6mxx4
        lawlT+Ygqj6N6ZttA0C09A==
X-Google-Smtp-Source: APXvYqyuN0Td4+RfvGK51mEm0cUvXxHhe/hls84mHF1OL3nAxDhPeCnm798ZyCCEISzCWecbI/Th3Q==
X-Received: by 2002:a9d:7999:: with SMTP id h25mr17214493otm.347.1576279652074;
        Fri, 13 Dec 2019 15:27:32 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y24sm3844418oix.31.2019.12.13.15.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:27:31 -0800 (PST)
Date:   Fri, 13 Dec 2019 17:27:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add Shenzhen Frida
 LCD Co., Ltd.
Message-ID: <20191213232730.GA23246@bogus>
References: <20191202154123.64139-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202154123.64139-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Dec 2019 16:41:21 +0100, Paul Cercueil wrote:
> Add an entry for Shenzhen Frida LCD Co., Ltd.
> 
> v2: No change
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
