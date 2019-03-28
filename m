Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754ACC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359BB20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553786274;
	bh=h7Y32MSkQe8PHcc100BPXSjLpxuFO0QnljThxy95IZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C17aqC8JoNK8wiUjXwLqr8WDWZhUkkOx456GvacP3WlPAn4MywvnxbHv55vHmihOZ
	 PhffBh4LLamX4LCHNTz4lvj8wNN6oKDkcYCjubSFlpnfXLKCO/ILnHFDb+fccK2h/u
	 7wKVNyPO00Qgdn2r3+FaMuiHXyU6KFBVGWZcJWpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfC1PRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:17:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41286 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfC1PRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:17:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id 64so18645949otb.8;
        Thu, 28 Mar 2019 08:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XKFOM54+2ObR8/c8w6Od7RwzgBu/+7D27/71aliV5p4=;
        b=a9KH1Ky6+rWYG7VvV5pF/rbIHV7Qn9R7wXNLn7hbyU6ZctdsJrW98iyAqY2LhFXBs3
         FdMRbKMZafiCXK/uKYuZo7oG4X2imT5K+yPXvTODhI1L7Pg2RxKIKnv/DdAJVR0scqwl
         ySVV7/+jdJ8hQTs2h/OsQtE1vo963RKlbpXrIsMj61pCG2nRw8fy19QzcbORYathprJU
         2wG8A27ewj5jUQh7dBPdBGSUqVudsK0u+VeGZDBOnJz4cuA0ZLKveQe+xLb/BLI4fHJd
         tm6VXYgV/7P+iu9xUBJseQnsCtreLxbpq7nyAC5487PoHNDp8nXRm9MIktA0/YXYvnZz
         mpsQ==
X-Gm-Message-State: APjAAAUJ1wt9hyQ24DIFJqFlalrlmMBqmIofMUratJ3VYqUc1X0ZnR+a
        /grrsdbR9nqDQbyUd+2XZA==
X-Google-Smtp-Source: APXvYqyZVOfpGivqBJFrF/WwRAJa1eBMhSkz6MphVqYtlW2MeS2UwGq7L9c9uFOOQ6wgCU+onKuicg==
X-Received: by 2002:a05:6830:2090:: with SMTP id y16mr21668080otq.97.1553786272041;
        Thu, 28 Mar 2019 08:17:52 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 92sm9846886oti.60.2019.03.28.08.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 08:17:51 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:17:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: display: amlogic,meson-dw-hdmi: Add
 G12A compatible and ports
Message-ID: <20190328151750.GA21381@bogus>
References: <20190313141030.5958-1-narmstrong@baylibre.com>
 <20190313141030.5958-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313141030.5958-3-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 15:10:29 +0100, Neil Armstrong wrote:
> The Amlogic G12A SoC has a slighly modified DW-HDMI Glue with
> support for HDMI 2.1 and a different DW-HDMI register access.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/display/amlogic,meson-dw-hdmi.txt     | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
