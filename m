Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FB1C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EFF20679
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560842178;
	bh=sN1/dE3GrAH4LiGZu8UJOE6L3qSpdz8c5huI877lyBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mNnbpazu2grzybKqVFqUbRudqUoLoVncXdIUeHPBVVwaK7guoCzJfyo+ntCZxCwGJ
	 eyAl2rVP0KyhWkhrHgJNmYPb7vpPe8rMHrR6PB31vFntNXay5jP831Ja0kFgwMamFr
	 lZjLsuuKrGl9B6DZP4WL75s0HS2w+CwHPUbfRtm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfFRHQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfFRHQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:16:16 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E6C2080A;
        Tue, 18 Jun 2019 07:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560842175;
        bh=sN1/dE3GrAH4LiGZu8UJOE6L3qSpdz8c5huI877lyBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+MyZSydPHGMWLLx71r98+SXOxgvyjMuaMyPp5BRhQXygnQLs5ZjxGENn3sEoDCw+
         NVTPaGvPVCvODrrw4JjMwCR4XV/Q0A77ESKa8g5SVaqLNBvn+iPQFfPZLd7WqkXgmU
         vSDmdtr9f7tmNhOi7x4jlY8eyYD7qfTQM39O7ANc=
Date:   Tue, 18 Jun 2019 15:15:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/6] ARM: dts: imx6qdl: Enable SNVS power key according
 to board design
Message-ID: <20190618071522.GG29881@dragon>
References: <20190613033527.40555-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613033527.40555-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 11:35:22AM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> The SNVS power key depends on board design, by default it should
> be disabled in SoC DT and ONLY be enabled on board DT if it is
> wired up.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
