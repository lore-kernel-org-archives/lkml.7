Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB29C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AB2206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="d/OYnJgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbfJHUuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 16:50:05 -0400
Received: from mail.nic.cz ([217.31.204.67]:48052 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730674AbfJHUuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:50:04 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id E3BAE140E3E;
        Tue,  8 Oct 2019 22:50:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1570567803; bh=kkT366TqLTz6ZShDaMjzSLfYLU+lLy2kRMtQYV9bCEM=;
        h=Date:From:To;
        b=d/OYnJgQdi/E6twtZrnoYU2giwUHogwREFg1dWJcDTnY56CbfuA4A8ruxJMMTR+m8
         3BuX0+NCfxQroPYzhYk7K+92f+PS4b4hFxszIH04wAXFGJq68pVmf5Kgp6srORERR5
         B/4/fV+VE2lzGe0qihObaIww56xNTFeExBjcSVrg=
Date:   Tue, 8 Oct 2019 22:50:02 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: linux-next: Fixes tags need some work in the mvebu tree
Message-ID: <20191008225002.5b95efdf@nic.cz>
In-Reply-To: <20191009073803.633c02b5@canb.auug.org.au>
References: <20191009073803.633c02b5@canb.auug.org.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.3 at mail.nic.cz
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 07:38:03 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> In commit
> 
>   69eea31a26da ("arm64: dts: armada-3720-turris-mox: convert usb-phy to phy-supply")
> 
> Fixes tag
> 
>   Fixes: eb6c2eb6c7fb ("usb: host: xhci-plat: Prevent an abnormally
> 

This is weird, in the patch I sent the tag ends there with ...")

Marek
