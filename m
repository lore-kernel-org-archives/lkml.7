Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B17AC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 08:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B98217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 08:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570349412;
	bh=Ejn7qCzT2VXUEJ25isLaRS+0gqOkA65KyWt7HUIz7Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QvoUWjRdqg8C/N7KJKljO9IFa4IBlsUb/lcGvcjgyq4bK44NUaC0CVaHiEV2C3APU
	 QM16qLgy3pOeXbCM/AUoVhXCPlz3BeMZZeotlSRt26Nl57cyVVRp3m7F5iCiwdcd4N
	 undE0bNzrn5M0gujiLHT+KLGK0J06Vazqwty9ohk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfJFIKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 04:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfJFIKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 04:10:11 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D8B2084D;
        Sun,  6 Oct 2019 08:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570349410;
        bh=Ejn7qCzT2VXUEJ25isLaRS+0gqOkA65KyWt7HUIz7Yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xXQbydn1WijoAspGMdkpZZqONjjExKaoPDfPs4q10j7UKUyt74fbKHJs1EhRMUiOW
         2hxNPUnNeZ8feCIIZphpzYtR6XankQRp+FqgzZ7brJxCxtKH2BYGyhskZcV1yL6ut6
         pfYgmFt4qkpzMJKhATqOZDRNTd+n4A3fXKCIT7HM=
Date:   Sun, 6 Oct 2019 16:09:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] ARM: dts: imx7d: Correct speed grading fuse settings
Message-ID: <20191006080933.GY7150@dragon>
References: <1568256992-31707-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568256992-31707-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 10:56:31AM +0800, Anson Huang wrote:
> The 800MHz opp speed grading fuse mask should be 0xd instead
> of 0xf according to fuse map definition:
> 
> SPEED_GRADING[1:0]	MHz
> 	00		800
> 	01		500
> 	10		1000
> 	11		1200
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
