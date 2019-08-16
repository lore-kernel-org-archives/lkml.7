Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39502C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132D9206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565978569;
	bh=I+9AYbqHJGWDLUYrQuzL4EoZcCetSaXNK4owyhlQZyI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=egYDRuhrkwsj8QLnpA4pil6cnFnN8rQyJL4PFudluDPuz1ycWlZglqD5QvhOBzgSi
	 dHAwSO1Ex8O3wBnf5y7k7YJ3n+VU+AjAnPqH0UQFCYBeQWAyK9mAQTnDj8kore2ion
	 rpZyUCtReLQXvJFvwVTt/rqYD52wfZxXP1cfVqcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfHPSCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 14:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:32770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfHPSCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 14:02:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D37BD20665;
        Fri, 16 Aug 2019 18:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565978566;
        bh=I+9AYbqHJGWDLUYrQuzL4EoZcCetSaXNK4owyhlQZyI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=al7+pTCRa1ysK9PYtoeNNO/kgnxQq76VFbXGIcGL7rJbTbm+rtwoWg4jMBmmr59E7
         6BTdiXQk7yhZjY554CMS2cLiigd+VfAc1Rc8VeNgv32zG1XNJbovvwACH6gMzNB/VJ
         yBRATionK4lB9NVFtZ3qqhAN8KmPXf1T2TaXWTTI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190814015312.11711-1-peng.fan@nxp.com>
References: <20190814015312.11711-1-peng.fan@nxp.com>
Subject: Re: [PATCH] clk: imx8mn: fix int pll clk gate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, abel.vesa@nxp.com, ping.bai@nxp.com,
        peng.fan@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     mturquette@baylibre.com, peng.fan@nxp.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 11:02:46 -0700
Message-Id: <20190816180246.D37BD20665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting peng.fan@nxp.com (2019-08-13 18:53:12)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> To Frac pll, the gate shift is 13, however to Int PLL the gate shift
> is 11.
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: 96d6392b54db ("clk: imx: Add support for i.MX8MN clock driver")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> ---

This is a fix for a change in -next. Why is stable Cced?

