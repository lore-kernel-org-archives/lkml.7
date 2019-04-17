Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AEDC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8407C20663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfDQSBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:01:04 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:33798 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDQSBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:01:04 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-110-185-nat.elisa-mobile.fi [85.76.110.185])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id C95E72000F;
        Wed, 17 Apr 2019 21:01:01 +0300 (EEST)
Date:   Wed, 17 Apr 2019 21:01:01 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH net-next 0/2] net: stmmac: Enable Flow Control
Message-ID: <20190417180101.GA7350@darkstar.musicnaut.iki.fi>
References: <cover.1555486210.git.joabreu@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555486210.git.joabreu@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 17, 2019 at 09:33:03AM +0200, Jose Abreu wrote:
> I don't know of any specific reason why Flow Control is off by default but
> do let me know if there is any.

It seems dwmac1000 assumes 4K FIFO size when configuring threshold
values. This could be non-optimal for 8K/16K FIFOs, but that can be
fixed later on with incremental patches.

A.
