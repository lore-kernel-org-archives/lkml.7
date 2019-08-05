Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EB7C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8C22182B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfHEJ53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:57:29 -0400
Received: from ox4u.de ([212.118.221.216]:58319 "EHLO s1.ox4u.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbfHEJ5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:57:25 -0400
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Aug 2019 05:57:24 EDT
Received: by s1.ox4u.de (Postfix, from userid 65534)
        id E03C82601A3; Mon,  5 Aug 2019 11:47:31 +0200 (CEST)
Received: from ws-140106.localnet (unknown [212.185.67.146])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by s1.ox4u.de (Postfix) with ESMTPSA id B3B6526014C;
        Mon,  5 Aug 2019 11:47:29 +0200 (CEST)
From:   Alexander Stein <alexander.stein@systec-electronic.com>
To:     Hui Song <hui.song_1@nxp.com>
Cc:     linux-devel@linux.nxdi.nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1] gpio: mpc8xxx: Add new platforms GPIO DT node description
Date:   Mon, 05 Aug 2019 11:47:26 +0200
Message-ID: <2908964.pz7DIX2Qck@ws-140106>
In-Reply-To: <20190805091432.9656-2-hui.song_1@nxp.com>
References: <20190805091432.9656-1-hui.song_1@nxp.com> <20190805091432.9656-2-hui.song_1@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 5, 2019, 11:14:32 AM CEST Hui Song wrote:
> From: Song Hui <hui.song_1@nxp.com>
> 
> Update the NXP GPIO node dt-binding file for QorIQ and
> Layerscape platforms, and add one more example with
> ls1028a GPIO node.
> 
> Signed-off-by: Song Hui <hui.song_1@nxp.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt b/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
> index 69d4616..fbe6d75 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
> @@ -28,7 +28,7 @@ gpio0: gpio@1100 {
>  Example of gpio-controller node for a ls2080a SoC:

   ^^^^^^^                               ^^^^^^^
This is an example for ls2080a...

>  gpio0: gpio@2300000 {
> -	compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
> +	compatible = "fsl,ls1028a-gpio","fsl,ls2080a-gpio", "fsl,qoriq-gpio";

so I doubt there should be a ls1028a compatible here though.

>  	reg = <0x0 0x2300000 0x0 0x10000>;
>  	interrupts = <0 36 0x4>; /* Level high type */
>  	gpio-controller;

Best regards,
Alexander



