Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649C8C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BD221900
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563833449;
	bh=sOEVmSoROx0ts930Znd5c3Y6XDvWKTE3k0fASRXo1Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h4oh/jo65/jwPmvxuSvqnpSEG1H+1OgpnHIBOvCR391v1hM76sCW3lC2S8sQ9yFxd
	 VWIU+4745n5ne6Qjby3mDpFE+2VyKRhQf5CJ2sQIsl8ObbgqMRAIb0oZQuYsW1ObEm
	 6CNLqKXQS6G2W2N4v9i4ZY7vep3Nr4vX9mP4BwA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbfGVWKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:10:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39015 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfGVWKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:10:47 -0400
Received: by mail-io1-f66.google.com with SMTP id f4so77500855ioh.6;
        Mon, 22 Jul 2019 15:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=so3TguXhHjajKSvaOLSucOk7rXy936Gzk4d2QA02XtA=;
        b=WeuhNjzs2wAIAQW/8qBkGqSB2h29TZH5THjlzO9ICQdI7xu4sbIlo026bqCoNVNVm8
         1g+U4wPGN8jiBo/ZO4rTEFBLqgXqRHM1W/6hJVUwSVeYVBsfAQMBnPDpSlbZ4C2EHiu5
         JhreBc95egnz+hj3XPN2YUdmioHZPMjVPp1ly7VgbWwbNkLNfNhJ20WXpZWIZXEUnLH/
         QWe6hoXuykHVjJRa2tAeqB/VfABZUPMpLSSPA9sFdr03fpwMcNThUcpwxaMAM0TqckwI
         N1jX++oabOqCeaFMe9/Ob7FtXvsYvRTu91dubcsopuP+8PDBI2H3RewGNV0VyZyVwv7O
         qRCA==
X-Gm-Message-State: APjAAAWxHQw1zHF/DBCbjoXmf1FyIwEF7uoYusCjbcym5B3m+zTVBPy7
        JNyinUQSRhk9uVb80GkFB00N8X8=
X-Google-Smtp-Source: APXvYqwhN7RA27SVa6mIjcHdSIUhlwnMBkhE2+F2OczdEmCOQCiFU41dl37RKc0vjcv14UOGyFPR+g==
X-Received: by 2002:a5d:8890:: with SMTP id d16mr20374962ioo.274.1563833446531;
        Mon, 22 Jul 2019 15:10:46 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id s2sm29616314ioj.8.2019.07.22.15.10.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 15:10:45 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:10:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [RFC 05/11] dt-bindings: soc: amlogic: clk-measure: Add SM1
 compatible
Message-ID: <20190722221045.GA30948@bogus>
References: <20190701104705.18271-1-narmstrong@baylibre.com>
 <20190701104705.18271-6-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701104705.18271-6-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Jul 2019 12:46:59 +0200, Neil Armstrong wrote:
> Add the Amlogic SM1 Compatible for the clk-measurer IP.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
