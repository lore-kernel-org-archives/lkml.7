Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E7CC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F740214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569416871;
	bh=z9U2u1eJm77iSS217DHe30P6Z27QGW02D0GUrC8Tqq8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ELg8UryuXJgTd+zwFjpKQD9ka08AMpGEXj8AFanQLmSPGE5AlYuyGvsIM4nJF/auo
	 6dNiNaYw6akkgOeHzVJF+8rVEQdON453VaTjEBQTTExKwoMtuc1t+TPLBSqnfbx8bK
	 byxsmGEUH8brRKcyCzXoxi/2H0Bi+LV56tzdABco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406082AbfIYNHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 09:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405791AbfIYNHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 09:07:50 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 395B620640;
        Wed, 25 Sep 2019 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569416869;
        bh=z9U2u1eJm77iSS217DHe30P6Z27QGW02D0GUrC8Tqq8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ReGnkPpVh6OjQAOBCXxIsSyroDLXZKq4VGXm8qiXRWqf2gRJM+5iYY1M6sLuChI3+
         3hnDcDM5+HuhGn/D7+C5S0GgR4U3ne2+M5gXRJVV84Jg5E1+BlH3HSMxuTJdtPnh3a
         WhghRjpohCCKjsLUbcWRVXFqvZHNxI5kqAptmriw=
Received: by mail-qt1-f179.google.com with SMTP id u40so6420388qth.11;
        Wed, 25 Sep 2019 06:07:49 -0700 (PDT)
X-Gm-Message-State: APjAAAUGeq5iVt+48LZZXdpvCUe/GbKIx1SZH9oWCHTkhh5+wbYoS397
        LouQAnealJ/H4MlfBSjDVkuZ+x4iCv9bs/lg8A==
X-Google-Smtp-Source: APXvYqy8xSNSZuLq/5OS0tlsIcIHbHGo7t00kiTteAmoF+SyyYorxN89hVi0vNFSwJToBOy5sLycJNN4ZLxt3RK6Ds8=
X-Received: by 2002:ad4:528b:: with SMTP id v11mr7322949qvr.200.1569416862333;
 Wed, 25 Sep 2019 06:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190925084932.147971-1-paul.kocialkowski@bootlin.com> <20190925084932.147971-2-paul.kocialkowski@bootlin.com>
In-Reply-To: <20190925084932.147971-2-paul.kocialkowski@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 25 Sep 2019 08:07:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJY+d9frxuxspvo2SQ=vpWMCAWZfMODA-jm_rKu1GOEaw@mail.gmail.com>
Message-ID: <CAL_JsqJY+d9frxuxspvo2SQ=vpWMCAWZfMODA-jm_rKu1GOEaw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: Document the Xylon LogiCVC
 display controller
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 3:49 AM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> The Xylon LogiCVC is a display controller implemented as programmable
> logic in Xilinx FPGAs.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../display/xylon,logicvc-display.yaml        | 314 ++++++++++++++++++
>  1 file changed, 314 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml

Error: Documentation/devicetree/bindings/display/xylon,logicvc-display.example.dts:17.1-6
syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:321: recipe for target
'Documentation/devicetree/bindings/display/xylon,logicvc-display.example.dt.yaml'
failed
make[1]: *** [Documentation/devicetree/bindings/display/xylon,logicvc-display.example.dt.yaml]
Error 1
Makefile:1282: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2
