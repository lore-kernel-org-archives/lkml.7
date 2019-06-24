Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547F6C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BDF205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561342645;
	bh=miD3wAHyi4O1ctbdmZlddUy7kefFm9ICPlAWm0WphYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D62yUqNeIW6jxA8/+Iy0C88tWegCou7N2/+PwhWDlWHM4JGnz3SaAjUfG57hsHwXV
	 mj+r/OLcZBNvpZu18kTRaHZTB9FJ5EtgsIr9iclJSHP1+T40IApW1aJszDnmhkzBe2
	 VI6nJno2/s2bQA9uSZO+GwM+53gQ40TsE/Ahlkcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfFXCRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfFXCRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:17:23 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C52D922CDA;
        Mon, 24 Jun 2019 00:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561337859;
        bh=miD3wAHyi4O1ctbdmZlddUy7kefFm9ICPlAWm0WphYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x1ZliunoMMDtr76MUYyZbSnxuFYCPAbXH0yiUCbYH7o+g7nSzeXUYAtyKkxg7YmtJ
         D7DnumVulaD1UZTWiFeT5qIEI2joPWT5fX03nHedfCUjkmewLmwu3bUb/ZbCyTACcj
         PYrrhl1gPnDluoYf5Sa/qLiuQBHt3H7YbpmeBTWw=
Date:   Mon, 24 Jun 2019 08:57:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, anson.huang@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8qxp: Add lsio_mu13 node
Message-ID: <20190624005724.GG3800@dragon>
References: <20190618210516.28866-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618210516.28866-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 12:05:16AM +0300, Daniel Baluta wrote:
> lsio_mu13 node is used to communicate with DSP.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks.
