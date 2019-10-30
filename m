Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD0FCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB1620856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572444331;
	bh=ZuUiTDgUv5S2fTS68p6zB02Iv12+tMIYIvgBkhw5i+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0ftjrW0x0dW2KyWLT0aBTQWDkbYcCaD5ZKvQA0XQCsnXBJ8Xb/+VdeoYr7esewF3Z
	 yMwzHJgH1Xb7BOIgKV4rGu9VM5vDUI215B07VNVfC7U7hZUf7thsUXY1a8TDgCff+U
	 8cAxH9oMEYb02Hb7D79YNcbQKyWFvY3RfmysjVs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfJ3OFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:05:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45184 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfJ3OFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:05:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id 41so2157889oti.12;
        Wed, 30 Oct 2019 07:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ChHUj/J4C6CXN9f7IReGKz0UHWgPVSTJxbHYeBoXnqk=;
        b=EmPmClZLFx1THgnfPeTYYNT72uEoayQVNsGYXCqBFDD0pLEVVthUg1YUjWMHz6WIev
         0IAY49AHUW7I8WHKIjSYySGYZ3n/1i+djlW2DwLscQqPYXTTFqfDt/AKFYjDsfJMSKIa
         7eViJ1CIgpxesflv3nyG0McDcj/q4ZxwhwvReUD0Dq2aX8mxFCh25y9Qi7dQCmL6KDQY
         shzXblLF0Co2bbI3paWAZi3ryq6wFEZXbVnAURA7K7J5uKYQx7Oqb7axSt34qcMLzvTE
         R08GNL+jJAVIJqZh07c7h/lvsfvzUjusQ8kEcomNyPzGpSbHkgZn7MPMOtn8yil3AzYX
         Fz7g==
X-Gm-Message-State: APjAAAWdXZOkxYI93m5viGQh0hCIB1LGH5GSho73VoymIvBiqnngye/x
        5ybGLrQv9tNVptSPJNbyrQ==
X-Google-Smtp-Source: APXvYqw0JFuV9/nja98wwg1bHqjpHHz7+RxqG8NqaK/yVTDxQRIuqFRJQW343FA0qpCng7ta3UI/5A==
X-Received: by 2002:a9d:5e12:: with SMTP id d18mr54420oti.220.1572444329580;
        Wed, 30 Oct 2019 07:05:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 88sm57224otb.63.2019.10.30.07.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 07:05:27 -0700 (PDT)
Date:   Wed, 30 Oct 2019 09:05:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/5] dt-bindings: arm: fsl: add nxp based toradex
  colibri-imx8x binding docu
Message-ID: <20191030140527.GA6180@bogus>
References: <20191026090403.3057-1-marcel@ziswiler.com>
 <20191026090403.3057-5-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026090403.3057-5-marcel@ziswiler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Oct 2019 11:04:03 +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Document the NXP SoC based Toradex Colibri iMX8X module and carrier
> board devicetree bindings previously added.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Document board compatibles in a separate patch as suggested by Shawn.
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
