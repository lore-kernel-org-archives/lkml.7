Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69386C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DBE2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfCTKf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:35:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48649 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfCTKf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:35:29 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1h6YZ8-0007c2-KV; Wed, 20 Mar 2019 11:35:22 +0100
Message-ID: <1553078122.7071.6.camel@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: reset: meson-g12a: Add missing USB2 PHY
 resets
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Mar 2019 11:35:22 +0100
In-Reply-To: <20190304104916.3937-1-narmstrong@baylibre.com>
References: <20190304104916.3937-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-04 at 11:49 +0100, Neil Armstrong wrote:
> The G12A Documentation lacked these 2 reset lines, but they are present and
> used for each USB 2 PHYs.
> 
> Add them to the dt-bindings for the upcoming USB support.
> 
> Fixes: dbfc54534dfc ("dt-bindings: reset: meson: add g12a bindings")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  include/dt-bindings/reset/amlogic,meson-g12a-reset.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> index 8063e8314eef..6d487c5eba2c 100644
> --- a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> +++ b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> @@ -51,7 +51,10 @@
>  #define RESET_SD_EMMC_A			44
>  #define RESET_SD_EMMC_B			45
>  #define RESET_SD_EMMC_C			46
> -/*					47-60 */
> +/*					47	*/
> +#define RESET_USB_PHY20			48
> +#define RESET_USB_PHY21			49
> +/*					50-60	*/
>  #define RESET_AUDIO_CODEC		61
>  /*					62-63	*/
>  /*	RESET2					*/

Thank you, applied to reset/fixes with Martin's review tag.
