Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6249EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A14B206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553732374;
	bh=YSE3b1DjdTHrye/WNMKbjqxims6iHxk6U8OfJuXeYL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DY10bHEgk9GctVFng4OSTLo3X+ndX+lgX/ZHw5L5DGQZlkDzogoK6uuS78fgJ3U7m
	 ofQEXj0HehAXbJrSYdoQwZtrinSapreYPI9CPxlribnHoXGug3Qk2vESZBqnvYZp9/
	 4GrmdFbizseVmnI2XTrHT2olH3hluiTyN9ccL0xE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfC1ATd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:19:33 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42476 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfC1ATc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:19:32 -0400
Received: by mail-oi1-f195.google.com with SMTP id w139so14407955oie.9;
        Wed, 27 Mar 2019 17:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CQjPPVd5Rc418fG71L/vlclCtFDhBPlAseT0KLwhHec=;
        b=CDxdB9PaV5tx1U1dnzafpHc6iE0ECzjflek/p5mJWY60MpbuK8ZVKNr3ZIpfU7c7kM
         pDcMlbn2WlVzhXAKYXby9P1jsSPlR8Fxg6whKzMnDsgbtasTNXUVAbMGtoIJy6aXCIrg
         zDAgyyDC3ZOX/DvuKmtwTDRuM2bSz/CNb82HKmB7ko97BY9+DcjfiFGpAaLodauoPgD1
         /roKsOTYveSc9/gH1SJWmn3t+rJDWndZaSBt5Qt8juyeZhwpmxIZpauPPAaQYAB+hFHy
         HhDuLfPQpksJLl8T6dUyIlFMkiDgg8clpdVhJgQMKcI9p9vQt10rFNTgS6Ocd9LxMrhu
         AyIg==
X-Gm-Message-State: APjAAAXCh/of6nf3harBq91s67QG+ut/U7rj6+5ft/f+378of8flR5tm
        Jk2MxHWsum6A1n1C8Jmnbw==
X-Google-Smtp-Source: APXvYqx5uG8s7k299x4VII6JWaP0JcQB0wJOx/d4YaF+tnScDhQirQ8QP8SB3hNJs6mbJ8mOVqZYzg==
X-Received: by 2002:aca:eb93:: with SMTP id j141mr21060558oih.178.1553732371938;
        Wed, 27 Mar 2019 17:19:31 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x89sm8912788ota.30.2019.03.27.17.19.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 17:19:30 -0700 (PDT)
Date:   Wed, 27 Mar 2019 19:19:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH v2 00/25] Add generic support for composing LED class
 device name
Message-ID: <20190328001930.GA22901@bogus>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 07:28:11PM +0100, Jacek Anaszewski wrote:
> Changes from v1:
> 
> - improved led_parse_properties() to parse label property at first
>   and return immediately after parsing succeeds
> - added tool get_led_device_info.sh for retrieving LED class device's
>   parent device related information
> - extended LED naming section of Documentation/leds/leds-class.txt
> - adjusted the list of LED_FUNCTION definitions according to the v1 review
>   remarks
> - added standard LED_COLOR_NAME definitions
> - removed functions.h and moved both LED_FUNCTION and LED_COLOR_NAME
>   definitions to include/dt-bindings/common.h
> - rebased leds-as3645a changes on top of the patch switching to fwnode
>   property API
> - updated DT bindings to use new LED_COLOR_NAME definitions
> - improved common LED bindings to not use address unit for sub-nodes
>   without reg property
> 
> Generally I still insist on deprecating label property and devicename
> section of LED name. The tool I added for obtaining LED device name
> proves availability of the related information in other places in
> the sysfs. Other discussed use cases are covered in the updated
> Documentation/leds/leds-class.txt.
> 
> Beside that, I tried also to create macros for automatic composition
> of "-N" suffixed LED functions, so that it would not be necessary
> to pollute common.h with plenty repetitions of the same function,
> differing only with the postfix. Unfortunately, the preprocessor
> of the dtc compiler seems not to accept string concatenetation.
> I.e. it is not possible to to the following assighment:
> 
> function = "hdd""-1"
> 
> If anyone knows how to obviate this shortocoming please let me know.

Raise the question on devicetree-compiler list. I've done my share of 
dtc patches, but the parsing side is generally not an area I touch.

Rob
