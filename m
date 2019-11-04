Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B00CA9ED0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D96021D71
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572832200;
	bh=FXzyTtFsDRSXdY8hFSjERNvyMFyW6+/Y5PA8Z0Tzd1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x8XVVuY8hkJkvBg9wwUwzUob86EfDYpmGTJEd7LtCK2XCRoHaOvAlqAae5bWlLkxE
	 vDisECiiJcNuMCgDqkDARN1xRmPigbZf6GaMbzTiYpXy/W98y/Qqc61+F28/bGKUWO
	 sMJDF8aSsqazaNTGro9Qu3yi7thZf45J6iqrBpNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfKDBt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:49:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbfKDBt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:49:59 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 661B3217F5;
        Mon,  4 Nov 2019 01:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572832198;
        bh=FXzyTtFsDRSXdY8hFSjERNvyMFyW6+/Y5PA8Z0Tzd1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZtYoPthRzk9DXmnNeI4YmVUZ6n+nyHUJoImfJIDeVekgr2UbH2G2I6/Jw13KCcURt
         78UJK/fKyUh3bpxDclgBggpcU0kjX0eEAYTMqdbvT8+0bpuIOSFd8+JVIoKlZAPpcH
         MwQcrJ1PfVoXyg5Qx8SDn/49L0tA1putAi2KscxA=
Date:   Mon, 4 Nov 2019 09:49:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        marex@denx.de, angus@akkea.ca, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: arm: fsl: add compatible string for
 Kobo Clara HD
Message-ID: <20191104014930.GJ24620@dragon>
References: <20191026195748.14562-1-andreas@kemnade.info>
 <20191026195748.14562-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026195748.14562-2-andreas@kemnade.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 09:57:46PM +0200, Andreas Kemnade wrote:
> This adds a compatible string for the Kobo Clara HD eBook reader.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thanks.
