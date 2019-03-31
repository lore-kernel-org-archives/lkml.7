Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5604DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2532721874
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014478;
	bh=hGKF3L2njiKxfELHeY0fQbZ+SxxO4ZQulkfhpRz9jfA=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=gnCMGmjZeNzRc+4jAMcQIX3J5aHO/QUutKotf7KWkIeheEFmulAGnX+9CbAkpfgU+
	 b1Lmy6zsB2JAh4PadNlLAjoX7ls83a19znShS8Lp2XQn+GuWbL+o3bhR9vjKmadbEg
	 XZRWWE+yz7Cp8vnYBa+QsJ9wE5YN5UH9OdGhZL0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbfCaGlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:41:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42827 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731100AbfCaGlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so2972716pfn.9;
        Sat, 30 Mar 2019 23:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=JqJntnEGEtPz/2wcv2/iCRiArcAZqCM+5OWezMXCJxg=;
        b=huKOO20Fc6/VPLm6xa5ltwzf9X+LZ44vaQWf1DbIABcjvVRKOgjNc2s4y+q55LM9fi
         f94OqfpnoIIolInaIy3tyus1D3IfEvRFMP9M9BL4k4HqPdNi8cZ1VIDEzCLkjlXWTvkq
         /rN6bMrRxr1/lY6kB+FxpwxGP9gPusjmK4mdoNdPlB2oamH1K6B3mAQfQTGWp5me2bDW
         avgRrzCqScf54iWkB+BlyY1Ic99qmnElNcFV13OLsXYAAXu2rqwUP3wWmXsl9T67KcyQ
         1SNLzy0CNIsryBtVy0tHDuYKpyuaKb3eM+cVLACI2zWmqsv76/7OR9Q3oshAz3g3aaMN
         L4YA==
X-Gm-Message-State: APjAAAVyfFjfhsP3GOnYrIa9Xku9fw4bDOIqILeRmd1NXOjdJShKjQDz
        TR3c/TfQseiDzdoPHAeJvA==
X-Google-Smtp-Source: APXvYqxcWng4OUsvQ8nlHZf2XrKFxlYRH1MekRs+sMyjM9jLhWAlhlhds0U6jNUdOtYzK34nxgo3YQ==
X-Received: by 2002:a63:530e:: with SMTP id h14mr30584761pgb.136.1554014472449;
        Sat, 30 Mar 2019 23:41:12 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id k72sm15101286pfb.122.2019.03.30.23.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:11 -0700 (PDT)
Message-ID: <5ca06107.1c69fb81.ab31f.38e4@mx.google.com>
Date:   Sun, 31 Mar 2019 01:41:10 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: Add vendor prefix for microtech
References: <20190321135955.25661-1-jagan@amarulasolutions.com> <20190321135955.25661-3-jagan@amarulasolutions.com>
In-Reply-To: <20190321135955.25661-3-jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Ryan Pannell <ryan@osukl.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 19:29:53 +0530, Jagan Teki wrote:
> Add vendor prefix for microtech, known as
> Microtech Technology Company Limited. a known producer for
> Liquid Crytal Display modules and Touch Panels.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

