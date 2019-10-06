Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A5CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 07:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A522084B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 07:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570347917;
	bh=Tng415NhQvNaM4Ym/Dta7q28F+Uvbgxq6uSaRNJOmr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jjj50pqwJTbSHFIbvOFoMMAQmyMOHfluPfXcKniKyyGa9DU646QhnHW/jfe/qyMYl
	 8bJkeRMlcAiSc81F0XMchVxTkNxUbo5XszAx8l6DcEgGaAv+wdd+88irvEoZkW5kpN
	 YenumTEyT5M8jeZ9Gjbv1d4IHcpiZ38iqzBQH9r0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfJFHpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 03:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfJFHpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 03:45:16 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 946302077B;
        Sun,  6 Oct 2019 07:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570347916;
        bh=Tng415NhQvNaM4Ym/Dta7q28F+Uvbgxq6uSaRNJOmr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wCSI8hr7kYJV8bIkuUUvMC6P/0VKbMwo05IXNOhPKCtvvn7kdoDaxvsEuMafn+s8m
         wrq3FcwtD24Uz7jWWxlCbuQwByTrG9/g7oUI612QfkUQC2tJHYVPIKAxHciwHe/RZK
         pNziiAj1Mu1WO3BL/M3Jovvy1251vfw4CuwGF5pA=
Date:   Sun, 6 Oct 2019 15:44:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        daniel.lezcano@linaro.org, ping.bai@nxp.com, daniel.baluta@nxp.com,
        jun.li@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm: Remove incorrect fallback
 compatible for ocotp
Message-ID: <20191006074447.GU7150@dragon>
References: <1568211887-19318-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568211887-19318-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 10:24:46AM -0400, Anson Huang wrote:
> Compared to i.MX7D, i.MX8MM has different ocotp layout, so it should
> NOT use "fsl,imx7d-ocotp" as ocotp's fallback compatible, remove it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
