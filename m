Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE263C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E0921841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554967401;
	bh=dpUecL9e7B5D45QkLKFrf60uNTCdPbWo4eMNhAv8yYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0J0uiP7KRlaGhJbw+Dx2sQmv/Cg7rBVXyBVYX1LqsxJ/d2gGnr70s3uDcGg9Sa36P
	 zefQCduZorMfDgYnr+GtA0ra45DdeTf8FFNy03KGbxJpW2zDi99S1ZlY5mdJbpBDLF
	 M6mYgWhX51gRmLZiZ07icuuxvOpfhmQpfsFFNz0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfDKHXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfDKHXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:23:20 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB512133D;
        Thu, 11 Apr 2019 07:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554967399;
        bh=dpUecL9e7B5D45QkLKFrf60uNTCdPbWo4eMNhAv8yYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwkIznBmVWZWKqOyGB5srlRugVaeZCL8TbLe6j+Z1iNjqUMBsyDlaOLavj5Yvvkup
         pjVmBn7k9pAaucOHE9KkhqhdghyazA858ZcbpcZanK5/seS4EZ69Dee8UHeHZIS+t3
         8HWxGcndt3Yb2LgKdqHakJJSrYScOvZHp1lorNhY=
Date:   Thu, 11 Apr 2019 15:23:05 +0800
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
Subject: Re: [PATCH] ARM: dts: imx6sll: add cooling-cells for cpu-freq
 cooling device
Message-ID: <20190411072304.GA3050@dragon>
References: <1554086786-3691-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554086786-3691-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 02:51:11AM +0000, Anson Huang wrote:
> Add #cooling-cells for i.MX6SLL cpu-freq cooling device usage.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
