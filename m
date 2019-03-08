Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95572C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71504206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfCHTsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:48:36 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39236 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfCHTsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:48:35 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 58D7714B48EAF;
        Fri,  8 Mar 2019 11:48:34 -0800 (PST)
Date:   Fri, 08 Mar 2019 11:48:33 -0800 (PST)
Message-Id: <20190308.114833.2009759493574418516.davem@davemloft.net>
To:     christophe.roullier@st.com
Cc:     robh@kernel.org, joabreu@synopsys.com, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        peppe.cavallaro@st.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        andrew@lunn.ch
Subject: Re: [PATCH V3 0/6] stmmac: add some fixes for stm32
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1551774568-11732-1-git-send-email-christophe.roullier@st.com>
References: <1551774568-11732-1-git-send-email-christophe.roullier@st.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Mar 2019 11:48:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Roullier <christophe.roullier@st.com>
Date: Tue, 5 Mar 2019 09:29:22 +0100

> For common stmmac:
> 	- Add support to set CSR Clock range selection in DT
> For stm32mpu:
> 	- Glue codes to support magic packet
> 	- Glue codes to support all PHY config :
> 		PHY_MODE (MII,GMII, RMII, RGMII) and in normal,
> 		PHY wo crystal (25Mhz),
> 		PHY wo crystal (50Mhz), No 125Mhz from PHY config
> For stm32mcu:
> 	- Add Ethernet support for stm32h7
> 
> Changes in V3:
> 	- Reverse for syscfg management because it is manage by these patches
> 	  https://lkml.org/lkml/2018/12/12/133
> 	  https://lkml.org/lkml/2018/12/12/134
> 	  https://lkml.org/lkml/2018/12/12/131
> 	  https://lkml.org/lkml/2018/12/12/132

Series applied, thanks.
