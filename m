Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0385BC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0F3216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558429835;
	bh=5eimA3Q9OUTmM31pznO3gTNnUoFriuH+fFfnLbnqfV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pM6iIpMjPYA8Q0r9bbkXLm/HX+ADuRRabQtNowAuIFfEL3IBF0RVxvjgDzgO8zAVl
	 mNAbCxugMt9qkRywSvvsBDRaCVBVPUBjV5KRPz0wpDkRqrNOPLdZDWuTDG3dSp7GKD
	 XAB9Zrz1fciNkqSTkk1pbJhM9JLRsgstqVYPR64I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfEUJKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfEUJKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:10:30 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE554216B7;
        Tue, 21 May 2019 09:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558429829;
        bh=5eimA3Q9OUTmM31pznO3gTNnUoFriuH+fFfnLbnqfV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z2unVTByqNDXvX4+U8BwDCAriO8HtbjBLTjRjRNjABJU8WXJd1Zs+ULKUWj7i0vLp
         qZGfeQiD8o7ip/oYtM+mqgQ2kOlXYQOzNdLb3NeWDl/jJ+NkGMzR4HKk+ZOPcMJCQr
         J7QYEIhA8+T7h5iCAt82CoaUTo/rN+8Ogog0bCUo=
Date:   Tue, 21 May 2019 17:09:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2] arm64: dts: imx8mq: Add gpio alias
Message-ID: <20190521090933.GE15856@dragon>
References: <1558426216-14026-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558426216-14026-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 08:15:26AM +0000, Anson Huang wrote:
> Add i.MX8MQ GPIO alias for kernel GPIO driver usage.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
