Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AA9C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBE8216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567431543;
	bh=IdEhdiPSkDsjlNsgx16wvEs7p5ksFLbTw4aQPDJst/k=;
	h=Date:From:Subject:References:In-Reply-To:Cc:CC:To:List-ID:From;
	b=ZildHRa8dpFhzEk067lv2d0uw9WTg9k9+upMHspMvPpTTMz6d06ih2dFiXOlZEPAL
	 cFPJhHy/QmC5nHLE7Med9GdroWel8Y4P3cylWDBAXnCaUbXSYMUJ5nlL942A5PO+i4
	 9V72lKd5H7+x9lOLEIEFvtIfZkKhGyJmqmL6Ujvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbfIBNjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:39:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36454 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731067AbfIBNi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:38:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id p13so14703166wmh.1;
        Mon, 02 Sep 2019 06:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=SvhFRmoRlEP5dD+Rd/+9x0kDcEgKUm1JjWNc3Yoeqhs=;
        b=QaSx6xuYfR+h9wXsroTTJcSvopIYFaBdMMVZ1agwy6T5XR3T4Zk7/stnyRigGG57Zq
         G5typHiZCjmbc2TO6KTNEpLFVGOg3i0VmJ+W7RIxeZEHYEfNf8V6QXMsqmFz5sWkb9+N
         EufpWD2AlWxOTudXRqccFnySx3qU86lKWdp/5wH4t+KiZwdvppIsRaOXJQfiuxrM/1gQ
         /L/1ePwBkcvd4cvrzlyUV9HO84NogbeRiSzry4xHm1CNobRMrH0baeId/tE9CEo8WTDU
         UxQ4jIbe+rnw9tDxTo7UvvzZ80J/HcSbPTxdISIkxLl62W51QWFDlnb6dCULuVy4Tzmq
         IygQ==
X-Gm-Message-State: APjAAAVFlZm72a10Mb5EJPVJ6e7QeLjCj5do1ehf889qjZBGZfaI9E8/
        /ICQEVR781qFhskSCcQzPg==
X-Google-Smtp-Source: APXvYqy/kMjM4e+Q7ism1M7S1aJzfHDzEGzfxhVDRiXjrA+3mBmRb6rx1jsTojSZL5vijGvaOhqtsQ==
X-Received: by 2002:a7b:cd97:: with SMTP id y23mr5529846wmj.74.1567431536779;
        Mon, 02 Sep 2019 06:38:56 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id z189sm5491333wmc.25.2019.09.02.06.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:38:56 -0700 (PDT)
Message-ID: <5d6d1b70.1c69fb81.67069.6e61@mx.google.com>
Date:   Mon, 02 Sep 2019 14:38:55 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5, 05/32] dt-bindings: mediatek: add mutex description for mt8183 display
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com> <1567090254-15566-6-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1567090254-15566-6-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 22:50:27 +0800, <yongqiang.niu@mediatek.com> wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add mutex description for mt8183 display
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

