Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11B5C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00B621872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jrMPGM4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfCOIzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:55:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfCOIzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zrbSM+zZL8hmU6BRqZKI68vqHhsw9mbPeKfHMFDTkrs=; b=jrMPGM4jlN3LGGmsEXF3ZgYJE
        BnUVxtivXKX8LOMDt1Z7HwgZXBXDYl5fgNODwAJKE59DlbfTK/mMeBmd+TvXyCNpqj4kkCJz/ocyf
        0ZHTUXmTLk+FS6POuvjMtjnxlY7TqcSwiUZD8dzR77GeR68G0RpUW0TgWVzKieBi76hzRLPP3ZkKu
        +we0TdDlaA4M0bwT95feqtoRoQ19TfgX/rVrZyzNyKcUjEFTgqVNaBvhW0IRyqqQvh2F+bznwIiJ7
        cpKdiuRj/nlwKR9lVyKmsC8GBkkKpr1XtW1Xa6qmGzCraie5kIBW7RvbN74YXdXRUDXlkFcKpQa7+
        VqKEdBkPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4ice-0002gN-Gg; Fri, 15 Mar 2019 08:55:24 +0000
Date:   Fri, 15 Mar 2019 01:55:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
Message-ID: <20190315085524.GB4470@infradead.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-2-git-send-email-john.stultz@linaro.org>
 <CA+M3ks57qbTwQiBSiChZmn_Z_O0r9bWZVd0wKkz+2WZeNyZBmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+M3ks57qbTwQiBSiChZmn_Z_O0r9bWZVd0wKkz+2WZeNyZBmw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

please fix your mailer to avoid completely pointless full quotes.

Thank you!
