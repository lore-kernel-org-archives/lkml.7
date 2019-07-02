Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBE2C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398F7206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r6GDjiEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGBNX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:23:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBNX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=r6GDjiEneio/iqV82AHgbIDPa
        n61HLFky26SoDFSpICZbHyMNW378pVJ7SaIhIb+n4qi/2yaIah9Tz1hkcGX4vvoVUgQLBpJRpWPdI
        Te1gITTjV0+vBN/LgdLA2h7mXxYME53Nn7PPWgB0SvDTJaAZTdeqV92BT5CbeISs7Q/HR1XpAsP7c
        iUhFmccY9lZWMUpxFuI/mUj++lN6HPb9/T3zl3sRZtAFgf/jJLvCKMe2Ari4hmmilxzamGUEjuUDw
        XieQ0THOvd3fFJQC/rz9i0ZsgRdtzk8/dkORdBvImStB3SN0swqRrsqoDbqTfKqkqz4NpDIW9SFq8
        DuqHhgbIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hiIkN-0004aM-BP; Tue, 02 Jul 2019 13:22:59 +0000
Date:   Tue, 2 Jul 2019 06:22:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/2] x86, arm64: Move ARCH_WANT_HUGE_PMD_SHARE config
 in arch/Kconfig
Message-ID: <20190702132259.GA17480@infradead.org>
References: <20190701175900.4034-1-alex@ghiti.fr>
 <20190701175900.4034-2-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701175900.4034-2-alex@ghiti.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
