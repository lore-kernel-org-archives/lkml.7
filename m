Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C5EC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B106921721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KTD6HJiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfDMHye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 03:54:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfDMHye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 03:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u77JNfukERnstE7rIHVu6zDnmYgARJvpXGm/qhI+TYE=; b=KTD6HJiEzyqA2ulYGY/SzKPTT
        hK8pQZvDyPFqiyMHXlZggOmG4I9fmsIiSb0p6Hg9nlhk1MGNdTfW/Qh7iH9FjNL2zTvutGUE3484N
        mePoXJiHuA3zOkgMxtnjyokyvtQnvXuTv8pBu5u05AZMUhVF7qHkrE0qpiJs6KDsEXgpJTgQRWBlJ
        DyEEde8L4zi4N9qA5NBXzF3KJ2tzh8+qKwYwSWGlojJZCBjabCiDqYbwMaGQILdHRolTR0rXEPf6H
        0dhDpsB6KCNoF1QCbapzrgydPbPyy8ujIP/9uFie/8TzgBf7oFnTsGckwqQB2CEIIqSQ0r0mll6cg
        yuowcUxrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFDUf-00087C-5f; Sat, 13 Apr 2019 07:54:33 +0000
Date:   Sat, 13 Apr 2019 00:54:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 2/3] RISC-V: Add defines for CSR numbers
Message-ID: <20190413075433.GB30428@infradead.org>
References: <20190413073906.53676-1-anup.patel@wdc.com>
 <20190413073906.53676-3-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413073906.53676-3-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think this should be merged with the next patch.  Also please
only add the CSRs that we actually use.
