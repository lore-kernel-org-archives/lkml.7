Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890E8CA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1FE20873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572252620;
	bh=+5M9OtDgLy8Q7yETJhCbFnqnlXWY4NSUDSLFI8obc28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2m9UNw0XXee7oVtvwdUF+OgVLUgMIahrrlvHuBdpjZyWzrOU3NgpR/8AljANoCiqE
	 Nm+AhVevEPHghD2z3xb5pl547tIACyWbNhhAaYLrLBPogVvDw0Ag6Vi5XmmOiSF5zV
	 0Jbyra6ibO9ayjhorLFUhP7TUZfIJErOI7wOfTws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbfJ1IuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730954AbfJ1IuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:50:19 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 339F92086D;
        Mon, 28 Oct 2019 08:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572252618;
        bh=+5M9OtDgLy8Q7yETJhCbFnqnlXWY4NSUDSLFI8obc28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRYRk77Z25V+FWj5u5mJlznZktX8VvU+f4yWpGSPfoXWaYPLkTS/1KEmWE7PN186N
         HBhfUXqjEwAworijpgQR42yIFjhsOVuLzOIpAYqzIFKzmtuNj9CdujjjAtMzIr/e/m
         O17Za8zefbIgJgj1QTDtrQR/g/8Hnurd6d7Z5PQk=
Date:   Mon, 28 Oct 2019 16:49:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx6ul: Disable gpt2 by default
Message-ID: <20191028084957.GY16985@dragon>
References: <1571885965-28928-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571885965-28928-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 10:59:25AM +0800, Anson Huang wrote:
> i.MX GPT driver ONLY supports 1 instance, i.MX6UL already has
> GPT1 enabled by default, so GPT2 should be disabled.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
