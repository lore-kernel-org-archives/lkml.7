Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C06C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 03:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5748D222BE
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 03:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570334119;
	bh=0jSvV7nxVs9zvgYK7gtXs4KinaxY+FIlbXfuFyO6Gq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Iql6k+ZdzBdwHb0tIOIRPhrdEbbuSvIQzKXo9fQoH4Rux4vxZqzo1sxEN/5Mpy8zv
	 zJKYJCHFkbuoQImCepotVyvP9uTkDlS7K5cb4tfDQL2yeMHlhgY57db5ahVX8uXePs
	 8cnpnCZml7u+q1h1cTg8DbAUqTswWN3gs5J/3mdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfJFDzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 23:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfJFDzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 23:55:18 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99E4C2166E;
        Sun,  6 Oct 2019 03:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570334117;
        bh=0jSvV7nxVs9zvgYK7gtXs4KinaxY+FIlbXfuFyO6Gq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w4Sq3muDAK60snX8++MvYdjyBtvre05wdeWM7kTXBzG1ZOanzkXr3vk19lKxO/4aI
         Lhsz9mD3+aTHwySKvquUtQhfzojHQqwxjBCEvbbCJK6W1pE/YuefsLMNB4J1+UmqhM
         llMwryoRpwMLMMhg7WmNk8WF+s/q8AUdy2U6EQU4=
Date:   Sun, 6 Oct 2019 11:54:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mn: Add "fsl,imx8mq-src" as src's
 fallback compatible
Message-ID: <20191006035449.GQ7150@dragon>
References: <1568126359-2887-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568126359-2887-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 10:39:19AM -0400, Anson Huang wrote:
> i.MX8MN can reuse i.MX8MQ's src driver, add "fsl,imx8mq-src" as
> src's fallback compatible to enable it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
