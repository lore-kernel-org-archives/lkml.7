Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989CBC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A87E217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558528103;
	bh=8+ON6xc7MF+ElUMANsWO5KBak8Ucahh+C2K3SpPKaZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EbhE7mV34jdPZ8XUdnCW/hh7ZMH87YFErZPR2uHy/knKX9DD4n40Y2DqJqBQrVxN2
	 htVk511gKkYhDQ1mmER5WVmhY7Lt2oxGdCs86bgk/7oL8S+l8DRyAPTg26gK98XUqT
	 HMX4QTK2Z2Fzugi061gzrIbhhCHxFPJQbY0yoezc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfEVM2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbfEVM2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:28:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 221032173C;
        Wed, 22 May 2019 12:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558528101;
        bh=8+ON6xc7MF+ElUMANsWO5KBak8Ucahh+C2K3SpPKaZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPlYwDRvn+p12SaYYTrR+s92aO4WfQtf+QU2xGWtx7plFLafhqkB0OhDMtcx1bZsc
         nZjV0jVHXbo17G0Cw/hUvg2icDcfl32jZrPaoSsTIM7Jcuv+ZVyNyfo7pENhKupFTl
         G5PDfJvHPlZ2w4Zs6UXhHtnW9xw+niBnnbaFyKCI=
Date:   Wed, 22 May 2019 14:28:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geordan Neukum <gneukum1@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 0/6] Minor updates to kpc_i2c driver and kpc2000 core
Message-ID: <20190522122819.GA15130@kroah.com>
References: <cover.1558526487.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558526487.git.gneukum1@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 12:13:56PM +0000, Geordan Neukum wrote:
> Attached are an assortment of minor updates to the kpc_i2c driver as
> well as a build fix for all of those who will need the KPC2000 core.

Nit, please put "staging" in your 0/6 patch to make it easier for
scripts to pick this up properly.  For next time please.

thanks,

greg k-h
