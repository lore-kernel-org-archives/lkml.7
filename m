Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F96CC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0809E216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567431618;
	bh=mdhCzFIipMrrsWsIJ+OtvEJhXtbXPCvP2/f62jXuw28=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=kQAYefTQZ4RxsDKGFhaOjrdt7P46oOkKZDZqPcNjDrAHJ6YD5Uic4kPBNweZEEiK/
	 peii74olDcdIpWInKM1peqkdhtx6vNOvVIRIimQ/WddOsmMznZWkZtoRi0Iw237J9/
	 mB+3CEzxV4ih329TLtFCSiyPzpCjnmsugZl+MAKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfIBNkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:40:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34257 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731082AbfIBNjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:39:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18so14117026wrn.1;
        Mon, 02 Sep 2019 06:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=nIU91uyfALR7pZxmZlabV/Ck4+B/SS4lhojtP2q6J1E=;
        b=Poe5zQXX/eV9110nri62PV7vfLE1F0RaHQozlFKgb8sci1XQCloY3ZG0monYqGPqyx
         IMQh5jGdYTYibVJB3S3VgpRy5/pdFucrSEfaXVyoIXyLuRqBKIo5cgIcYT8Saz+Nbifz
         hba9bunjkPz1ZKeI0O5wJOnO3aTuQqyno3beRK4dqmkMmWe+bCAE13NlntbxTPUMvbTI
         r0mQ18yJUHsvFkUBIdiy7CfD0RfR7cKcnHMmXXt2Jl1FSzqHb4ASAOm3f/lxPjOcsDYT
         QmyEFaRwQH4s1dZd7EUH7fGvpgjaHsmSJA8ale+/cbtFxD0ZpsVId4TOf1TW07mnR2PK
         jAsw==
X-Gm-Message-State: APjAAAUbkkamJA/TnfZ9aF2jPZpSiljDHNt+EuX1Jv4eojH1S62CU8ux
        uebxM0gAVhK2EuwWOKuMLA==
X-Google-Smtp-Source: APXvYqwfKQVt3Mr3ewoGFUk3SqtYWF82+bz7Kaq9hOuX/c9UEJG0BvvWCM/QLcW9c6m+tBcc0L8RAQ==
X-Received: by 2002:adf:a55d:: with SMTP id j29mr34500573wrb.275.1567431537897;
        Mon, 02 Sep 2019 06:38:57 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id m17sm15276009wrs.9.2019.09.02.06.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:38:57 -0700 (PDT)
Message-ID: <5d6d1b71.1c69fb81.f86b5.3963@mx.google.com>
Date:   Mon, 02 Sep 2019 14:38:56 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RFC 04/14] of: irq: document properties for wakeup interrupt parent
References: <20190829181203.2660-1-ilina@codeaurora.org> <20190829181203.2660-5-ilina@codeaurora.org>
In-Reply-To: <20190829181203.2660-5-ilina@codeaurora.org>
Cc:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com,
        linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, rnayak@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>, devicetree@vger.kernel.org
To:     Lina Iyer <ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 12:11:53 -0600, Lina Iyer wrote:
> Some interrupt controllers in a SoC, are always powered on and have a
> select interrupts routed to them, so that they can wakeup the SoC from
> suspend. Add wakeup-parent DT property to refer to these interrupt
> controllers.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  .../bindings/interrupt-controller/interrupts.txt    | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

