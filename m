Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF18CCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40852087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572442216;
	bh=L5QKlFo0o/6trqkO7iwbbaOCu25j8+zykAXcg88WqhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xs1WbiEkUO33uMSvO7t/8MOeKrj4w1MsqWjLCPuCC5LBA6CJah96LRj+sWc6fN8aO
	 Wlvcj9mtkgd4rf60liE2wgn7AsvASx1pavJ//eTjkh3c3GOpjplIxQ2Mkx0KX0126A
	 4BaJR1gMKJPPKFhjJ+b/QFXfgxOQFMXCim0nDeCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfJ3NaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfJ3NaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:30:15 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ED3620856;
        Wed, 30 Oct 2019 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572442214;
        bh=L5QKlFo0o/6trqkO7iwbbaOCu25j8+zykAXcg88WqhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CGpGt+OThztPYV1iR7gVQX5i8lwTUN8qTXieFeQgl86VhCvsF8XjyqjZ3uAV71DzS
         LNijEqrnUPkBpEPXBq6AuHnywXmj5achO/YLyIN2nJKI4halfp4niPcWl0tb9HCDAO
         l6humSpIjV1711BAhbvW4XJalFZoEg7JkttQhmro=
Date:   Wed, 30 Oct 2019 14:30:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     felipe.balbi@linux.intel.com, pawell@cadence.com,
        peter.chen@nxp.com, nsekhar@ti.com, kurahul@cadence.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: cdns3: gadget: Fix g_audio use case when
 connected to Super-Speed host
Message-ID: <20191030133011.GA703854@kroah.com>
References: <20191029151514.28495-1-rogerq@ti.com>
 <20191030121607.21739-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030121607.21739-1-rogerq@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 02:16:07PM +0200, Roger Quadros wrote:
> Take into account gadget driver's speed limit when programming
> controller speed.
> 
> Fixes: commit 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")

No need for "commit", doesn't the documentation say the correct format?
I haven't looked in a while...

I can edit it out this time...

greg k-h
