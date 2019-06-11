Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9F1C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156F520883
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560289887;
	bh=Ix8HMLnSDUMj+DYq2QkyskiJwe4yGG1VLNHrBJQZsbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wmFbH82AhgeHOfMRiDUhmTMLHUM4B7rwrv9zx3M0dIai/G6PXWMtPupO8pbxVwyy8
	 zHKfjF8p4nxF3A7z+xqFgUV7hBWJ2oxNR5J7b5KRPh9zFH4W+PWwiJlq1YHk8n4gQA
	 MO2n6PS0SD+9hg9f4vEbNYbR/l+p3fX4nKulBdZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407161AbfFKVv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:51:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43338 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387764AbfFKVvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:51:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id z24so3241821qtj.10;
        Tue, 11 Jun 2019 14:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7TWYrDDzfkQtKv9+OVgy+qU0N7iuCHIvNR6+Puv9gzk=;
        b=t+CCjQ/Pno8etKWdXdq1tHmV9jJCkiK3vjVL3NDXl+m6Ao0EojqQ5DX62gOGUvo7Si
         4KcCrSA1IFdsgnyMdbnoKccTIZZEPw0BEjViBiYsbuqDWRyoZH18IDfAmEd4XW8Yd8Tn
         lznWPMz0TeM6xb9eBzO8/j/brznEyaxJZAkzIlCE6bmcdPAM8Fde1XmAfqZiknFJ4Eea
         6A5L7zeKP3yRQb4lNPyC53A4AE51rTlf0k8PyWIRWOyBpOGBPX1XIINprQ1xYLxHnTTu
         97ljUN11XLZRJ4G7Ht3dg3TaQFK0bqIdcqBPICESTFdhm1fT4pKHLVqXYgTt+QWULmXX
         8q5Q==
X-Gm-Message-State: APjAAAVQVPmGd+giTO9948yVDdwRtq6+8BTkEzTSWD248V2KBMxXMp7Y
        N0yxc5WdMIsX88I/S6vQuQ==
X-Google-Smtp-Source: APXvYqw41EKa1vDT4YG9KxPTlR+OKZ8vNQM/geD9FeXtMv78BxIbs6gCj41LNOzCA2dBvc4h3ZRhEg==
X-Received: by 2002:ac8:2bbd:: with SMTP id m58mr67089312qtm.225.1560289884437;
        Tue, 11 Jun 2019 14:51:24 -0700 (PDT)
Received: from localhost ([64.188.179.199])
        by smtp.gmail.com with ESMTPSA id r5sm1914028qkc.42.2019.06.11.14.51.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 14:51:23 -0700 (PDT)
Date:   Tue, 11 Jun 2019 15:51:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] dt: bindings: lp50xx: Introduce the lp50xx family
 of RGB drivers
Message-ID: <20190611215121.GA14337@bogus>
References: <20190523190820.29375-1-dmurphy@ti.com>
 <20190523190820.29375-8-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523190820.29375-8-dmurphy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 02:08:18PM -0500, Dan Murphy wrote:
> Introduce the bindings for the Texas Instruments LP5036, LP5030, LP5024 and
> LP5018 RGB LED device driver.  The LP5036/30/24/18 can control RGB LEDs
> individually or as part of a control bank group.  These devices have the ability
> to adjust the mixing control for the RGB LEDs to obtain different colors
> independent of the overall brightness of the LED grouping.
> 
> Datasheet:
> http://www.ti.com/lit/ds/symlink/lp5024.pdf
> http://www.ti.com/lit/ds/symlink/lp5036.pdf
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/leds/leds-lp50xx.txt  | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lp50xx.txt

Reviewed-by: Rob Herring <robh@kernel.org>
