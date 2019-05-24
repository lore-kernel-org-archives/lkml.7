Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40DCC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DD4217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558733936;
	bh=ySpdzIHE/XcoHxbm6ZRtDfMXMFvgQNWn2svqBWl+NIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=metjrV3BXaAWvl5ywyjVLnAy+5hCKrd8nsP0G73HPo6uC7iaPAjv5gWYpjZBmDBIn
	 E0uVncqqPdIu7+8bEE4h17wEiFVgsGgFo35uaTGGiICdfIjMz5nxKObKu9MsxCye9+
	 0c24vnsD2g9zaTyrkDyp38XZcWvOjzz/CSBS7GGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404269AbfEXViz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 17:38:55 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39116 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404182AbfEXViy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:38:54 -0400
Received: by mail-oi1-f195.google.com with SMTP id v2so8075835oie.6;
        Fri, 24 May 2019 14:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0d0FCy/4Vi/5vNwAuSVgIf6EEX3+JB7bBJ032s55LX4=;
        b=aMmX3vk7HqlO5Hr/+nNJVndkAFE1sMgyvnqkJAW3+nC0nHtPMOqmCyMuIBB0FJaEoU
         leurgUN7EPZg1BDgpU9YeJcwk7eVIxGquV5v+bcVgKnTYbNpVvMHNvmwFD4l1yJUdEBd
         4LYHjeloI4Kw8vLSe/dKHYnUM4Z0ZSJEtAAdyzBLNshlv5m1smg8yKBW6uBPmnhrRwyz
         MwMbrTdl2qP/IyZhOASRKlKEQuradg2jnfw4vIZ7PlovRVWP6zTxq0vcP/YE96ejmO7P
         Hr+5Zqc4Fq919zcoDVpzh0iNHTEpeUPh6mWontawCP8TBhgC3oaLmaE8Xifs0koeibtk
         EsBA==
X-Gm-Message-State: APjAAAV3Dw5qj8r54NHNdhubvcX37hdC6Wu5qjY9JIEgX3zmsybSBbr5
        47jFAqsRGRcB1SE1xqOkeQ==
X-Google-Smtp-Source: APXvYqxzbc8H6qprFZplYCrEeBeDAa86opIsAm/OZuzqeg10y4fclGeeLH2a231jJoHFJfk2x1BjSA==
X-Received: by 2002:aca:b8c3:: with SMTP id i186mr7732146oif.163.1558733934051;
        Fri, 24 May 2019 14:38:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g3sm1325221oif.25.2019.05.24.14.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 14:38:53 -0700 (PDT)
Date:   Fri, 24 May 2019 16:38:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: Remove Linuxisms from
 common-properties binding
Message-ID: <20190524213852.GA10241@bogus>
References: <20190514204053.124122-1-swboyd@chromium.org>
 <20190514204053.124122-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514204053.124122-2-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 13:40:51 -0700, Stephen Boyd wrote:
> We shouldn't reference Linux kernel functions or Linux itself in proper
> bindings. It's OK to reference functions in the kernel when explaining
> examples, but otherwise we shouldn't reference functions to describe
> what the binding means.
> 
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../devicetree/bindings/common-properties.txt   | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 

Applied, thanks.

Rob
