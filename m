Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B69EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4223121855
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565613045;
	bh=Ijmr7L4rj9fAdpDTeN+I568sFcwLmUT8CgsOo/en4AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uq+FIYn5XaibkcqMfamEU3YziR+s2TdWfazwxR0fa00Qv44qNVn9Du7HHaZVznDQd
	 6+T8XnAcJL1F0ZWMLtyL6Ix91FKNYB/tXQmWOoEzgqIztypbBa1k6wEJTdqxTxvC6z
	 S/gyhfc0PHJF7zGnjaG3SMj1iW1WkEYM0dRAWpmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfHLMao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbfHLMao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:30:44 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E61D021744;
        Mon, 12 Aug 2019 12:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565613043;
        bh=Ijmr7L4rj9fAdpDTeN+I568sFcwLmUT8CgsOo/en4AA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4GKmEuU3TYlyUYRKAnckZZb1Qg5JvWhhhH8O5Io14pQ48FHhe12HFwxtUuZ3BNdu
         ez6RpxAdFpRTHYvheWx7FPUhY1lC76AZL6SSJARrmIXW+34fMtPid+LMjcRkNZd4Bh
         HF/vN8apPq1sJgZbMgDe36lbuDhZq6p/TcEpc8EI=
Date:   Mon, 12 Aug 2019 14:30:28 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        andrew.smirnov@gmail.com, manivannan.sadhasivam@linaro.org,
        j.neuschaefer@gmx.net, u.kleine-koenig@pengutronix.de,
        leoyang.li@nxp.com, aisheng.dong@nxp.com, l.stach@pengutronix.de,
        vabhav.sharma@nxp.com, bhaskar.upadhaya@nxp.com, ping.bai@nxp.com,
        pramod.kumar_1@nxp.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V4 4/4] dt-bindings: arm: imx: Add the soc binding for
 i.MX8MQ
Message-ID: <20190812123026.GA27041@X250>
References: <20190619022145.42398-1-Anson.Huang@nxp.com>
 <20190619022145.42398-4-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619022145.42398-4-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 10:21:45AM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> This patch adds the soc & board binding for i.MX8MQ.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> No changes.
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index b35abb1..f944df8 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -183,6 +183,12 @@ properties:
>                - fsl,imx8mn-ddr4-evk            # i.MX8MN DDR4 EVK Board
>            - const: fsl,imx8mn
>  
> +      - description: i.MX8MQ based Boards
> +        items:
> +          - enum:
> +              - fsl,imx8mq-evk            # i.MX8MQ EVK Board
> +          - const: fsl,imx8mq
> +

We already have this with e126417ff1b1 (dt-bindings: arm: fsl: Add the
imx8mq boards).

Shawn

>        - description: i.MX8QXP based Boards
>          items:
>            - enum:
> -- 
> 2.7.4
> 
