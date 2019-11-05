Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C38CA9EC9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1E320848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kmNkDjrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfKEAB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:01:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbfKEAB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TO2eOiS4yp9XeP4RDKM23cRX2kba3mHm/rvOSVnBGjc=; b=kmNkDjrT6P60IuU6ebCJT5SCH
        CuaX20e62rpiK819CnqbDTme4QqXvO2hc2poiVIkEWI7gQUtjA0k/m64w+KuxE/4w3JSpPuGxVVOu
        QgNgRQ+7XjPh+XjienJYw3ykn5wmskQOLySqLDuAs5ybkeBMoITBJiOzwYjsuMzopdmmirAbfNyfu
        Xo43p6CJM74SYpSjqb+jY0r5F/IM1rmAtCfWD91K9Op6Qdju7u9PQlCl4u9fd61zvAODHY6zlavcO
        IFP/WpiDzQoWK8Iw8BYeqNyBZBd5O3atgY31h55iqR901km73tDfbxCh4TwsCVUpLMQlTmWbMIr3I
        trKfpLQMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRmHi-00078c-Qq; Tue, 05 Nov 2019 00:01:22 +0000
Date:   Mon, 4 Nov 2019 16:01:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Max Staudt <max@enpas.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] m68k: defconfig: Update defconfigs for v5.4-rc1
Message-ID: <20191105000122.GA22359@infradead.org>
References: <20191001073539.4488-1-geert@linux-m68k.org>
 <7fa02d50-6092-5f59-5018-c5b425a30726@enpas.org>
 <CAMuHMdX3+-JO68LGE-NuT9axRUj3=bbtpDZ8E3v5UNoj5ctLHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX3+-JO68LGE-NuT9axRUj3=bbtpDZ8E3v5UNoj5ctLHg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 12:06:05PM +0100, Geert Uytterhoeven wrote:
> Amiga is fine.
> 
> Mac and Q40 are not, apparently.

Can any users of those legacy ide drivers please get in contact
with Bartlomiej Zolnierkiewicz to ensure we have a tested libata
driver quickly?
