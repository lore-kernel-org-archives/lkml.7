Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE48C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452F320879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557769704;
	bh=ZMo/XKQSozcSyr5tIGrY/hUHUmfcwFjJFalqvHmmVbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ISmCY6RIGjFnxf32ze089qBixRbHsnFn/nr/LJwEic39FGneylllKPAU94kKXsITB
	 WUriuokR8hGoMfnfBDjpWQctXOqyaZ5EdpOfLLShTjIeRb9lXUeikf6Fvo391kMeJa
	 /SaNHhHczVKBibslROg//ZY0I4fF64b+NfmlVhQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbfEMRsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:48:23 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34973 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbfEMRsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:48:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id n14so5668708otk.2;
        Mon, 13 May 2019 10:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gkHpJzWFAksIMv+VI682dKhDhr4Fbw0OiglBoy3hzNs=;
        b=eFqyMYtZEPXKGobq8vjlWfQxdn5ATh+VwqVKIHgvLyAUgaPk82GPZuO4FBNEauL3Lf
         1QlhZSSzhbRVu3u8gTH4ZVI6XKFtYIc/txCOUiiz6g5w+306Ta9EMRbNn/03vLr4txSa
         RWq5U2eryyBflLMsCgmZFwA73aVYoenErDlr/OwdNAg8Rf1mOFVK0LunKKA21B4gSj/X
         8Yw1yuq0WXHR38oR9XkquSU8C+q6E69QjceQSbQP56aeN4SCETBJ0EQsNhh8b3YHomhy
         +evJA5/bI20ZPqA3otP5+RitQhWNsgpJv0mkY5K8PDhDUEqkvxdbNIdcYLB6We4/Nsv0
         y1RQ==
X-Gm-Message-State: APjAAAU7DvQKj6TefQgy09a8EzBqL9+xkFmCuVDRCAIXQgASg0ZFo/1/
        Lo3bBmNh7BN7rvXfArHZeQ==
X-Google-Smtp-Source: APXvYqyDNm+2TRXIedzOkppCtpoGAVu0Y//bfN1IBeyWcv0SwaLYFxVbDIaB5w/V3N+DpWu8gG67sA==
X-Received: by 2002:a05:6830:164e:: with SMTP id h14mr17428711otr.321.1557769701976;
        Mon, 13 May 2019 10:48:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e9sm6164134otf.48.2019.05.13.10.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:48:20 -0700 (PDT)
Date:   Mon, 13 May 2019 12:48:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v3 3/4] dt-bindings: clk: at91: add bindings for
 SAM9X60's  slow clock controller
Message-ID: <20190513174820.GA16840@bogus>
References: <1557487388-32098-1-git-send-email-claudiu.beznea@microchip.com>
 <1557487388-32098-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557487388-32098-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2019 11:23:35 +0000, <Claudiu.Beznea@microchip.com> wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add bindings for SAM9X60's slow clock controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> 
> Hi Rob,
> 
> I didn't added your Reviewed-by tag to this version since I changed
> the driver with regards to clock-cells DT binding (and I though you
> may want to comment on this).
> 
> Thank you,
> Claudiu Beznea
> 
>  Documentation/devicetree/bindings/clock/at91-clock.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
