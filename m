Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D970C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E9320665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998847;
	bh=ePYdKazTRu0FjZC04MWD1PPIpj34f9rYNiOeACP9hV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O871sG8bvfCyHRItH2BeMZAtQlRCdstklatzOYonH3nOBKqnjOaPwIGCaIzXRfrNs
	 46YybGAPlF3mDJ6LnegV2JMDQP09yKeT9oR4tfZ2qSntgHXMAEQ9rT4knQAvaDuvPt
	 4YouSsGo2GklT5XrKWw0eWy/8DTl7KyMIJrb5ZCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392684AbfGXUHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:07:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44744 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392355AbfGXUEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:04:04 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so92129297iob.11;
        Wed, 24 Jul 2019 13:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2uycp2gga3gM+KOCP4bhhbNNGiztJcFj+cixg7Ny5a8=;
        b=qj4nntN6sJBEUn0BhG1MicvenH481pV7apL3l2lyj1vmlaPhu+UUjdN9/cb7U9/SDV
         StX75HN36FTjbWwlviH64ZBEllhxV6ZvaonlcojlzArvynsvg/M4t36DaDbX//neeltI
         7gqQdlsRxet4Nq0Opv21D6ZAbE2/5X40cD4zxaSxx7hocPvIxJonjI40eo+IgK/33HR6
         RPF/zBfmC57no2F3ot2gqPQgEW+dOpkrNlH8I3whYN5KeMwoMjA5gIJ3KiBJsMUrNuSz
         VT4km3Dpkcf0shMdJWQRzb9Dvc43jllG8eROrpNr5CBMGuHzWvRf0idqJhNdOL2rcDry
         5nXg==
X-Gm-Message-State: APjAAAXxTImJGn37f5R78+Y7HviQOJldgbElvZYaDKDY5buSakk8C5aZ
        HnzmI/o6cLQCvkxp8WqckA==
X-Google-Smtp-Source: APXvYqxVgzs7Z4nbFzTiE8Dg1WGnxjhQTgBQ3UGeU4dqV15F3jI/eEMSMkTn8E1P1ohSUYz0jjYwFg==
X-Received: by 2002:a5e:c00e:: with SMTP id u14mr46190740iol.196.1563998643068;
        Wed, 24 Jul 2019 13:04:03 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id p25sm37965705iol.48.2019.07.24.13.04.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:04:02 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:04:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH RFC v1 1/2] dt-bindings: mmc: Document the Amlogic Meson
 SDHC MMC host controller
Message-ID: <20190724200401.GA28867@bogus>
References: <20190708173330.13217-1-martin.blumenstingl@googlemail.com>
 <20190708173330.13217-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708173330.13217-2-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Jul 2019 19:33:29 +0200, Martin Blumenstingl wrote:
> This documents the devicetree bindings for the SDHC MMC host controller
> found in Meson6, Meson8, Meson8b and Meson8m2 SoCs. It can use a
> bus-width of 1/4/8-bit and it supports eMMC spec 4.4x/4.5x including
> HS200 mode (up to 100MHz clock).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/mmc/amlogic,meson-mx-sdhc.txt    | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
