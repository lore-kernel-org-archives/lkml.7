Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989A9C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 18:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B302082E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 18:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfK3Sfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 13:35:52 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:38428 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfK3Sfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 13:35:52 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6B3198062D;
        Sat, 30 Nov 2019 19:35:49 +0100 (CET)
Date:   Sat, 30 Nov 2019 19:35:48 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: panel: Document Frida FRD350H54004 LCD
 panel
Message-ID: <20191130183548.GC24722@ravnborg.org>
References: <20191120171027.1102250-1-paul@crapouillou.net>
 <20191120171027.1102250-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120171027.1102250-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=6sA7AJTnC8BI-8blUJYA:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=pHzHmUro8NiASowvMSCR:22 a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Wed, Nov 20, 2019 at 06:10:26PM +0100, Paul Cercueil wrote:
> Add bindings documentation for the Frida 3.5" (320x240 pixels) 24-bit
> TFT LCD panel.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/display/panel/frida,frd350h54004.txt    | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/frida,frd350h54004.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/frida,frd350h54004.txt b/Documentation/devicetree/bindings/display/panel/frida,frd350h54004.txt
> new file mode 100644
> index 000000000000..8428f8b05b93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/frida,frd350h54004.txt
> @@ -0,0 +1,12 @@
> +Frida 3.5" (320x240 pixels) 24-bit TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "frida,frd350h54004"
> +- power-supply: as specified in the base binding
> +
> +Optional properties:
> +- backlight: as specified in the base binding
> +- enable-gpios: as specified in the base binding
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.

New bindings in meta-schma (yaml) format only.
We are migrating away from the .txt based variants.

Rob has a mega patch so we will soon have a lot of examples to look at.

	Sam
