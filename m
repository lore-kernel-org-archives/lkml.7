Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0775FC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC96A216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565613319;
	bh=sKosxmOcdBwvdk6lTd5N3R2gQyETb4EqVTilz++f7EE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eejgvJr8Vy15fE5iitDV+NINqaGFIgiCQu+Gm2pZNCGiBQ0zJQMvaPfgDC2RodQJm
	 pjeJ7leSU55zA4sLZSgfTe85KO2KpWWYUTPaP9d4LPBzLpF1NsdlWEZ0wFNIpG5wye
	 nUEHeGpfWGbmfZDSG7P4Zg47ONxC2BpRbpsmudFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfHLMfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfHLMfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:35:18 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27FCA214C6;
        Mon, 12 Aug 2019 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565613317;
        bh=sKosxmOcdBwvdk6lTd5N3R2gQyETb4EqVTilz++f7EE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tmlOEGevzXZ7UQ7ku9dSPnQBMzbPqg2oWiSoL4MiE0FxS5nPQ6ML5ze0c7Edh7DPy
         MfYsokZ8V5Cu/5CHVNDX1SWaWBIqh6EpGJxBMz8Uq+gOPTQKEbfJMrHgvzqdX8nwSe
         /4nQMMeLogEm1Vl0+TdgA8rgu7nULGEaWT7KVnmM=
Date:   Mon, 12 Aug 2019 14:35:06 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, abel.vesa@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.felsch@pengutronix.de, Linux-imx@nxp.com
Subject: Re: [PATCH V3] soc: imx-scu: Add SoC UID(unique identifier) support
Message-ID: <20190812123505.GC27041@X250>
References: <20190702074545.48267-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702074545.48267-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 03:45:45PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Add i.MX SCU SoC's UID(unique identifier) support, user
> can read it from sysfs:
> 
> root@imx8qxpmek:~# cat /sys/devices/soc0/soc_uid
> 7B64280B57AC1898
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks.
