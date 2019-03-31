Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A56C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1675520850
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014650;
	bh=u69EMwl5l2x5kbiR8Im/75ADaDL2hFZ9caRy2V+pu3o=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=MQfFP1uBaYJ1hYY6GuPSQe2y+DkquBpvED9+63mg9lf5MgvkwX2oR/SY6fDKPFwU8
	 a5edhXTrnT+JOmV1b3SjwlZxOWbQRRiWqNlhgN+flwlf+nrG2fj482IJIMTGm/ezxl
	 t7z8ZSrXMCta2fCI1ziP9dcMabkr/IyVlgwG84KU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfCaGoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:44:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45759 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731114AbfCaGlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so3144030pgk.12;
        Sat, 30 Mar 2019 23:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=1FDBaNlGzTZOabz2G6pNNlF811BCBmirMH7RLfw9guI=;
        b=syKM+fsv43Ap6HhH3UNlpHmjuXHdCfXPKk33qsxcZraFFPxXPaOetR3KA83ZsBRlbt
         ps4ODQyGIlBM+hgy+Jyu7ICDwfzRVfk2k20fNMTbIgx+qIGhAYZFPMr12T/MJ9QvzdVk
         oc+GuVKu0ZfAE/3b8FqyqhO9OyrDYfSU5o84Wy4+kcTfrCahYAVp6seSlJHpi+Q+5JNG
         ISRq98Ou7dTXYEagdta2ia3kKcHMeF2hpv4nNl/0aEHugub/UaTWvKi7e9xGB0C7OUxw
         CcYhhAYtCel4V6uCign3F+qlftc/3MzMWo+x473GBJ0q9VsC6abEmpXExhqMmj9oMBNz
         t5gg==
X-Gm-Message-State: APjAAAW8BDVu9WRlIozXePnmB3ecPOfyctH16NdwRaVHCb5uKUACS/AF
        9cf4ux92qKLvw8hdY1bXUA==
X-Google-Smtp-Source: APXvYqzjpulqm2D0FgsVP2s1RDiocmWoMWabkG0JRUyPcNgUrX2IYPnUhcTpUBHeLpEMF+vOpbUp9Q==
X-Received: by 2002:a62:1701:: with SMTP id 1mr48224917pfx.120.1554014475024;
        Sat, 30 Mar 2019 23:41:15 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id h10sm9917892pfj.79.2019.03.30.23.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:14 -0700 (PDT)
Message-ID: <5ca0610a.1c69fb81.2165c.a742@mx.google.com>
Date:   Sun, 31 Mar 2019 01:41:12 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: display: Add Novatek NT35596 panel documentation
References: <20190321135955.25661-1-jagan@amarulasolutions.com> <20190321135955.25661-4-jagan@amarulasolutions.com>
In-Reply-To: <20190321135955.25661-4-jagan@amarulasolutions.com>
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

On Thu, 21 Mar 2019 19:29:54 +0530, Jagan Teki wrote:
> Novatek NT35596 is a single-chip IC solution for small or medium-sized
> LTPS TFT LCD panels. NT35596 provides  several system interfaces like
> MIPI/SPI/I2C.
> 
> Microtech MTF050FHDI-03 is 1080x1920, 4-lane MIPI DSI LCD panel which
> has inbuilt NT35596 IC chip.
> 
> NT35596 support several regulators on the chip, among those only 4 regulators
> like VCI, VDDI/DVDD, AVDD, AVEE are used during power-on sequence.
> 
> Out of four regulators MTF050FHDI-03 panel do support 3-regulator based
> power-on sequence, so this patch documented these 3 needful regulators
> and rest can be add while supporting new panels on the similar chip IC.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../display/panel/novatek,nt35596.txt         | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt35596.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

