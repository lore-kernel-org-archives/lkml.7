Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA2EC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBF520862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbfJDJYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:24:15 -0400
Received: from retiisi.org.uk ([95.216.213.190]:51680 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730186AbfJDJYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:24:14 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 01408634C87;
        Fri,  4 Oct 2019 12:23:37 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1iGJoG-0002PC-AP; Fri, 04 Oct 2019 12:23:36 +0300
Date:   Fri, 4 Oct 2019 12:23:36 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com
Subject: Re: [PATCH v4 2/2] media: i2c: Add IMX290 CMOS image sensor driver
Message-ID: <20191004092336.GL896@valkosipuli.retiisi.org.uk>
References: <20191003095503.12614-1-manivannan.sadhasivam@linaro.org>
 <20191003095503.12614-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003095503.12614-3-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

On Thu, Oct 03, 2019 at 03:25:03PM +0530, Manivannan Sadhasivam wrote:
> Add driver for Sony IMX290 CMOS image sensor driver. The driver only
> supports I2C interface for programming and MIPI CSI-2 for sensor output.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Could you remove the unneeded ret variable from imx290_power_on() and
unneeded goto in the same function?

The MAINTAINERS entry belongs to the first patch adding new files.

Then I think this is good.

-- 
Regards,

Sakari Ailus
