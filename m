Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9884EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B746218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LUNHYUT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfDXGWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:22:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDXGWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wNY84OSRffDR8TBCC4h4Uk9tLamjDKJpnS1779gx7b4=; b=LUNHYUT2BlXyedocIbng7lSTm
        BEwbTx59D2PwBdaMExFuPtnAT+fZWyaKiGpcWLSsrY2uF0wQuoQn8OOlVLtffjTbYgEQCqCT36fl9
        2ALQKk38M17KCKZLfnZP+sYcHa8xeLPK67fT49lNpQEIsXDMO4yL7DewyvffRxroAyobgHCSm2npW
        u/BbG551P1rxkUuq+IK2Z9OZzJ3xtN8gosk26UEe94fhQYwc8O1eByNL01lRedCjg5AmJAYDQ2FK8
        xk3ho7Op+NAqgnn3x4ogjZ1qlLD0H01/Loe6+dc0cD0ibQ4ZvWRTwh7il1TwA7mJRfGXmK7F2hZTY
        Hu1B5GBaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJBIO-0002Wl-8t; Wed, 24 Apr 2019 06:22:16 +0000
Date:   Tue, 23 Apr 2019 23:22:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Johan Hovold <johan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 3/3] RISC-V: Support nr_cpus command line option.
Message-ID: <20190424062216.GD3902@infradead.org>
References: <20190424000227.3085-1-atish.patra@wdc.com>
 <20190424000227.3085-4-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424000227.3085-4-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 05:02:27PM -0700, Atish Patra wrote:
> If nr_cpus command line option is set, maximum possible cpu should be
> set to that value.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
