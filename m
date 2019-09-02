Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04560C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2D921744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567436105;
	bh=2iRCgcqp5qaqZnSpQ0fhC/+o3V/XTcQ4wrl7fJlXkDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ooXo6Eu/FhAsk3TqPM4gk+JdJ6WdnEKve5ll5nqoTWmccGT2u2Fu5y1TNsy7Uu6Oz
	 SxvlHKtdgiMfBjwotiR7G57JPAV2/1TQhCNgSF1qUhlcwIYB+YKKaWwWNQI3z7FLLC
	 E9cySIryJXOvh7cgle1C56xKRW6DYQu2Zyi4wYmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbfIBOzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:55:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55508 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730559AbfIBOzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:55:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id g207so10934268wmg.5;
        Mon, 02 Sep 2019 07:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KGiL6o2AKBlfCr9GG/2iqSwFT36REWNAhdn8mXDglh4=;
        b=fai2arHgRaF5W4cTrtjZxuXpg8JZti7inVYehtehHW4KeWkAODsO+UXlNHPpdjZsEX
         9s7l2yWRGKDaj9Q17N8vGgxNJu3wIDWLuXz0/TaT4fBmU6amBLMkbw8TBiEILrrClZah
         jq3KJQCCbqBJNbO6ax4DHLrE75qAvy2AMobXlitDVQewUmiBwJOFJwrf6AbLW9rfZpK9
         5DYfst3ot8sCNZf6nOUCgfzO3fNXru+Y6ftKSIlRDeKEKSXp1XeVMDBRiXLseMV6asET
         OqdefyWfhoEUawLpA6jindfgH2QOXjWkLLA7T2Nq0KLA2iPYpJX6jLkye0lLKlk9HN5Y
         ZYuA==
X-Gm-Message-State: APjAAAUNkuJERn6GHasVi7Nx5Oa1K+yzXElUQOMZBFLvkDi9dqdBVdYY
        6gFipSOprgkjsF8Q/My4yw==
X-Google-Smtp-Source: APXvYqz8zGSRcnE4QcIbeQv0H8SeUa+1A57aG/DyjksFCdGkM3lKqZUgAKtC1sPHrHzJdb34+lfGlw==
X-Received: by 2002:a1c:a851:: with SMTP id r78mr6276054wme.166.1567436102570;
        Mon, 02 Sep 2019 07:55:02 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id a11sm15515964wrx.59.2019.09.02.07.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 07:55:02 -0700 (PDT)
Date:   Mon, 2 Sep 2019 15:55:01 +0100
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Pitre <nico@linaro.org>,
        Sebastian Capella <sebcape@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 4/5] dt-bindings: arm: idle-states: Add punctuation to
 improve readability
Message-ID: <20190902145501.GA17528@bogus>
References: <20190830150302.20551-1-geert+renesas@glider.be>
 <20190830150302.20551-5-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830150302.20551-5-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 17:03:01 +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/arm/idle-states.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Applied, thanks.

Rob
