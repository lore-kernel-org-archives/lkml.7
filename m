Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF761C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 07:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8129D2075C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 07:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573974887;
	bh=x0TTfEx8G9wpLcyr2LJaN4x/iCxAjQEPMWQAh24eTIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xy6gsutfnVqbbjk9Z1ydB/Vlmeh6XlbSFyB5GPotaNhBupHpyNXgIX/cqAJUTKMbr
	 jgocBVIcVTZB0Z4N7WSnVUFLaZlbw1C5GEWLKp2abbxjihp3bDJFk+a2L2iQZMv7uZ
	 O5ausU89OZR7SlCnRbK1DMyoRXOtG9gM9VNnEhJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfKQHOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 02:14:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfKQHOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 02:14:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D6020740;
        Sun, 17 Nov 2019 07:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573974885;
        bh=x0TTfEx8G9wpLcyr2LJaN4x/iCxAjQEPMWQAh24eTIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBgXd4n0HN/3B55qLCSZPE0eyW3AZP3k3Hfek6HYPG+F81Gz1zQ8VDoEb/gDUSqfQ
         3w0nbINR+gQPe9K/eLk7IdfMjbfpH6F96TMG8PSHyihiTbaRNLhgr8PGK6+6iTluHo
         W/ZA6Efbnuifha0mZnKQKKPASSmnu6/V6pfU6RYk=
Date:   Sun, 17 Nov 2019 08:14:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Suwan Kim <suwan.kim027@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Johan Hovold <johan@kernel.org>,
        Nicolas Boitchat <drinkcat@chromium.org>
Subject: Re: [PATCH 0/2] usb: override hub device bInterval with device node
Message-ID: <20191117071442.GC496402@kroah.com>
References: <20191117033149.259303-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191117033149.259303-1-ikjn@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 11:31:49AM +0800, Ikjoon Jang wrote:
> This patchset enables hard wired hub device to use different bInterval
> from its descriptor when the hub has a combined device node.

If it is a hard-wired hub, why can't you change that interval in the
firmware for that hub as you (as a platform owner) have control over
that?

thanks,

greg k-h
