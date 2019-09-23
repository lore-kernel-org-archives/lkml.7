Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE84C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72462190F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfIWJI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:08:56 -0400
Received: from retiisi.org.uk ([95.216.213.190]:50864 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731943AbfIWJIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:08:54 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 03979634C87;
        Mon, 23 Sep 2019 12:07:52 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1iCKK0-0002AD-TH; Mon, 23 Sep 2019 12:07:52 +0300
Date:   Mon, 23 Sep 2019 12:07:52 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Add entry for IMX290 CMOS image
 sensor driver
Message-ID: <20190923090752.GK5525@valkosipuli.retiisi.org.uk>
References: <20190830091943.22646-1-manivannan.sadhasivam@linaro.org>
 <20190830091943.22646-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830091943.22646-4-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 02:49:43PM +0530, Manivannan Sadhasivam wrote:
> Add MAINTAINERS entry for Sony IMX290 CMOS image sensor driver.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f7c84004187d..0ee261fca602 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14962,6 +14962,14 @@ S:	Maintained
>  F:	drivers/media/i2c/imx274.c
>  F:	Documentation/devicetree/bindings/media/i2c/imx274.txt
>  
> +SONY IMX290 SENSOR DRIVER
> +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +L:	linux-media@vger.kernel.org
> +T:	git git://linuxtv.org/media_tree.git
> +S:	Maintained
> +F:	drivers/media/i2c/imx290.c
> +F:	Documentation/devicetree/bindings/media/i2c/imx290.txt
> +
>  SONY IMX319 SENSOR DRIVER
>  M:	Bingbu Cao <bingbu.cao@intel.com>
>  L:	linux-media@vger.kernel.org

Please squash this change to the first patch.

-- 
Sakari Ailus
