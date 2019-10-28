Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10584CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7906214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572262502;
	bh=8W/eAI/xIhgjfqFM7WlcqXxv3DWk2HLLJvt0/XMzVyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wRvGDjtfuGTLH9r9MdSlIF+bX4WctP291xp7RIR6fgAhrMAzPfH3NlTMVy8XznjC0
	 AOR1NiwG4AvX9rDWumWZgX0mHYhDm1x2Oa1YKxz8FizqydazKYDmODmgYjMKOCSPDP
	 9qcQJDmMH43H37e17nT9rBOD9HdVV9b94gtmeZzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbfJ1LfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:35:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfJ1LfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:35:01 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F0920873;
        Mon, 28 Oct 2019 11:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572262500;
        bh=8W/eAI/xIhgjfqFM7WlcqXxv3DWk2HLLJvt0/XMzVyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C7FiH8b7uxMyuvyMM3w80cgzy9CUz+P5b5w2BudIXW6l+2sVbTgDypvJaDPm9zTrc
         h6xPZyGIruMZjK0mqZ08fwMqx4+8TECT0y+9OiGMRzcj6bLaEYtQHgf/poYzQGr/SM
         VmAM+HttWo4pe72Z2PCtEX4qoJ6t1cMVGHCznvag=
Date:   Mon, 28 Oct 2019 19:34:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2] ARM: imx: Add serial number support for i.MX6/7 SoCs
Message-ID: <20191028113428.GC16985@dragon>
References: <1572254161-18914-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572254161-18914-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 05:16:01PM +0800, Anson Huang wrote:
> i.MX6/7 SoCs have a 64-bit SoC unique ID stored in OCOTP,
> it can be used as SoC serial number, add this support for
> i.MX6Q/6DL/6SL/6SX/6SLL/6UL/6ULL/6ULZ/7D, see below example
> on i.MX6Q:
> 
> root@imx6qpdlsolox:~# cat /sys/devices/soc0/serial_number
> 240F31D4E1FDFCA7
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
