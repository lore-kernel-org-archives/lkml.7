Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74DDC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C952073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575411125;
	bh=2+mUxustzPlC5CGQyGryca6Be+OVrhgg9b66NAQUyRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S+xumNCW+cT2GsUk+G7GeUF5/wLJ1ALNZNVwa4F4VfB2vRNt61Xsvai6bpiZEFnud
	 iXnTwyMUy9fc8uLrOAo2K71JUkF1Yo9fHYuucMk2slNP5zQGt+nhrMSkIpYb00c85V
	 z58ei3GLHPTKhZJSwQVKF0ImcG0sdwRNfAX927c8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfLCWME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:12:04 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45487 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfLCWMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:12:03 -0500
Received: by mail-oi1-f196.google.com with SMTP id v10so2836722oiv.12;
        Tue, 03 Dec 2019 14:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pldoBT5ORXz4aapzHPt3ccAwmiFN0lj2178c3XaiQRo=;
        b=GHII+SPUGu61cq9f9EygA+sDBDn/nUowmErILj25N/vyTM2TKzfHzFtC3snhf5x+3o
         AoY/IIWvnNhP2NCUSR9kUC2yyczFC4KaSYgIByXOOavpd4KNrW9BOz+rXO97e/O5ulES
         fUVyyiNkycrSI1JrmV8SCWzNdOix3ln74IUfMw7Uu56ZPoehCKMUE0ZcTJ/6BYWriACk
         HoVOvCvufJnBBOrIunyfgQG8troB4jwmsBqtln2xxXHEfdFIPt54drxQSev3MA4wReK4
         EbHd5B/XhOH4zIEOEI3jUfTJC7BUF5pVGzRuCac1W7yTaZhDGJyGOqONfJtATVsG/JPh
         RWug==
X-Gm-Message-State: APjAAAWQZWXuuJfJq1Qpxp9kp0yA1OtplPjRx7JuAU+Kd2HFIqW1IKmT
        P847k0YOdigz4R5XSx4qFA==
X-Google-Smtp-Source: APXvYqysvr90M90SJ2c9VBE2qhNi1oQIbDw7W8BDqJAjL+rSeTywUX/kbsja7PlOsf7oL6ErQP69kA==
X-Received: by 2002:aca:4ad8:: with SMTP id x207mr208772oia.148.1575411122893;
        Tue, 03 Dec 2019 14:12:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w12sm1486360otk.75.2019.12.03.14.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 14:12:02 -0800 (PST)
Date:   Tue, 3 Dec 2019 16:12:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/6] dt-bindings: display/ingenic: Add compatible string
 for JZ4770
Message-ID: <20191203221201.GA3201@bogus>
References: <20191119141736.74607-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119141736.74607-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019 15:17:31 +0100, Paul Cercueil wrote:
> Add a compatible string for the LCD controller found in the JZ4770 SoC.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/display/ingenic,lcd.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
