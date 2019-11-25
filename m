Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503DDC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B752075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfKYS5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:57:00 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52918 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfKYS47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:56:59 -0500
Received: from localhost (c-73-35-209-67.hsd1.wa.comcast.net [73.35.209.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9AD6615009FB5;
        Mon, 25 Nov 2019 10:56:58 -0800 (PST)
Date:   Mon, 25 Nov 2019 10:56:58 -0800 (PST)
Message-Id: <20191125.105658.1887728338689510269.davem@davemloft.net>
To:     o.rempel@pengutronix.de
Cc:     mkl@pengutronix.de, olteanv@gmail.com, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com,
        kernel@pengutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl
Subject: Re: [PATCH v2] net: dsa: sja1105: fix sja1105_parse_rgmii_delays()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191125114351.26694-1-o.rempel@pengutronix.de>
References: <20191125114351.26694-1-o.rempel@pengutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 25 Nov 2019 10:56:59 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Mon, 25 Nov 2019 12:43:51 +0100

> This function was using configuration of port 0 in devicetree for all ports.
> In case CPU port was not 0, the delay settings was ignored. This resulted not
> working communication between CPU and the switch.
> 
> Fixes: f5b8631c293b ("net: dsa: sja1105: Error out if RGMII delays are requested in DT")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Applied and queued up for -stable, thanks.
