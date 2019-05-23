Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25347C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E9B206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558596766;
	bh=7y1NyoV6VAVBTbSwJN9K7Zn3fWn/egJKRZ5wKdxwVnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w8qAI1phVNqLhNU82mCgG0Buh9dLLDT+cXxPEwcdUiTHrRcqLOkfF/kOd9oSwA3Mv
	 ZmjdcgblhwXgxGUTx6eAwNgdbnlQ6vNoDPpcZForHc5hwlCEJkeauYwA0yZ8lBLCN2
	 WlKY2HUUOYemm08v8W1ljdcmbL4Nd+U+T5jCkwP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfEWHco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfEWHcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:32:43 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DC7F206BA;
        Thu, 23 May 2019 07:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558596762;
        bh=7y1NyoV6VAVBTbSwJN9K7Zn3fWn/egJKRZ5wKdxwVnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jg4Nl8B52eYCfl1L8c19y4siJt4HA8XORwMET0wbUpfodzWS3d5Rr2nB9cQouXX+N
         x7L4DDAY3pHuZrtzPUClDa4dVbhyxOa64COa7V1+RF2urPJI26D1FztHrreNje5yZB
         h7p1W/WbrECxlAVlDAcpNpVRbO3cQgrOpckhk8kE=
Date:   Thu, 23 May 2019 15:31:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 3/3] arm64: dts: imx8mm: add clock for SNVS RTC node
Message-ID: <20190523073142.GF9261@dragon>
References: <1557883490-22360-1-git-send-email-Anson.Huang@nxp.com>
 <1557883490-22360-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557883490-22360-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 01:30:02AM +0000, Anson Huang wrote:
> i.MX8MM has clock gate for SNVS module, add clock info to SNVS
> RTC node for clock management.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
