Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40EBC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B0E206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564126096;
	bh=i/TsQG/aRjGtN08pB108hr1+zVTBvheG4HDu8u51ElY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kbUyTlTKxjhH8Bem3ShN33iQQmDuUVLpLGO373TDUGs7IQ3ijcqjbs0UhE68uvpiN
	 xOWld0Gf3bnFPai6BtY9zAjb35+1So1bdhqcvBkLMgRLvbcX7Q/Lqr7dx26MzPGrLx
	 ZGC5NBXhH0aJXkoliKsGFd2DGAzdnicHMpIVxUrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfGZH2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfGZH2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:28:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68FBC206BF;
        Fri, 26 Jul 2019 07:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564126093;
        bh=i/TsQG/aRjGtN08pB108hr1+zVTBvheG4HDu8u51ElY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QDes1G37ElaM+GFNGJYAcx/3kdsvf2MlcCI1yWqCdqbSirrh3qyuZGyIG/Fho+m8j
         DLZF0x3ivf81FOJcT/bcIf0QcwlPePr2qKa6Va+Ax9PAPPQ3DV8ozicYPZksql3Z7n
         tWVUEyqDXXRVPKk3i/tumBnygJ3Uwbmd035/TmW4=
Date:   Fri, 26 Jul 2019 09:28:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jeyentam <je.yen.tam@ni.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
Message-ID: <20190726072811.GA3073@kroah.com>
References: <20190726072226.6357-1-je.yen.tam@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726072226.6357-1-je.yen.tam@ni.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 03:22:26PM +0800, jeyentam wrote:
> Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> 
> Signed-off-by: Je Yen Tam <je.yen.tam@ni.com>

"From:" name does not match the Signed-off-by: name :(

