Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1EEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F34218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551378516;
	bh=EDlpU+X+9JIQiHcd6wbYcvmKfkUiQnRd+oNU2kUUGY8=;
	h=To:References:Cc:Subject:From:In-Reply-To:Date:List-ID:From;
	b=ngge26oQM27J6ax+IO9uCD/SJ7M7GHznPBu4nNHRgYRwOc8tifDlPWMvL2kyD9vzD
	 7g5ed2pefs+KgGGJ52eOIqaDEDCIg2p19/+to5KcW6XBnLUaKgW0e7JvPZDE50++Vt
	 lOOzzKWo0oLkULNOB4+iU7YGPtFS7z1WjBIiBjro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733069AbfB1S2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:28:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfB1S2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:28:35 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DCEF218AE;
        Thu, 28 Feb 2019 18:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551378514;
        bh=EDlpU+X+9JIQiHcd6wbYcvmKfkUiQnRd+oNU2kUUGY8=;
        h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
        b=QLh6bVItzkZatE3zhsIdzVZ3TED7T1IcpQZclFHdMo8rnLJ5EOADbx2NARxA10W0A
         OLFeF7Gzi90fVPweI2QV2F5+0N5B8sr1nP+/fZ78V72fnUxnAyRV1YMjj8OXxWooM/
         Tk8SVwxySVlR2s187v6XSi+H0xzgHqlkCVTwVpYI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
References: <1551230622-30660-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <155137851395.260864.14415827055284077946@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Cc:     dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH RESEND V2 1/2] clk: imx8mq: add GPIO clocks to clock tree
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1551230622-30660-1-git-send-email-Anson.Huang@nxp.com>
Date:   Thu, 28 Feb 2019 10:28:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-02-26 17:28:26)
> i.MX8MQ has clock gate for each GPIO bank, add them
> into clock tree for GPIO driver to manage.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

