Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831A8CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586EC20874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572367266;
	bh=1b2yFLE9SIOW6cmNvQkbajbkJG8A4bwUBcjGZcbwqsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nX1BMDFvPBDZp9SxUnutRQ41Q/SsH9TxIVgoQdpzUsVMnZ8v2VeTlybGQ1Gn14XX5
	 K7tesottZuN94ATX37WtGD6HAMFQFqLgay7wpiDQoqWM9o+qRzgm3YqdQzR4tzN3lq
	 PYYJXWvmiy0KvaCMjTITg7vx+lCvmmn+QWRIsqlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390454AbfJ2QlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:41:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42073 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390192AbfJ2QlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:41:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id b16so10300153otk.9;
        Tue, 29 Oct 2019 09:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fvzDF1EQL0iAT5WRqqbNsT/xaQYYfBwjY6dwN6fN4vE=;
        b=smiG2Ok7PD6lSKELdlPnRBHZqXVomzdqn5/qVhPO3NRFELaKPJauPtWJzLe11bWhGA
         1XfNA4+1WjtudUOuEpsCofep/grk8M0SW0Gw6gu5Zu3FUJzdKCqfJeMW5PfjFvUqvFJ+
         zz6PpOjcajyY43ve8iwkqglGnpiDMMpjcIeVob8ltcbKniJK7D+xcMz/0Ij8WCocgLlo
         K+kYzTr3up3qKb8UM/LQ475rHZX4JAPzvjjhycvoVwU40qM2gDI7BWy8iga07CmkO5hg
         1o4Qiq+FpY68Wd4+I6+ISy7DQ90rJxAOIn77ObI282+I3QRbjNdUmanojLGSYfnb/fr3
         Rylw==
X-Gm-Message-State: APjAAAVq8JmZmjkSoUpJO0tJNOSLZNMcoJOXDwA2V+aUasiaOb+gvUaZ
        xKYmH7TXwjt0Ol/bZHLJlg==
X-Google-Smtp-Source: APXvYqxafeKH9kgtJXf3IqeJ45bIUjhlxFGWRtIy/IXgLiC7LvPuf9j+o4ls+HkmFicowKX00KL1Yg==
X-Received: by 2002:a05:6830:1d4c:: with SMTP id p12mr3473042oth.139.1572367263971;
        Tue, 29 Oct 2019 09:41:03 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t12sm4826024otq.61.2019.10.29.09.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:41:03 -0700 (PDT)
Date:   Tue, 29 Oct 2019 11:41:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] dt-bindings: display: st,stm32-dsi: Fix white spaces
Message-ID: <20191029164102.GA21205@bogus>
References: <20191021151847.13891-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021151847.13891-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 17:18:47 +0200, Krzysztof Kozlowski wrote:
> Remove unneeded indentation in blank line and space at end of line.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/st,stm32-dsi.yaml  | 2 +-
>  Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
