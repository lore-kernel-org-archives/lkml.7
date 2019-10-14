Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A54ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FD921835
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571059052;
	bh=wZFd2MDNuLSRO61MvQmIIhnzwvRFGkA4X4MW5UdN0Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FOuN7QdIewZFlzu6m8nYToEr6FfDoiu8pzJsUheBCzZ8jjf0DCQpysPLVoIF+3jJw
	 +ARPIsccfXvaiQu1v92xm+HCqgyrEygDRe75ugPyf2UueuDvtfUkaKbpTUIaj1cpjX
	 wEj2cNKmwNorCwrB7j5fPI1wJ0CR+Y4q5zV64ArM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfJNNRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729858AbfJNNRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:17:31 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D849E2089C;
        Mon, 14 Oct 2019 13:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571059050;
        bh=wZFd2MDNuLSRO61MvQmIIhnzwvRFGkA4X4MW5UdN0Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftXr9mSljbN7pe2DI95fWgfux9IioFn7rCw2JUvOBdNO6O7z2spqatskV3l0SPyDU
         P3Fz70jEFDmxTPOJkMO5C79bWq0HJAh3mUV0QNqVeyl73eCDlsckSYKlzQtsgle8oc
         ErB3UXWSsibDoLQXS5OGFyy83XbCgCHtKs9pZmTo=
Date:   Mon, 14 Oct 2019 21:16:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, jun.li@nxp.com,
        daniel.baluta@nxp.com, ping.bai@nxp.com, leonard.crestez@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/3] arm64: dts: imx8mm-evk: Adjust i2c nodes
 following alphabetical sort
Message-ID: <20191014131654.GW12262@dragon>
References: <1570497955-19481-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570497955-19481-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 09:25:53AM +0800, Anson Huang wrote:
> The iomuxc node is being put at end of file because of its huge
> pinctrl data. I2C devices should be placed in alphabetical sort.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
