Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86E5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9240720823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553786254;
	bh=V6ORkVWd11slwxFJpCCAYlNhctpkIDErOnLqqL/4ZSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Psa/dqv44I3d7tEiADO7BbQ/igwW2OiiXuMg1H1fwYjqXTn18YeBj36TzTyIZ2mqJ
	 cRN3qejN5ZbIctOeFS6cBBe5PkdLfpQjNL3t8Gb6C/yXxaarpyKiiE+W4bCPaZWWgb
	 lHqcpRT29pFsqtfxp7V6I2LVduPPigyy15Db5UDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfC1PRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:17:33 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36559 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfC1PRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:17:32 -0400
Received: by mail-ot1-f67.google.com with SMTP id o74so18676698ota.3;
        Thu, 28 Mar 2019 08:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OS6pHgTLBklX9XKfAD0SUoPMglmUTPXYkJTZZLPv0Rg=;
        b=mN1HteP9exlxmwLd65xzjI59VBkBtnh+wm+BRkBmeY6ueJQTRtjEpa0CET5ZChWAdv
         jE98Bzcp4jqTJDxs4QbwMQFlzooIy6FP75KewwP6Q6q5HZP/6Yr/8IZbGjmYLOkcqZ66
         GAnv2uyjHv5vJgdrhZ3vPP2iv4FxSLyWFhg8msReZK3UBqRNact2V0y3EUSyUePasJKZ
         ASYcPjw3oRw3rUioUXWGEBQuw3USEhTJ4w7DQuWK1+bD6ilJJ2Erh/ChFr0ffX7vxmOo
         MKEi5lA5gywMpmsxhPwRMuN7H1q+PyYdzhGx/yQB7F8gMXensJGe8pH63C+JDaaBFmi6
         SkpQ==
X-Gm-Message-State: APjAAAVLoFrsw/RM8Ia59zEiEtlcOt8xbwKpEzsPoXtAzYsbZHJAfO9U
        oS+JD3unUC6Vg/Tn+wf18w==
X-Google-Smtp-Source: APXvYqz6CO9Z49GS6bebLHKeOspUAbs9CyLMtEZ4rG9Z0A12FunJginBtlTCujm5v4lz1c0E8GHLww==
X-Received: by 2002:a9d:5c0f:: with SMTP id o15mr29381833otk.329.1553786252045;
        Thu, 28 Mar 2019 08:17:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z2sm10840270ota.56.2019.03.28.08.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 08:17:31 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:17:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/3] dt-bindings: display: amlogic,  meson-vpu: Add G12A
 compatible and ports
Message-ID: <20190328151730.GA20801@bogus>
References: <20190313141030.5958-1-narmstrong@baylibre.com>
 <20190313141030.5958-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313141030.5958-2-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 15:10:28 +0100, Neil Armstrong wrote:
> The Amlogic G12A VPU is very similar to the Amlogic GXM VPU but with :
> - an enhanced plane blender, with up to 3 OSD planes
> - support for AFBC 1.2 decoder (for Bifrost GPU)
> - support display mode up to 4k60@75Hz
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/display/amlogic,meson-vpu.txt         | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
