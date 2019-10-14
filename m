Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB74C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E18520854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571034128;
	bh=Jjj99LoxCmtMpzWzfLoU7hX03YIEXAcoDRPAZxbv1d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kPOQvKZ4bIAcvlNiLb1hkJ8ZC5KSJPLVhiltcYqjLQFgL9x1EioSsVD0g72DR07DB
	 KHFv8yfQw/tcjz16UoxVJxuUH6Bhl61o0OvIfUJGQ4lLc1bZlJSIPT5WDMF6J63P8m
	 IlU2rbVF1/Nq5B7vcyBjpb9nk7VbAoq/OCxWzZ50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfJNGWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:22:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfJNGWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:22:06 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FAB12089C;
        Mon, 14 Oct 2019 06:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571034126;
        bh=Jjj99LoxCmtMpzWzfLoU7hX03YIEXAcoDRPAZxbv1d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CMCQ0cSRswKmQ6g9H8pNkHrvXFekn/GdKq9hibcG0vVCGTH+FfweKsk9NoRIhColI
         egntYbNiNnBhF7R2XVwIQ5ZmllHOyf2OCx5NRj1EuhgnRthnTQRFJr5kM3u7K2wFnf
         XChMGX5tYtundrxQ/XHpkBwzzCQbNKQ65qPQx7is=
Date:   Mon, 14 Oct 2019 14:21:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wen He <wen.he_1@nxp.com>
Cc:     "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [v2 2/2] arm64: dts: ls1028a: Update the DT node
 definition for dpclk
Message-ID: <20191014062150.GC12262@dragon>
References: <20190920083419.5092-1-wen.he_1@nxp.com>
 <20190920083419.5092-2-wen.he_1@nxp.com>
 <20191007123512.GM7150@dragon>
 <DB7PR04MB5195760127B83B88B68CC602E29A0@DB7PR04MB5195.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR04MB5195760127B83B88B68CC602E29A0@DB7PR04MB5195.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 04:08:57AM +0000, Wen He wrote:
> 
> 
> > -----Original Message-----
> > From: Shawn Guo <shawnguo@kernel.org>
> > Sent: 2019年10月7日 20:35
> > To: Wen He <wen.he_1@nxp.com>
> > Cc: linux-devel@linux.nxdi.nxp.com; Leo Li <leoyang.li@nxp.com>; Rob Herring
> > <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [v2 2/2] arm64: dts: ls1028a: Update the DT node definition
> > for dpclk
> > 
> > 
> > On Fri, Sep 20, 2019 at 04:34:19PM +0800, Wen He wrote:
> > > Update DT node name clock-controller to clock-display,
> > 
> > The node name clock-controller is so good, and I do not understand why you
> > need to change it.
> > 
> 
> The node name clock-controller used for the system clockgen and this clock only used for
> the Display core. 
> To clearly the node, that why I have to use clock-display to instead of the clock-controller

Label is being used to specify things, and node name should just be as
generic as possible.

Shawn
