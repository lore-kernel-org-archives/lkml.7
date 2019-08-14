Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C33C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECB7206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803067;
	bh=1iUeAyvhAZAqHNFVX4JLfxcG+By3xmjR1XveR5FLq1w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=18oklZDz3sQPLUVtdgdlf+jeeIQAQGFVf5m2YgFlVEDRRIDjfW4dRESxVg3Vm1SEE
	 wneAiItHfH+/MKIN6F1A6e/Zss0isCWCXXN2p2gYTk7jaZMeF1kw/e31Z3hEG0xAly
	 eFVXFQNQTCmvxIPkcqSxlGUmxk1ld4x+29NuLWgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbfHNRRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbfHNRRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:17:44 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C38C4206C1;
        Wed, 14 Aug 2019 17:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565803063;
        bh=1iUeAyvhAZAqHNFVX4JLfxcG+By3xmjR1XveR5FLq1w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ekQmPDFphtUUE0YeP9NFDnAt/EqufEu71F9iP56vG03SMa68jyMOXt94MFd5T9qJl
         vR9+kj7LyNYQIsDm/xajHwsQG4b01OIqdhLtkDeY5t5xYAbNLxB7D4l9lcnPJriulA
         K7FAibP8dhVbiwcXhjFEbpuWc03M/Ti94iQ2H5uA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190814125012.8700-23-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org> <20190814125012.8700-23-vkoul@kernel.org>
Subject: Re: [PATCH 22/22] arm64: dts: qcom: sm8150: Add APSS shared mailbox
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 10:17:42 -0700
Message-Id: <20190814171743.C38C4206C1@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-08-14 05:50:12)
> @@ -338,6 +339,16 @@
>                         #interrupt-cells =3D <2>;
>                 };
> =20
> +               aoss_qmp: qmp@c300000 {

Node name of 'clock-controller', or 'power-controller'?

> +                       compatible =3D "qcom,sm8150-aoss-qmp";
> +                       reg =3D <0x0c300000 0x100000>;
> +                       interrupts =3D <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
> +                       mboxes =3D <&apss_shared 0>;
