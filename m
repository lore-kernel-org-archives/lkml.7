Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C879AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9817120830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553590911;
	bh=1zB3ghv/pgE/iSf4MBKq33UDqJRi6hW5YzkfBqaKUpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kPSPXNY+hefza+AgLi6mpcm26zL6ek4GXpDIAJmk+uxDeEzaLfdGey6OLNwYNlUC5
	 jKOdARAYnZsIVvqXz1XfaBYW9MfBWcneG7zEk78zB1yWGRUskocU8BbNQrIENrSgpc
	 Z4iHnuxvB9t5AJJJg0Dk+3iPCN3vufJpZvxp43AA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbfCZJBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfCZJBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:01:50 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ACD320857;
        Tue, 26 Mar 2019 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553590909;
        bh=1zB3ghv/pgE/iSf4MBKq33UDqJRi6hW5YzkfBqaKUpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wMyPSLZdriVNQEg4/kvUJbuPHsjkwhPxKvzH8PWTXhiPw6rCkv1yfHiBoX2xVaow9
         1EBaa8MBEhaq5dh/hNWSY7Fml7bWI3etzSAWH56HE81jPEVxq6gkZnhjuhuLPPS6ll
         D6WJSAUeBpE24oIoBxViNMEWky3bkSWwcVmNKvtQ=
Date:   Tue, 26 Mar 2019 17:01:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx7ulp: add ocotp support
Message-ID: <20190326090112.GK12513@dragon>
References: <1553236008-28407-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553236008-28407-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 06:31:56AM +0000, Anson Huang wrote:
> Add i.MX7ULP OCOTP support, its clock source is from
> M4 BUS clock which is NOT available in Linux clock tree,
> but M4 BUS clock is always ON when A7 (Linux) is alive,
> so just use dummy clock here.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
