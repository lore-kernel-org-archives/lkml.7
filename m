Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9CBC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5232080C
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfHZIgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 04:36:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46789 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730287AbfHZIgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:36:17 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i2ATw-0001kw-WB; Mon, 26 Aug 2019 10:36:09 +0200
Message-ID: <1566808568.3842.2.camel@pengutronix.de>
Subject: Re: [RESEND PATCH v2 1/2] dt-bindings: reset: aoss: Add AOSS reset
 binding for SC7180 SoCs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sibi Sankar <sibis@codeaurora.org>, robh+dt@kernel.org,
        bjorn.andersson@linaro.org
Cc:     agross@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 26 Aug 2019 10:36:08 +0200
In-Reply-To: <20190824152411.21757-2-sibis@codeaurora.org>
References: <20190824152411.21757-1-sibis@codeaurora.org>
         <20190824152411.21757-2-sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
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

On Sat, 2019-08-24 at 20:54 +0530, Sibi Sankar wrote:
> Add SC7180 AOSS reset to the list of possible bindings.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
> index 510c748656ec5..3eb6a22ced4bc 100644
> --- a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
> @@ -8,8 +8,8 @@ Required properties:
>  - compatible:
>  	Usage: required
>  	Value type: <string>
> -	Definition: must be:
> -		    "qcom,sdm845-aoss-cc"
> +	Definition: must be one of:
> +		"qcom,sc7180-aoss-cc", "qcom,sdm845-aoss-cc"

Should this emphasize that the common sdm845 compatible always has to be
included?

+	Definition: must be:
+		"qcom,sdm845-aoss-cc" for SDM845 or
+		"qcom,sc7180-aoss-cc", "qcom,sdm845-aoss-cc" for SC7180

or like the qcom,kpss-gcc bindings:

+	Definition: should be one of the following. The generic
compatible
+		"qcom,sdm845-aoss-cc" should also be
included.
+		"qcom,sc7180-aoss-cc", "qcom,sdm845-aoss-cc"
+	
	"qcom,sdm845-aoss-cc"

regards
Philipp
