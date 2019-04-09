Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BEDC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888162084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rpeVH8/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDIKzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:55:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34412 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDIKza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OJtlOG6cNO0fFy9CM3Of8sfD8o1huI2fPIic6jgCYYU=; b=rpeVH8/ma76jbjnG1mZj4NMPb
        WGQ3r8suuBYMPg7GkqdT6TCdZpNd4hEU9Il8M2NbQv17FeYbyNPnhFjB6gvfILVG1ILbHeAMKalC6
        yhk0X4hIUS+GVSTgeSvBb5TVRSXVecd0iXjy/S/NrPSxJieRd5wSOVzPOnEz42HbBQS4u281wh8Ke
        /KIe/Qi9+UVGJ/gUqAiageYNR4bcGyCylaNdWYLpWaz8fipn0HLTJVpnPSteoi/tMeUKJllXq6Ngp
        UcufVdYVuyqPU+vKJKNU5L+faPzNgD0sDvT4VqScd/NFVwimBMIwe0qg3WAm1cG2JAvo0NuoFdCmV
        0rqF0abbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDoPZ-0008GT-2F; Tue, 09 Apr 2019 10:55:29 +0000
Date:   Tue, 9 Apr 2019 03:55:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Rik Faith <faith@cs.unc.edu>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fdomain: Resurrect fdomain and fdomain_cs drivers
Message-ID: <20190409105528.GA12779@infradead.org>
References: <20190407185617.8467-1-linux@zary.sk>
 <20190407185617.8467-2-linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407185617.8467-2-linux@zary.sk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 08:56:16PM +0200, Ondrej Zary wrote:
> This reverts commit e184f2bf4d9f1a3c612a8c1d67e73e9cf8ab5ab9.
> It does not compile but following patches will fix that.

Please just resurrect it as a proper driver that fits modern standards,
including the coding style.  To make your life much easier I'd suggest
you do that for the PCI devices only and leave the rest behind.
