Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9A4C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 09:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2591E21773
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 09:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564823054;
	bh=kYBiilUhc6DZJa64D6cCy1TrASaor4leQXEMNsBtUGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GEKZCgiNXRcPgw2ZdoXluwv4m7pqpxvrBfYBQUGvwKhGlTVgXGl2cE4TJekPfs69X
	 DXRPS+diDJZBmTmu0cWk8YPOTACOm89kSIbkp6PCOaXpvTH+4gplJftwVJb7ZfrlQ6
	 f/TfH3YHmtFKxnpg7FfHuPtCJ639AaX05q5t6u8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbfHCJEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 05:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387945AbfHCJEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 05:04:12 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 410C321726;
        Sat,  3 Aug 2019 09:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564823051;
        bh=kYBiilUhc6DZJa64D6cCy1TrASaor4leQXEMNsBtUGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b7CSsof6a1ESo3ZAhvVwzD+XJo063xqo0YaxkxdEpR1pJ4dmwhpw7lXHgevToA8z9
         Snxcd90ujQqPGgL3I1ConyXiiwdIW41Dqa+guIiNkaHDBd1O7zTDfoGC1x1foqarg0
         woSn+g5IRothqP1mWFCfi6fDB/4IaVyZT3nuCNWM=
Date:   Sat, 3 Aug 2019 11:04:05 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] clk: imx8mn: Keep uart clocks on for early console
Message-ID: <20190803090404.GI8870@X250.getinternet.no>
References: <20190724075017.11003-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724075017.11003-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 03:50:17PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Call imx_register_uart_clocks() API to keep uart clocks enabled
> when earlyprintk or earlycon is active.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
