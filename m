Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417D3C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17ED020818
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389268AbfCAQ4W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:56:22 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:34108 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388913AbfCAQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:56:22 -0500
X-Greylist: delayed 657 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Mar 2019 11:56:20 EST
Received: from 178-18-171-174.customer.bnet.at ([178.18.171.174]:57555 helo=[192.168.2.179])
        by mail.theobroma-systems.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <philipp.tomsich@theobroma-systems.com>)
        id 1gzlHZ-000624-Df; Fri, 01 Mar 2019 17:45:09 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 2/3] dt-bindings: mmc: Add a new property
 disable-cqe-dcmd.
From:   Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
In-Reply-To: <20190301164349.60589-2-christoph.muellner@theobroma-systems.com>
Date:   Fri, 1 Mar 2019 17:45:06 +0100
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        shawn.lin@rock-chips.com, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, Michal Simek <michal.simek@xilinx.com>,
        Douglas Anderson <dianders@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Lin Huang <hl@rock-chips.com>, Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <676F71CD-2DC6-4775-BB96-FA0253DEBC5A@theobroma-systems.com>
References: <20190301164349.60589-1-christoph.muellner@theobroma-systems.com>
 <20190301164349.60589-2-christoph.muellner@theobroma-systems.com>
To:     Christoph Muellner <christoph.muellner@theobroma-systems.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 01.03.2019, at 17:43, Christoph Muellner <christoph.muellner@theobroma-systems.com> wrote:
> 
> This patch documents the new proprty disable-cqe-dcmd

typo: proprty -> property

> for the Arasan eMMC 5.1 driver.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> ---
> Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 1edbb049cccb..ec699bf98b7c 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -44,6 +44,10 @@ Optional Properties:
>     properly. Test mode can be used to force the controller to function.
>   - xlnx,int-clock-stable-broken: when present, the controller always reports
>     that the internal clock is stable even when it is not.
> +  - disable-cqe-dcmd: The eMMC 5.1 standard specifies direct commands (DCMDs)
> +    as part of the command queue engine (CQE). On controllers with a CQHCI,
> +    such as the Arasan eMMC 5.1 host controller, the driver has to enable DCMDs.
> +    This is done unless disable-cqe-dcmd is specified.
> 
> Example:
> 	sdhci@e0100000 {
> -- 
> 2.11.0
> 

