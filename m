Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9DBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2E2218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553168359;
	bh=NUI1wSmF54c8SUjkv01apIHQBn4dDhBBI8pMQoE7FMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eqKYa6uFkOM1KihvzjqK5paIYeuR4sZ/vo6vifhd6mroBY5YG0plny707vKPfq09P
	 +s7tbAKJGWpJ5541nN7n2OxDS4eyZxYyzhyZUIPcPLbGvs8TkScTssGAWWeVi/vOPb
	 cZ2+LIF8XTdHdYgCdEzHkn1wsaZ+UYp+4yg2l8FY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfCULjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfCULjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:39:17 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C0A4218D8;
        Thu, 21 Mar 2019 11:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553168356;
        bh=NUI1wSmF54c8SUjkv01apIHQBn4dDhBBI8pMQoE7FMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hF2ShgzekIXbcDKgFGs6f0yW5hyXVV9J6zXcucB9LnzH1pYYccwKHqD75zD2wTUjp
         LVGfcdR+nfz9KXptEvRjrFm8pq4M+sNwHIt5YTlTQBTMn6F+WhdyuXgHmBDVDzOBuU
         hd3eQh7f/VBv46jgZG24ZBEsfwgP9EIS+FByZgKM=
Date:   Thu, 21 Mar 2019 19:38:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8qxp: add lsio_mu2 node
Message-ID: <20190321113848.GK12513@dragon>
References: <20190313093650.18693-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313093650.18693-1-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 09:24:42AM +0000, Peng Fan wrote:
> Add lsio_mu2 node which could be used communicate with SCU.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
