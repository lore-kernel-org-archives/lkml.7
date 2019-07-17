Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E2CC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE352182B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563360159;
	bh=Vc4dK7Q1LgrSjNRykc3aqEyJGyahGuK990ZvfYWGOLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1OPU8eLjdXabLDWnhKXBpjbCPZMG/iQ9PvlaoU2v82qy2MEQFKE50HDLQSN3shtuh
	 ZLoUjbmWXPV6CEu34MmHiQ+t+ZnaC/CEg2eHAKY3w0f7orU9fPa+YOorN//AV7JEsE
	 +cRX9aDaOBo2nI9T0RUqTvNo0zgmd8HLwziliaa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfGQKmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQKmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:42:38 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987452173B;
        Wed, 17 Jul 2019 10:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563360157;
        bh=Vc4dK7Q1LgrSjNRykc3aqEyJGyahGuK990ZvfYWGOLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z4qLwUVYKFf3kN6p6YQf6jic8Hvvrno7rna1CHIKYbQDNkfyhvlOYJm1ZavvUMX6e
         j7uHoKmtGlYxgcwiN00A9jR9dgo8IU8pF148s0cTMdR+DIJslPMRqsqG3tgeDXZ67G
         1tcARC+sYw074brfrRpFECtFhkxWm8NdG9hpluFk=
Date:   Wed, 17 Jul 2019 18:42:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bob Langer <Bob.Langer@zii.aero>,
        Liang Pan <Liang.Pan@zii.aero>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ARM: dts: Add ZII support for ZII i.MX7 RMU2 board
Message-ID: <20190717104219.GG3738@dragon>
References: <20190624183044.30240-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624183044.30240-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 11:30:43AM -0700, Andrey Smirnov wrote:
> Add support for ZII's i.MX7 based Remote Modem Unit 2 (RMU2) board.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Bob Langer <Bob.Langer@zii.aero>
> Cc: Liang Pan <Liang.Pan@zii.aero>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org

Applied both, thanks.
