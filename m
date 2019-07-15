Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2A3C7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5E1214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563176223;
	bh=vIXlO1cU3xmZ6lHBpz6w2DZdbKSWgahtstImGSW2YVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aWew4U6KCysCCZFQw7Dmc6omJ7FyOwFmfdE/mgfV+DL/nOyt2lKuWIR08tfOxm9H1
	 drFC8w9dZYB9wsLhdb2S//iXohFfTR847TOvFFxcBwj+zp9Do1IGhAbaWFywTJDp72
	 pUS32BadDFsJ7bvkEMQizx+dgTjkMvI/pPI+uFZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfGOHhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 03:37:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfGOHhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 03:37:01 -0400
Received: from localhost (static-196-86-100-159.thenetworkfactory.nl [159.100.86.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F9AC20C01;
        Mon, 15 Jul 2019 07:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563176220;
        bh=vIXlO1cU3xmZ6lHBpz6w2DZdbKSWgahtstImGSW2YVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xWGFzvI5/WL86BlWwzr24KNfOOAjKN0xoPFz1Dofy/Gc8OJdpcVp1mwhvurn/c0AU
         HBJOdA3DM+Fm1cyvFVDsfybI+M91tpfL569R9Q5qOZ+Deqko1oYI4wzMdTUq1OIjyU
         yFDXHd68W8fuKu0YXoxdcc+gQ56feKY5P8Og3jWY=
Date:   Mon, 15 Jul 2019 09:36:57 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH nvmem 1/1] nvmem: imx: add i.MX8QM platform support
Message-ID: <20190715073657.GA2275@kroah.com>
References: <20190704142032.10745-1-fugang.duan@nxp.com>
 <VI1PR0402MB36009610A9F1CCB9D9006349FFCF0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB36009610A9F1CCB9D9006349FFCF0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 05:34:47AM +0000, Andy Duan wrote:
> Ping...

It's the middle of the merge window, we can't do anything with any
patches until after that.  Please be patient.

greg k-h
