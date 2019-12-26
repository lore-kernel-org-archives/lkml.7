Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1D2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 18:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD502080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 18:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577386634;
	bh=egJk+YJEdEZUHkmawZ2xJQDY2KVH9LnoXavNew67DIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vKQPDoZMLiNjEWEKxW+iDAsfcezRvC7Px/CRB/WMUMOZa2B4b1l1xXZd9LJnmfB+x
	 Fb4K7b8SE1yGmd67RtOoz58wiyhK0bAT7xeI58I9IQvlYo6/DjjnajwqEn4ok3sHta
	 0TlDVsTtI0xLz7b5pv4f1c5oxhm6SJPbGurmBaxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfLZS5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 13:57:13 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44748 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfLZS5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 13:57:12 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so20757056iln.11;
        Thu, 26 Dec 2019 10:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bfFASreyzqEKIaIlQEpKOKdP7fjtn5hK821zVwpHaQg=;
        b=UKnTkfk3sKiD+1Si4Fuwie6HBVKmziVqG8kPEpZMIlXT1fXfA0uZ4OUHRuy/jBng/X
         LJPOLFTa1UvbN/td4f33GgdShyM2luvbwEVfIq7BVfHQvjZUPtdakj1GS4hcF3ucQx51
         DwVBjQgvCovW0PYKLstKtI5zx3HQPNWhQ5kUNaI7PpxpffgU5qwsYObk49MNntW44XCu
         FNrib3L00vSsaV1H+HIGTvRH/AVbYybNk7fI1apRfxuxrFxtUVlLqHLQdX/tPzAkQlL5
         7muOI4yfx1OihFRUNeYhs0IfCQ5OD9or9cgjIr7vyyADTjIGVK8xW0qPOhwmqjYnSC5R
         WSGQ==
X-Gm-Message-State: APjAAAVE2erL76cjmfYuB1hn0LBM4XFae/5X9i9DYJJ8qhLo4ryvPCVh
        rx7v1peIDgKjwmzb0l6toA==
X-Google-Smtp-Source: APXvYqwgg1UJCnGmdjOODKkwLbFlszTIpJ9ffWr9vGwMXlrCkaUxy18fBNKT9IVuOEOa3OdclX8XJg==
X-Received: by 2002:a92:b06:: with SMTP id b6mr38897567ilf.127.1577386632134;
        Thu, 26 Dec 2019 10:57:12 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k7sm6215606iol.15.2019.12.26.10.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 10:57:11 -0800 (PST)
Date:   Thu, 26 Dec 2019 11:57:10 -0700
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH V2 4/6] clk: sprd: Add dt-bindings include file for
 SC9863A
Message-ID: <20191226185710.GA13156@bogus>
References: <20191216121932.22967-1-zhang.lyra@gmail.com>
 <20191216121932.22967-5-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216121932.22967-5-zhang.lyra@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019 20:19:30 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> This file defines all SC9863A clock indexes, it should be included in the
> device tree in which there's device using the clocks.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  include/dt-bindings/clock/sprd,sc9863a-clk.h | 345 +++++++++++++++++++
>  1 file changed, 345 insertions(+)
>  create mode 100644 include/dt-bindings/clock/sprd,sc9863a-clk.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
