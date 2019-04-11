Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51327C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E602083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555008315;
	bh=jI+li3xEGAd8nK/+roDZbVIM3d4Yx63HM+69fYZkqOs=;
	h=In-Reply-To:References:From:Subject:To:Date:List-ID:From;
	b=l0Nn0/Fh/Wsz1erFQOXs9Ws4glNXwfBbxKL6kEUu1hJbi16+HBmUt7Z71hwiAF5fN
	 bh0MhauM05F891wRCBzJAVAsocjDQ/DyR6RzOiqxsGGWtcKkDY96D7C/76CWu/OE5Z
	 4l7Xb9GxDMSNrHlo597EjR+x1NplKtQPjIjJ3Uo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfDKSpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbfDKSpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:45:12 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8DF92083E;
        Thu, 11 Apr 2019 18:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555008311;
        bh=jI+li3xEGAd8nK/+roDZbVIM3d4Yx63HM+69fYZkqOs=;
        h=In-Reply-To:References:From:Subject:To:Date:From;
        b=bvyrUjz8hRQEaue5yp9JADf9C4EKP287A9ipjHD7gDJKKEciKh66kwZLWcD+gDwY/
         Y5Q5/W+1YfMBdVCtjo7+1yN3nmThuC+1irGavlKgqhHxL4hDfPumFWzfvtG4rDfTCy
         xGsyhAweDerjrj/0Gsnw5KcgvJKcWCQTBtWB0mZ4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1552634964-11049-1-git-send-email-dingxiang@cmss.chinamobile.com>
References: <1552634964-11049-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: davinci: cfgchip: use PTR_ERR_OR_ZERO in da8xx_cfgchip_register_div4p5
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com
Message-ID: <155500831086.20095.12100753747795985291@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 11:45:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ding Xiang (2019-03-15 00:29:24)
> use PTR_ERR_OR_ZERO inetead of return code
>=20
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---

Applied to clk-next

