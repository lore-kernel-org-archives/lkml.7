Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6900C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4E42173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558429856;
	bh=C7Rp8wqYBXqZ6fFn2WYWodrvowsp7TonAqKyhtYkULc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A3Nt1Y1v2cXyDO0nQvuu/MZBsCYDuvrBGmwNxb2LO1/iKbO9CGLeYr7GYqnZEvYpI
	 5vFhuL26uGxdaZApUO0dbcBcLVlx5+ppNNvUENbQSg+1l69rZHRYjplzUSuJfnRspZ
	 tDtnXRO8niI12gEcfSGcHqHgeazHiHPrF0hoCTnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfEUJKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfEUJKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:10:55 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17195216B7;
        Tue, 21 May 2019 09:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558429854;
        bh=C7Rp8wqYBXqZ6fFn2WYWodrvowsp7TonAqKyhtYkULc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PewuD7bWJaE45Jz4ZUpufsZWbKYpS40BRFVcsxx40r10NLzxS//kXp/Pb7F9zd+Z6
         2KLO6/ScDrLRVLPz4SxG3bYO5lu5U6sz2NImkfjpdf74Wj5CFfCvIFt8EnUq635lcv
         JAmx7r1jQHBrZ3kk1BcfJY8rlYEZLjbpNAeBelBI=
Date:   Tue, 21 May 2019 17:09:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2] arm64: dts: imx8qxp: Add gpio alias
Message-ID: <20190521090956.GF15856@dragon>
References: <1558426311-14082-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558426311-14082-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 08:17:02AM +0000, Anson Huang wrote:
> Add i.MX8QXP GPIO alias for kernel GPIO driver usage.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
