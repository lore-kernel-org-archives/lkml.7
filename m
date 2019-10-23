Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45F5CA9EBC
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D92205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Q0YbQZaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436855AbfJWWoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 18:44:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45756 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436833AbfJWWoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:44:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id y24so6868822plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 15:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wJ06TDHk8fanWw9hIr0dlUGtwGT9heBDo9sS1XVH1y0=;
        b=Q0YbQZaH/L4srXxXyvDFIWx1ysQxXlP55psWE1LNH+IjT01Ljw0z9KfO9RWy/h87Cz
         8IXn5rrkI8UlEKeYlzgkWymmy0BAdnOPJdRvcfutt6P0d/D3CHuk3De3Bamw3FYKpbsc
         qTwUeoKbLdBtOVM+FGvd6CRdi/gbxV332QVTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wJ06TDHk8fanWw9hIr0dlUGtwGT9heBDo9sS1XVH1y0=;
        b=g3r5jYIWMob9CyLJUylWf5ZgFQ5dR0iWKIJv+75/CtFz5cnd2nUqGd1CJU9W7cBslw
         57Z/Gzxwa8Nn9hNe/ISXl+FzEmnz1/76G0VembmYdUQvXi3JyuCsEACS8kA2adka+GIY
         iqyKsd0XUqup2d7GTWx7uP5sHXRM3gUGt2cOy6XqALOQNIyHrEUQOSpfRGX6qIJHaiAd
         QrUyinvWsscRjAi6rCPUUjL8QLv8rtAgPORlkDZGasz5CQ92gguTdfhvaIq3iog5C973
         u7hT73e20ZeQ7hSd+QadAuT2KaN+ieRMPi3mth/LY56lgxQsN9T4zVBcYsS9pU2o8jLA
         11vQ==
X-Gm-Message-State: APjAAAUFFPWKt12/07PPsA+D6HnJvnhms5DSn8jJX8evpFnqgsmVrrpu
        rKZArTvEgJDZ0odD2wrRqhJz0A==
X-Google-Smtp-Source: APXvYqxMMvMklUkKQ1AwFgso9IZAHy69PdeeT4onSQJXGUydKwe7gOr+jUTNMnGWoDo4Gxti1z0uCA==
X-Received: by 2002:a17:902:8691:: with SMTP id g17mr11650908plo.231.1571870644218;
        Wed, 23 Oct 2019 15:44:04 -0700 (PDT)
Received: from goma (p1092222-ipngn200709sizuokaden.shizuoka.ocn.ne.jp. [220.106.235.222])
        by smtp.gmail.com with ESMTPSA id h4sm25347209pfg.159.2019.10.23.15.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 15:44:03 -0700 (PDT)
Date:   Thu, 24 Oct 2019 07:43:58 +0900
From:   Daniel Palmer <daniel@0x0f.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: arm: Initial MStar vendor prefixes and
 compatible strings
Message-ID: <20191023224357.GA26445@goma>
References: <20191014061617.10296-1-daniel@0x0f.com>
 <20191023200228.GA29675@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023200228.GA29675@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 03:02:28PM -0500, Rob Herring wrote:
> > +# SPDX-License-Identifier: (GPL-2.0+ OR X11)
> 
> (GPL-2.0-only OR BSD-2-Clause) is preferred. Any reason to differ?

I used the sunxi file as a template and thought they had some
reason to do that. I'll change it to just GPL-2.0.

> > +      - description: thingy.jp BreadBee
> > +        items:
> > +          - const: thingyjp,breadbee
> > +          - const: mstar,infinity
> > +          - const: mstar,infinity3
> 
> infinity vs. infinity3? What's the difference? It's generally sufficient 
> to just list a board compatible and a SoC compatible.

Apart from some very slight differences (max clock speed, different PWM block)
they are the same and the PCB for the BreadBee can take either the msc313(i1) or
msc313e(i3). My v2 patch will remove the mstar,infinity line from there and move
it to a second board called the breadbee-crust to handle the i1 configuration.

Thanks,

Daniel
