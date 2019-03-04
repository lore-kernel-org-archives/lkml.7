Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AC6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687B120863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551663679;
	bh=wYp5Hhjw00bpQfQ2eQSp65pbD+eMoEQVYZR+OzGhVOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1yEzEPaB9HISxAK09rna6lBXx8okOdSHGoBXVtE7UmSh8c0s8rTAN10LhrXjseSrM
	 QdPIobkSxbzmRmrdYSYL2TnEHZNolwi+i5ZWWemEwZZfqs1sRFY35ZXHrrZY1mn1gQ
	 sRERGnysXKhNkH032Ai/q2jCESd8mfRDusKSMPsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfCDBlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 20:41:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfCDBlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 20:41:10 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CB8F20830;
        Mon,  4 Mar 2019 01:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551663669;
        bh=wYp5Hhjw00bpQfQ2eQSp65pbD+eMoEQVYZR+OzGhVOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IPJ1qDg07V5dp/Upmk/rKhS3K4x/TOtp7uZkxLGzwtY0T+0mXwucWzAbugsdYJpOR
         y/YRgRSC5GRQnZeh/jmAwqM4JciiBJeukz4mZHJytevvy/gg2BQSQPxSLivs66oIrU
         QNrF5N7oTjy60nl74PyBTo1aEWHjn1gITkh/g5gM=
Date:   Mon, 4 Mar 2019 09:40:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH RESEND V4 1/2] dt-bindings: firmware: imx-scu: remove
 unused resources from scu resource table
Message-ID: <20190304014005.GU26041@dragon>
References: <1551228502-1535-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551228502-1535-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 12:53:04AM +0000, Anson Huang wrote:
> Removes below resources which were defined during
> pre-silicon phase and the real silicons do NOT have
> them, they have never been used, latest system
> controller firmware also removed them:
> 
> 	IMX_SC_R_DC_0_CAPTURE0
> 	IMX_SC_R_DC_0_CAPTURE1
> 	IMX_SC_R_DC_0_INTEGRAL0
> 	IMX_SC_R_DC_0_INTEGRAL1
> 	IMX_SC_R_DC_0_FRAC1
> 	IMX_SC_R_DC_1_CAPTURE0
> 	IMX_SC_R_DC_1_CAPTURE1
> 	IMX_SC_R_DC_1_INTEGRAL0
> 	IMX_SC_R_DC_1_INTEGRAL1
> 	IMX_SC_R_DC_1_FRAC1
> 	IMX_SC_R_GPU_3_PID0
> 	IMX_SC_R_M4_0_SIM
> 	IMX_SC_R_M4_0_WDOG
> 	IMX_SC_R_M4_1_SIM
> 	IMX_SC_R_M4_1_WDOG
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Applied both, thanks.
