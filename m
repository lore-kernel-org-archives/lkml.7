Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB01DC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF3220449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698928;
	bh=g2MELxiCT8LdfV8Vfjq3DI49Fm9nMwYMCbQucrOIDlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SbgPVjczSVqnAnQUV59xI4sBU8b6UOF1RVLK1xmPMNaMnvENWcPBD/JQOjcg7hdBk
	 TEDM3NQS0PIdksEvKYSRt/xbDcE9xmTwXf86hPfaH82EXfc65zIsBwed+P177mNgWm
	 PZEsJJnAygGw1kQ69wh7hQI8oi8q+9HoFbIwl2Uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfDSSf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbfDSS3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C348B218CD;
        Fri, 19 Apr 2019 09:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555667877;
        bh=g2MELxiCT8LdfV8Vfjq3DI49Fm9nMwYMCbQucrOIDlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ioDaxBHLKmM10Gl6QMXy8WvOLOIKxy6KMsK+vXG0Zb93jVd+xQiuMCGhFWzaFNncT
         zeGc3Y8i9rLSKZbO/6IoyvhybaA698URccf+eJxK7avZl3DqavXDP2Yk58c50/ad4D
         GSfFG3tfk3rtt1kxLeB7cdIkob+TxGZIThbnWRVU=
Date:   Fri, 19 Apr 2019 11:57:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs next for 5.2
Message-ID: <20190419095731.GA16023@kroah.com>
References: <20190419094909.GA22155@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419094909.GA22155@ogabbay-VM>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 12:49:09PM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> This is the major pull request for habanalabs driver for kernel 5.2.
> 
> All of the patches were submitted more then a couple of weeks ago and were
> in my repository at fdo which is being checked by the Intel kbuild robot,
> so I believe they are clean in terms of compilation in different
> architectures.

Pulled and pushed out, thanks.

greg k-h
