Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8667C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8065A2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TA9iSrgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfDXGDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:03:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfDXGDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1bUUaeg2ogwwxvPB5HYKO9MxTs4KwKW6Ts8ePsW7l10=; b=TA9iSrgt+w6IIpI78cNjXFmjV
        RiUvjIjBffQSjw+JxFI1PgJ5+zasYKHADlQe4TFA4Fg+FSval8BMPq2TIGzVIIlOpY7+drewc4ZII
        VZn9bR9wRTEKxSq4/aOLIQc8qbv02svuiGzU38dlaZoeV2nm73OnXJdMVynG/oh4gkY59fxB3Sn2v
        v+4l6+cN4ekq6Vg9RFNbttBjRBVLALok4PXWaz/KUpqMdnXrgNMSdYfgEGELRanGF2ZR642K0bC4c
        RWSEDIJcw6ybSrw5OXeDg6+fnx+S4ogV+rDe30UQK0sLYo6s8bklhdEdHhmeQkiL+cLnBnz2v51ze
        yF9AFT+FQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJAzf-0004vK-LL; Wed, 24 Apr 2019 06:02:55 +0000
Date:   Tue, 23 Apr 2019 23:02:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Rik Faith <faith@cs.unc.edu>,
        "David A . Hinds" <dahinds@users.sourceforge.net>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] fdomain: Resurrect driver (PCI support)
Message-ID: <20190424060255.GB5506@infradead.org>
References: <20190422173323.15365-1-linux@zary.sk>
 <20190422173323.15365-3-linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422173323.15365-3-linux@zary.sk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine (modulo the potentional Kconfig tweak mentioned for the
previous patch):

Reviewed-by: Christoph Hellwig <hch@lst.de>
