Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E79C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12543206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KHOIjA9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbfDXGVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:21:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfDXGVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1Fv91G1W6r/Keg5N/of7tsmV7rm01oISNszMPhG9TTg=; b=KHOIjA9wNM6KLQKnbLEQhxzQc
        970lfTr8yiNNsEtFifLbQgeX9Mw7DHJkGsmFrZxsv6Mxlg04g7CPFZwFVWsztwmnCtbKjOIVHP9Xp
        AHpdo0+DdiLYObIjUv9c1wIp5uFjQOkPqkNjX5D5cdKb9X7DHVKAw4wYWc2TLO7WmRCA9Re5Jult6
        tdurpsXV0dfiSeRy9P31Ka1qmszHCQVh162oVIf8m8BUdaLxR59V+cTo+dPOQAPHc80D8r9/PMVON
        dGU1PC6UxeEm4xMgoCxJdGA2EMIrzOs7/l6pxPWpKP+VDUWMqzQPU+v+B/ZnvBAazLVuVmf2Q9qLN
        R3uDnE++Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJBHA-0002I3-OL; Wed, 24 Apr 2019 06:21:00 +0000
Date:   Tue, 23 Apr 2019 23:21:00 -0700
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
Subject: Re: [PATCH v3 1/3] RISC-V: Add RISC-V specific arch_match_cpu_phys_id
Message-ID: <20190424062100.GB3902@infradead.org>
References: <20190424000227.3085-1-atish.patra@wdc.com>
 <20190424000227.3085-2-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424000227.3085-2-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  }
> +
> +bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
> +{
> +	return phys_id == cpuid_to_hartid_map(cpu);
> +}
>  /* Unsupported */

Please keep an empty line after function bodys.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
