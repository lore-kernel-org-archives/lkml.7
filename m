Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A610C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B24B206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553550563;
	bh=loCGWdWRCgQ4ODb/I5wJ3Qur9QjsL1OEKSSOzrmH+ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0h2ov1BOaPhGYODOz0rXCLlpksVhsi0yrQaYMYu2is+Yv5+KZic5HJux0A7hkxbZ5
	 LJkq6aIImHE8L57Q/oEYgY+t7U4QulBK+42fNgzsXZ7Y1MDNvKjDEwU90fTtt2DQEA
	 XMuhoo9Al5Szqjh8UecD0nMJecU+6qU5wr9wRqIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbfCYVtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:49:21 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37575 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfCYVtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:49:21 -0400
Received: by mail-ot1-f66.google.com with SMTP id c16so9558551otn.4;
        Mon, 25 Mar 2019 14:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ScNmWddgZ/o5Iw+Msz2tYeiVs0JP9FJuCp2wv2fVC+M=;
        b=EJFISnbHshitTAVSMi+xeG7N08j6BbwDzVXqkAi1jpOqWi9YuDoOKnerRP53vTnGFS
         1XcEjaum8XQ/pSNrcaahWu9sJX8rOYrFIxlxh2Xx9bRvpqNkN6UIIeFgeKJu6bJSUSe1
         xwHoO5n1gviz+Oa4edBmkmwtAgR3Zp4Ce5P5hBXTbQImegjV7fABt90lrrcVWmz1oNZF
         ofR3lwxH8RzqOhUvcNl7suIWajKtZ7cnWOExFgXkEGY/SrRJXj51J5WmnPEXQAReq23S
         uFvD+iSWslTn/fhajXzbAZmV0hFTuXTrwRzAXO8RIsFW9kNXIdl0Fh0cVIdr9OXIGnE0
         MiIA==
X-Gm-Message-State: APjAAAWWeEu6zo9VGWVRudaa/GbJtARdT9d18T19X84g3g1f14P115m3
        TfFdWZ/PWzZ7HE+AqCufIg==
X-Google-Smtp-Source: APXvYqxbQ9a+m9maskBICDTrMhqOQMpQbuuTDyrOlQczAbukFcZQfpyw8EMw17Rw+jTj8KgsvmbSVQ==
X-Received: by 2002:a05:6830:1c5:: with SMTP id r5mr8622234ota.360.1553550560592;
        Mon, 25 Mar 2019 14:49:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s62sm6562649oib.36.2019.03.25.14.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 14:49:19 -0700 (PDT)
Date:   Mon, 25 Mar 2019 16:49:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/7] dt-bindings: clock: at91: new sckc bindings
Message-ID: <20190325214919.GA31149@bogus>
References: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
 <20190219170200.3608-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219170200.3608-2-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 18:01:54 +0100, Alexandre Belloni wrote:
> Remove the need for child nodes in the sckc binding to be able to remove
> dtc warnings and have a more modern binding.
> 
> Also document optional properties.
> 
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../devicetree/bindings/clock/at91-clock.txt  | 30 ++++++++-----------
>  1 file changed, 12 insertions(+), 18 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
